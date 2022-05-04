# 1 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
# 2 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino" 2
# 55 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
int pinBuz = 11;
int pinBtn = 8;
int pinLED[] = {0,1,2,3,4,5,6,7};
int *melodia;
int notas;
int cantEstados[7] = {17,14,8,8,8,0,0};
int btnCount, state, pulsado = 0;
unsigned long t1, elapsed = 0;

int secuencia[7][17][8] = {
  {
    {0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,1},
    {0,0,0,0,0,0,1,1},
    {0,0,0,0,0,1,1,1},
    {0,0,0,0,1,1,1,1},
    {0,0,0,1,1,1,1,1},
    {0,0,1,1,1,1,1,1},
    {0,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1},
    {0,1,1,1,1,1,1,1},
    {0,0,1,1,1,1,1,1},
    {0,0,0,1,1,1,1,1},
    {0,0,0,0,1,1,1,1},
    {0,0,0,0,0,1,1,1},
    {0,0,0,0,0,1,1,1},
    {0,0,0,0,0,0,1,1},
    {0,0,0,0,0,0,0,1}
  },
  {
    {1,0,0,0,0,0,0,0},
    {0,1,0,0,0,0,0,0},
    {0,0,1,0,0,0,0,0},
    {0,0,0,1,0,0,0,0},
    {0,0,0,0,1,0,0,0},
    {0,0,0,0,0,1,0,0},
    {0,0,0,0,0,0,1,0},
    {0,0,0,0,0,0,0,1},
    {0,0,0,0,0,0,1,0},
    {0,0,0,0,0,1,0,0},
    {0,0,0,0,1,0,0,0},
    {0,0,0,1,0,0,0,0},
    {0,0,1,0,0,0,0,0},
    {0,1,0,0,0,0,0,0},
  },
  {
    {1,0,0,0,0,0,0,1},
    {0,1,0,0,0,0,1,0},
    {0,0,1,0,0,1,0,0},
    {0,0,0,1,1,0,0,0},
    {0,0,0,1,1,0,0,0},
    {0,0,1,0,0,1,0,0},
    {0,1,0,0,0,0,1,0},
    {1,0,0,0,0,0,0,1}
  },
  {
    {0,0,0,0,0,0,0,0},
    {0,0,0,1,1,0,0,0},
    {0,0,1,1,1,1,0,0},
    {0,1,1,1,1,1,1,0},
    {1,1,1,1,1,1,1,1},
    {0,1,1,1,1,1,1,0},
    {0,0,1,1,1,1,0,0},
    {0,0,0,1,1,0,0,0}
  },
  {
    {0,0,0,0,0,0,0,0},
    {0,0,0,1,1,0,0,0},
    {0,0,1,1,1,1,0,0},
    {0,1,1,1,1,1,1,0},
    {1,1,1,1,1,1,1,1},
    {1,1,1,0,0,1,1,1},
    {1,1,0,0,0,0,1,1},
    {1,0,0,0,0,0,0,1}
  },
  {
    {0}
  },
  {
    {0}
  },
};

int felizcumple[] = {

  262,4, 262,8,
  294,-4, 262,-4, 349,-4,
  330,-2, 262,4, 262,8,
  294,-4, 262,-4, 392,-4,
  349,-2, 262,4, 262,8,

  523,-4, 440,-4, 349,-4,
  330,-4, 294,-4, 466,4, 466,8,
  440,-4, 349,-4, 392,-4,
  349,-2,

};

