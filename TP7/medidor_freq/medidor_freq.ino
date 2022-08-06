volatile unsigned long timerCounts;
volatile boolean counterReady;
unsigned long overflowCount;
unsigned int timerTicks;
unsigned int timerPeriod;

void startCounting (unsigned int ms)  //cuenta ticks en un intervalo de ms pasado como argumento
{
  counterReady = false;
  timerPeriod = ms;
  timerTicks = 0;
  overflowCount = 0;

  // resetea timer1 y timer2
  TCCR1A = 0;             
  TCCR1B = 0;              
  TCCR2A = 0;
  TCCR2B = 0;

  TIMSK1 |= (1<<TOIE1);   // habilita interrupción por overflow en el timer 1

  // 16 MHz (62.5 nanosegundos por tick) con preescalado de 128 el contador incrementa cada 8 microsegundos. 
  // 125 ticks = 1 ms
  TCCR2A |= (1<<WGM21) ;   // timer 2 modo CTC (match)
  OCR2A  = 124;            // interrumpe cuando llega a 125 (cero incluído)

  TIMSK2 |= (1<<OCIE2A);   // habilita interrupción por match en timer 2

  // resetea el registro de los contadores 1 y 2
  TCNT1 = 0;
  TCNT2 = 0;     

  GTCCR |= (1<<PSRASY);        // sacar preescalado
  TCCR2B |= (1<<CS20) | (1<<CS22) ;  // usar preescalado de 128
  
  TCCR1B |=  (1<<CS10) | (1<<CS11) | (1<<CS12);   // detecta flanco ascendente en pin T1 (D5)
}

ISR (TIMER1_OVF_vect)   // función de callback para interrupción de overflow del timer 1
{
  ++overflowCount;               // cuenta la cantidad de overflows en el timer 1
}

ISR (TIMER2_COMPA_vect)   // función de callback para interrupción de comparación del timer 2
  {
  unsigned int timer1CounterValue;
  timer1CounterValue = TCNT1;
  unsigned long overflowCopy = overflowCount;

  if (++timerTicks < timerPeriod) 
    return;

  // chequea si se perdió un overflow
  if ((TIFR1 & (1<<TOV1)) && timer1CounterValue < 256)
    overflowCopy++;

  TCCR1A = 0;    
  TCCR1B = 0;    

  TCCR2A = 0;    
  TCCR2B = 0;    

  TIMSK1 = 0;    
  TIMSK2 = 0;    
    
  // calcula
  timerCounts = (overflowCopy << 16) + timer1CounterValue;  // (PROBAR overflowCopy * 65536)
  counterReady = true;             
  }

void setup () 
{
  Serial.begin(115200);       
  Serial.println("Frequency Counter");
}

void loop () 
{
  String unit;
  
  startCounting (500);

  while (!counterReady) { }

  float frq = (timerCounts *  1000.0f) / timerPeriod;
  if(frq < 1000.0) unit = "Hz.";
  else if(frq < 1000000.0f)
  {
    unit = "kHz.";
    frq = frq/1000.0f;
  }
  else
  {
    unit = "MHz.";
    frq = frq/1000000.0f;
  }

  Serial.print ("Frequency: ");
  Serial.print (frq);
  Serial.println (unit);
}