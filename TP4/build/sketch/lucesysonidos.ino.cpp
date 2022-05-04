#include <Arduino.h>
#line 1 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
#include <EEPROM.h>

#define NOTE_C2  65
#define NOTE_CS2 69
#define NOTE_D2  73
#define NOTE_DS2 78
#define NOTE_E2  82
#define NOTE_F2  87
#define NOTE_FS2 93
#define NOTE_G2  98
#define NOTE_GS2 104
#define NOTE_A2  110
#define NOTE_AS2 117
#define NOTE_B2  123
#define NOTE_C3  131
#define NOTE_CS3 139
#define NOTE_D3  147
#define NOTE_DS3 156
#define NOTE_E3  165
#define NOTE_F3  175
#define NOTE_FS3 185
#define NOTE_G3  196
#define NOTE_GS3 208
#define NOTE_A3  220
#define NOTE_AS3 233
#define NOTE_B3  247
#define NOTE_C4  262
#define NOTE_CS4 277
#define NOTE_D4  294
#define NOTE_DS4 311
#define NOTE_E4  330
#define NOTE_F4  349
#define NOTE_FS4 370
#define NOTE_G4  392
#define NOTE_GS4 415
#define NOTE_A4  440
#define NOTE_AS4 466
#define NOTE_B4  494
#define NOTE_C5  523
#define NOTE_CS5 554
#define NOTE_D5  587
#define NOTE_DS5 622
#define NOTE_E5  659
#define NOTE_F5  698
#define NOTE_FS5 740
#define NOTE_G5  784
#define NOTE_GS5 831
#define NOTE_A5  880
#define NOTE_AS5 932
#define NOTE_B5  988
#define NOTE_D2ST      0
#define REST      0
#define MAX_ESTADOS 17
#define CANT_SEC    10
#define TEMPO 140
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
    {0}
  },
  {
    {0}
  },
};

int felizcumple[] = {

  NOTE_C4,4, NOTE_C4,8, 
  NOTE_D4,-4, NOTE_C4,-4, NOTE_F4,-4,
  NOTE_E4,-2, NOTE_C4,4, NOTE_C4,8, 
  NOTE_D4,-4, NOTE_C4,-4, NOTE_G4,-4,
  NOTE_F4,-2, NOTE_C4,4, NOTE_C4,8,

  NOTE_C5,-4, NOTE_A4,-4, NOTE_F4,-4, 
  NOTE_E4,-4, NOTE_D4,-4, NOTE_AS4,4, NOTE_AS4,8,
  NOTE_A4,-4, NOTE_F4,-4, NOTE_G4,-4,
  NOTE_F4,-2,
 
};

int takeonme[] = {

  NOTE_FS5,8, NOTE_FS5,8,NOTE_D5,8, NOTE_B4,8, REST,8, NOTE_B4,8, REST,8, NOTE_E5,8, 
  REST,8, NOTE_E5,8, REST,8, NOTE_E5,8, NOTE_GS5,8, NOTE_GS5,8, NOTE_A5,8, NOTE_B5,8,
  NOTE_A5,8, NOTE_A5,8, NOTE_A5,8, NOTE_E5,8, REST,8, NOTE_D5,8, REST,8, NOTE_FS5,8, 
  REST,8, NOTE_FS5,8, REST,8, NOTE_FS5,8, NOTE_E5,8, NOTE_E5,8, NOTE_FS5,8, NOTE_E5,8,
  NOTE_FS5,8, NOTE_FS5,8,NOTE_D5,8, NOTE_B4,8, REST,8, NOTE_B4,8, REST,8, NOTE_E5,8, 
  
  REST,8, NOTE_E5,8, REST,8, NOTE_E5,8, NOTE_GS5,8, NOTE_GS5,8, NOTE_A5,8, NOTE_B5,8,
  NOTE_A5,8, NOTE_A5,8, NOTE_A5,8, NOTE_E5,8, REST,8, NOTE_D5,8, REST,8, NOTE_FS5,8, 
  REST,8, NOTE_FS5,8, REST,8, NOTE_FS5,8, NOTE_E5,8, NOTE_E5,8, NOTE_FS5,8, NOTE_E5,8,
  NOTE_FS5,8, NOTE_FS5,8,NOTE_D5,8, NOTE_B4,8, REST,8, NOTE_B4,8, REST,8, NOTE_E5,8, 
  REST,8, NOTE_E5,8, REST,8, NOTE_E5,8, NOTE_GS5,8, NOTE_GS5,8, NOTE_A5,8, NOTE_B5,8,
  
  NOTE_A5,8, NOTE_A5,8, NOTE_A5,8, NOTE_E5,8, REST,8, NOTE_D5,8, REST,8, NOTE_FS5,8, 
  REST,8, NOTE_FS5,8, REST,8, NOTE_FS5,8, NOTE_E5,8, NOTE_E5,8, NOTE_FS5,8, NOTE_E5,8,
  
};

int lcdtmAllBoys[] = {
  NOTE_D4,8, NOTE_E4,8, NOTE_E4,8, NOTE_E4,8, NOTE_E4,8, NOTE_E4,4, NOTE_D4,8, NOTE_F4,4, REST,6,
  NOTE_E4,8, NOTE_D4,8, NOTE_D4,8, NOTE_D4,8, NOTE_D4,8, NOTE_D4,4, NOTE_C4,8, NOTE_E4,4, REST,6,
  NOTE_C4,8, NOTE_C4,8, NOTE_C4,8, NOTE_C4,8, NOTE_C4,8, NOTE_C4,4, NOTE_B4,6, NOTE_D4,4, NOTE_D4,8,
  NOTE_D4,8, NOTE_C4,8, NOTE_B4,4, NOTE_A3,8, NOTE_GS3,4, NOTE_GS3,8,
  NOTE_GS3,8, NOTE_GS3,8, NOTE_A3,4, NOTE_B4,8, NOTE_A3,4, REST,3,
};

#line 185 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
void setup();
#line 195 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
void loop();
#line 273 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
bool antiRebote(int in);
#line 286 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
bool reproducir(int melodia[], int nota);
#line 185 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(pinBuz, OUTPUT);
  pinMode(pinBtn, OUTPUT);
  for(int i = 0; i < 7; i++)
    pinMode(pinLED[i], OUTPUT);
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
        if(btnCount >= CANT_SEC) btnCount = 0;
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
    tone(pinBuz, melodia[nota], noteDuration * 0.9);
    // espera el tiempo que dura la nota
    delay(noteDuration);
    // detiene la nota antes de la siguiente
    noTone(pinBuz);
    return false;
  }else return true;
}