int takeonme[] = {

  740,8, 740,8,587,8, 494,8, 0,8, 494,8, 0,8, 659,8,
  0,8, 659,8, 0,8, 659,8, 831,8, 831,8, 880,8, 988,8,
  880,8, 880,8, 880,8, 659,8, 0,8, 587,8, 0,8, 740,8,
  0,8, 740,8, 0,8, 740,8, 659,8, 659,8, 740,8, 659,8,
  740,8, 740,8,587,8, 494,8, 0,8, 494,8, 0,8, 659,8,

  0,8, 659,8, 0,8, 659,8, 831,8, 831,8, 880,8, 988,8,
  880,8, 880,8, 880,8, 659,8, 0,8, 587,8, 0,8, 740,8,
  0,8, 740,8, 0,8, 740,8, 659,8, 659,8, 740,8, 659,8,
  740,8, 740,8,587,8, 494,8, 0,8, 494,8, 0,8, 659,8,
  0,8, 659,8, 0,8, 659,8, 831,8, 831,8, 880,8, 988,8,

  880,8, 880,8, 880,8, 659,8, 0,8, 587,8, 0,8, 740,8,
  0,8, 740,8, 0,8, 740,8, 659,8, 659,8, 740,8, 659,8,

};

int lcdtmAllBoys[] = {
  294,8, 330,8, 330,8, 330,8, 330,8, 330,4, 294,8, 349,4, 0,6,
  330,8, 294,8, 294,8, 294,8, 294,8, 294,4, 262,8, 330,4, 0,6,
  262,8, 262,8, 262,8, 262,8, 262,8, 262,4, 494,6, 294,4, 294,8,
  294,8, 262,8, 494,4, 220,8, 208,4, 208,8,
  208,8, 208,8, 220,4, 494,8, 220,4, 0,3,
};

void setup() {
  pinMode(pinBuz, 0x1);
  pinMode(pinBtn, 0x1);
  for(int i = 0; i < 7; i++)
    pinMode(pinLED[i], 0x1);
  melodia = felizcumple;
  notas = sizeof(felizcumple) / sizeof(int) / 2;
  btnCount = 11;
  state = 0;
}

void loop() {
  if(!digitalRead(pinBtn)) t1 = millis();
  else elapsed = millis() - t1;
  if(elapsed > 100)
  {
    if(elapsed > 1000) btnCount = 11;
    else{
      if(btnCount >= 10) btnCount = 0;
      else btnCount++;
    }
    elapsed = 0;
  }
  if(btnCount < 8)
  {
    for(int i = 0; i < 8; i++)
      digitalWrite(pinLED[i],secuencia[btnCount][state][i]);
    if(state >= cantEstados[btnCount]-1) state = 0;
    else state++;
  }else if(btnCount < 11)
  {
    int secMemPos = (btnCount-8)*(20+1);
    int cantEstadosMem = EEPROM.read(secMemPos);
    for(int i = 0; i < 8; i++)
      digitalWrite(pinLED[i], (((EEPROM.read(secMemPos+state+1)) >> (i)) & 0x01));
    if(state >= cantEstadosMem-1) state = 0;
    else state++;
  }else for(int i = 0; i < 8; i++) digitalWrite(pinLED[i], 0x0);
  delay(200);
}

bool antiRebote(int in)
{
  bool ret = false;
  if(digitalRead(in) == 0)
    pulsado = 1;
  if(pulsado && digitalRead(in))
  {
    ret = true;
    pulsado = 0;
  }
  return ret;
}

// change this to make the song slower or faster
int tempo = 140;

// this calculates the duration of a whole note in ms
int wholenote = (60000 * 4) / tempo;

int divider = 0, noteDuration = 0;

void reproducir()
{
  // iterate over the notes of the melody.
  // Remember, the array is twice the number of notes (notes + durations)
  for (int thisNote = 0; thisNote < notas * 2; thisNote = thisNote + 2) {

    // calculates the duration of each note
    divider = melodia[thisNote + 1];
    if (divider > 0) {
      // regular note, just proceed
      noteDuration = (wholenote) / divider;
    } else if (divider < 0) {
      // dotted notes are represented with negative durations!!
      noteDuration = (wholenote) / ((divider)>0?(divider):-(divider));
      noteDuration *= 1.5; // increases the duration in half for dotted notes
    }

    // we only play the note for 90% of the duration, leaving 10% as a pause
    tone(pinBuz, melodia[thisNote], noteDuration * 0.9);

    // Wait for the specief duration before playing the next note.
    delay(noteDuration);

    // stop the waveform generation before the next note.
    noTone(pinBuz);
  }
}
