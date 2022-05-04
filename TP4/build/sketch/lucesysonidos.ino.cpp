#include <Arduino.h>
#line 1 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
#include <EEPROM.h>
#include "notas.h"

#define MAX_ESTADOS 17
#define CANT_SEC    10
#define TEMPO 140
#define PIN_SLIDER 10
#define PIN_BUZZER 11
#define PIN_BUTTON 8
int pinLED[] = {0,1,2,3,4,5,6,7};
int cantNotas, nota = 0;
int cantEstados[7] = {17,14,8,8,8,11,11};
int btnCount, state, pulsado = 0;
float t1 = 0, elapsed = 0;
bool finMelodia = 0, reset = 0;

int divider = 0, noteDuration = 0;
//duración de una nota completa
int wholenote = (60000 * 4) / TEMPO;

int secuencia[7][MAX_ESTADOS][8] = {
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

  NOTA_C4,4, NOTA_C4,8, 
  NOTA_D4,-4, NOTA_C4,-4, NOTA_F4,-4,
  NOTA_E4,-2, NOTA_C4,4, NOTA_C4,8, 
  NOTA_D4,-4, NOTA_C4,-4, NOTA_G4,-4,
  NOTA_F4,-2, NOTA_C4,4, NOTA_C4,8,

  NOTA_C5,-4, NOTA_A4,-4, NOTA_F4,-4, 
  NOTA_E4,-4, NOTA_D4,-4, NOTA_AS4,4, NOTA_AS4,8,
  NOTA_A4,-4, NOTA_F4,-4, NOTA_G4,-4,
  NOTA_F4,-2,
 
};

int takeonme[] = {

  NOTA_FS5,8, NOTA_FS5,8,NOTA_D5,8, NOTA_B4,8, REST,8, NOTA_B4,8, REST,8, NOTA_E5,8, 
  REST,8, NOTA_E5,8, REST,8, NOTA_E5,8, NOTA_GS5,8, NOTA_GS5,8, NOTA_A5,8, NOTA_B5,8,
  NOTA_A5,8, NOTA_A5,8, NOTA_A5,8, NOTA_E5,8, REST,8, NOTA_D5,8, REST,8, NOTA_FS5,8, 
  REST,8, NOTA_FS5,8, REST,8, NOTA_FS5,8, NOTA_E5,8, NOTA_E5,8, NOTA_FS5,8, NOTA_E5,8,
  NOTA_FS5,8, NOTA_FS5,8,NOTA_D5,8, NOTA_B4,8, REST,8, NOTA_B4,8, REST,8, NOTA_E5,8, 
  
  REST,8, NOTA_E5,8, REST,8, NOTA_E5,8, NOTA_GS5,8, NOTA_GS5,8, NOTA_A5,8, NOTA_B5,8,
  NOTA_A5,8, NOTA_A5,8, NOTA_A5,8, NOTA_E5,8, REST,8, NOTA_D5,8, REST,8, NOTA_FS5,8, 
  REST,8, NOTA_FS5,8, REST,8, NOTA_FS5,8, NOTA_E5,8, NOTA_E5,8, NOTA_FS5,8, NOTA_E5,8,
  NOTA_FS5,8, NOTA_FS5,8,NOTA_D5,8, NOTA_B4,8, REST,8, NOTA_B4,8, REST,8, NOTA_E5,8, 
  REST,8, NOTA_E5,8, REST,8, NOTA_E5,8, NOTA_GS5,8, NOTA_GS5,8, NOTA_A5,8, NOTA_B5,8,
  
  NOTA_A5,8, NOTA_A5,8, NOTA_A5,8, NOTA_E5,8, REST,8, NOTA_D5,8, REST,8, NOTA_FS5,8, 
  REST,8, NOTA_FS5,8, REST,8, NOTA_FS5,8, NOTA_E5,8, NOTA_E5,8, NOTA_FS5,8, NOTA_E5,8,
  
};

#line 149 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
void setup();
#line 159 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
void loop();
#line 237 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
bool antiRebote(int in);
#line 250 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
bool reproducir(int melodia[], int nota);
#line 149 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(PIN_BUZZER, OUTPUT);
  pinMode(PIN_BUTTON, OUTPUT);
  for(int i = 0; i < 7; i++)
    pinMode(pinLED[i], OUTPUT);
  btnCount = 10;
  state = 0;
}

void loop() {
  if(digitalRead(PIN_SLIDER)){
    if(!digitalRead(PIN_BUTTON)) t1 = millis();
    else elapsed = millis() - t1;
    if(elapsed > 100)
    {
      if(elapsed > 1000) btnCount = 10;
      else{
        if(btnCount >= CANT_SEC-1) btnCount = 0;
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
      int secMemPos = (btnCount-7)*(MAX_ESTADOS+1);
      int cantEstadosMem = EEPROM.read(secMemPos);
      for(int i = 0; i < 8; i++)
        digitalWrite(pinLED[i], bitRead(EEPROM.read(secMemPos+state+1), i));
      if(state >= cantEstadosMem-1) state = 0;
      else state++;
    }else
    {
      for(int i = 0; i < 8; i++) digitalWrite(pinLED[i], LOW);
      digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
    }
    delay(200);
  }else
  {
    if(antiRebote(PIN_BUTTON))
    {
      t1 = millis();
      while((millis() - t1) < 1000)
      {
        if(antiRebote(PIN_BUTTON))
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
      cantNotas = sizeof(felizcumple) / sizeof(int) / 2;
      finMelodia = reproducir(felizcumple,nota);
      break;
    default:
      digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
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
      noteDuration = (wholenote) / abs(divider);
      noteDuration *= 1.5; // incrementa la duración por la mitad
    }
    // suena la nota el 90% del tiempo estipulado y el resto es una pequeña pausa entre notas
    tone(PIN_BUZZER, melodia[nota], noteDuration * 0.9);
    // espera el tiempo que dura la nota
    delay(noteDuration);
    // detiene la nota antes de la siguiente
    noTone(PIN_BUZZER);
    return false;
  }else return true;
}

