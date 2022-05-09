# 1 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
# 2 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino" 2
# 3 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino" 2







int pinLED[] = {0,1,2,3,4,5,6,7};
int cantNotas, nota = 0;
int cantEstados[7] = {9,9,8,8,8,11,11};
int i, btnCount, state, pulsado = 0;
float t1 = 0, elapsed = 0;
bool finMelodia = 0, reset = 0;

int secuencia[7][11][8] = {
  {
    {0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,1},
    {0,0,0,0,0,0,1,1},
    {0,0,0,0,0,1,1,1},
    {0,0,0,0,1,1,1,1},
    {0,0,0,1,1,1,1,1},
    {0,0,1,1,1,1,1,1},
    {0,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1}
  },
  {
    {1,1,1,1,1,1,1,1},
    {0,1,1,1,1,1,1,1},
    {0,0,1,1,1,1,1,1},
    {0,0,0,1,1,1,1,1},
    {0,0,0,0,1,1,1,1},
    {0,0,0,0,0,1,1,1},
    {0,0,0,0,0,0,1,1},
    {0,0,0,0,0,0,0,1},
    {0,0,0,0,0,0,0,0}
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
    {0,0,0,0,0,0,0,0},
    {1,0,0,0,0,0,0,1},
    {0,1,0,0,0,0,1,0},
    {0,0,1,0,0,1,0,0},
    {0,0,0,1,1,0,0,0},
    {1,0,0,1,1,0,0,1},
    {0,1,0,1,1,0,1,0},
    {0,0,1,1,1,1,0,0},
    {1,0,1,1,1,1,0,1},
    {0,1,1,1,1,1,1,0},
    {1,1,1,1,1,1,1,1}
  },
  {
    {1,1,1,1,1,1,1,1},
    {0,1,1,1,1,1,1,0},
    {1,0,1,1,1,1,0,1},
    {0,0,1,1,1,1,0,0},
    {0,1,0,1,1,0,1,0},
    {1,0,0,1,1,0,0,1},
    {0,0,0,1,1,0,0,0},
    {0,0,1,0,0,1,0,0},
    {0,1,0,0,0,0,1,0},
    {1,0,0,0,0,0,0,1},
    {0,0,0,0,0,0,0,0}
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

int lacucaracha[] = {

  392,8, 392,8, 392,8, 523,4, 659,8, 0,4,
  392,8, 392,8, 392,8, 523,4, 659,8, 0,4,
  262,4, 262,8, 494,8, 494,8, 440,8, 440,8, 392,8, 0,8,
  392,8, 392,8, 392,8, 494,4, 587,8, 0,4,
  392,8, 392,8, 392,8, 494,4, 587,8, 0,4,
  392,4, 440,8, 392,8, 349,8, 330,8, 294,8, 262,8, 0,8,

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

void setup() {
  pinMode(13, 0x1);
  pinMode(11, 0x1);
  pinMode(8, 0x1);
  for(i = 0; i < 7; i++)
    pinMode(pinLED[i], 0x1);
  btnCount = 10;
  state = 0;
}

void loop() {
  if(digitalRead(10))
  {
    if(!digitalRead(8)) t1 = millis();
    else elapsed = millis() - t1;
    if(elapsed > 10)
    {
      if(elapsed > 1000) btnCount = 10;
      else{
        if(btnCount >= 10 -1) btnCount = 0;
        else btnCount++;
      }
      elapsed = 0;
    }
    if(btnCount < 7)
    {
      for(int i = 0; i < 8; i++)
        digitalWrite(pinLED[i],secuencia[btnCount][state][i]);
      if(state >= cantEstados[btnCount]-1) state = 0;
      else state++;
    }else if(btnCount < 10)
    {
      int secMemPos = (btnCount-7)*(11 +1);
      int cantEstadosMem = EEPROM.read(secMemPos);
      for(i = 0; i < 8; i++)
        digitalWrite(pinLED[i], (((EEPROM.read(secMemPos+state+1)) >> (i)) & 0x01));
      if(state >= cantEstadosMem-1) state = 0;
      else state++;
    }else
    {
      for(int i = 0; i < 8; i++) digitalWrite(pinLED[i], 0x0);
      digitalWrite(13, !digitalRead(13));
    }
    delay(100);
  }else
  {
    if(antiRebote(8))
    {
      t1 = millis();
      while((millis() - t1) < 500)
      {
        if(antiRebote(8))
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
      cantNotas = sizeof(lacucaracha) / sizeof(int) / 2;
      finMelodia = reproducir(lacucaracha,nota);
      break;
    case 2:
      cantNotas = sizeof(takeonme) / sizeof(int) / 2;
      finMelodia = reproducir(takeonme,nota);
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
  int divider = 0, noteDuration = 0;
  // el vector de la canción tiene un largo de notas*2, porque guarda la duración correspondiente a cada nota
  if(nota < cantNotas * 2) {

    // calcula la duración de la nota
    divider = melodia[nota + 1];
    if (divider > 0) {
      noteDuration = (((60000 * 4) / 140) /*duración de una nota completa*/) / divider;
    } else if (divider < 0) {
      // las notas prolongadas más de un tiempo se representan con números negativos
      noteDuration = (((60000 * 4) / 140) /*duración de una nota completa*/) / ((divider)>0?(divider):-(divider));
      noteDuration *= 1.5; // incrementa la duración por la mitad
    }
    // suena la nota el 90% del tiempo estipulado y el resto es una pequeña pausa entre notas
    tone(11, melodia[nota], noteDuration * 0.9);
    // espera el tiempo que dura la nota
    delay(noteDuration);
    // detiene la nota antes de la siguiente
    noTone(11);
    return false;
  }else return true;
}
