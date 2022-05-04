#include <EEPROM.h>
#define MAX_ESTADOS 20

void setup()
{
    int sec1 = 0, sec2 = MAX_ESTADOS+1, sec3 = (MAX_ESTADOS+1)*2;
    EEPROM.update(sec1,2);
    EEPROM.update(sec1+1,0);
    EEPROM.update(sec1+2,255);

    EEPROM.update(sec2,2);
    EEPROM.update(sec2+1,170);
    EEPROM.update(sec2+2,85);
    
    EEPROM.update(sec3,9);
    EEPROM.update(sec3+1,0);
    EEPROM.update(sec3+2,1);
    EEPROM.update(sec3+3,2);
    EEPROM.update(sec3+4,4);
    EEPROM.update(sec3+5,8);
    EEPROM.update(sec3+6,16);
    EEPROM.update(sec3+7,32);
    EEPROM.update(sec3+8,64);
    EEPROM.update(sec3+9,128);

    pinMode(LED_BUILTIN, OUTPUT);
}

void loop()
{
    digitalWrite(LED_BUILTIN, HIGH);
    delay(200);
    digitalWrite(LED_BUILTIN, LOW);
    delay(200);
}