# 1 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
# 2 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino" 2
# 56 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
int pinBuz = 11;
int pinBtn = 8;
int pinLED[] = {0,1,2,3,4,5,6,7};
int *melodia, cantNotas, nota = 0;
int cantEstados[7] = {17,14,8,8,8,0,0};
int btnCount, state, pulsado = 0;
unsigned long t1 = 0, elapsed = 0;
bool mode = 0, finMelodia = 0, reset = 0;

int divider = 0, noteDuration = 0;
//duración de una nota completa
int wholenote = (60000 * 4) / 140;

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
  pinMode(13, 0x1);
  pinMode(pinBuz, 0x1);
  pinMode(pinBtn, 0x1);
  for(int i = 0; i < 7; i++)
    pinMode(pinLED[i], 0x1);
  btnCount = 11;
  state = 0;
}

void loop() {
  if(mode){
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
    }else
    {
      for(int i = 0; i < 8; i++) digitalWrite(pinLED[i], 0x0);
      digitalWrite(13, !digitalRead(13));
    }
    delay(200);
  }else
  {
    if(antiRebote(pinBtn))
    {
      t1 = millis();
      while((millis() - t1) < 1000)
      {
        if(antiRebote(pinBtn))
          reset = true;
      }
      if(!reset)
      {
        if(btnCount < 2) btnCount++;
        else btnCount = 0;
      }else
      {
        reset = false;
        btnCount = 3;
      }
      nota = 0;
    }
    switch (btnCount)
    {
    case 0:
      cantNotas = sizeof(felizcumple) / sizeof(int) / 2;
      finMelodia = reproducir(felizcumple,nota);
      break;
    case 1:
      cantNotas = sizeof(takeonme) / sizeof(int) / 2;
      finMelodia = reproducir(takeonme,nota);
      break;
    case 2:
      cantNotas = sizeof(lcdtmAllBoys) / sizeof(int) / 2;
      finMelodia = reproducir(lcdtmAllBoys,nota);
      break;
    default:
      digitalWrite(13, !digitalRead(13));
      delay(100);
      break;
    }
    if(!finMelodia) nota = nota+2;
    else nota = 0;
  }
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

bool reproducir(int melodia[], int nota)
{
  // el vector de la canción tiene un largo de 2*notas, porque guarda la duracion correspondiente
  if(nota < cantNotas * 2) {

    // calcula la duración de la nota
    divider = melodia[nota + 1];
    if (divider > 0) {
      noteDuration = (wholenote) / divider;
    } else if (divider < 0) {
      // las notas prolongadas más de un tiempo se representan con número negativos
      noteDuration = (wholenote) / ((divider)>0?(divider):-(divider));
      noteDuration *= 1.5; // incrementa la duración por la mitad
    }
    // suena la nota el 90% del tiempo estipulado y el resto es una pequeña pausa entre notas
    tone(pinBuz, melodia[nota], noteDuration * 0.9);
    // espera el tiempo que dura la nota
    delay(noteDuration);
    // detiene la nota antes de la siguiente
    noTone(pinBuz);
    return false;
  }else return true;
}
