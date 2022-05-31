#define VEL_MAX 230
#define VEL_MIN 26
#define VEL_STEP 26
#define M_STOPPED 0
#define M_RUNNING 1
#define COOLDOWN_MS 100

int pinPWM = 3;
int pinOnOff = 2;
int pinVelUp = 7;
int pinVelDown = 8;
unsigned long coolDown;
byte vel = 128;
bool state = M_STOPPED;

void setup()
{
    pinMode(LED_BUILTIN, OUTPUT);
    pinMode(pinPWM, OUTPUT);
    pinMode(pinOnOff, INPUT);
    pinMode(pinVelUp, INPUT);
    pinMode(pinVelDown, INPUT);
    attachInterrupt(digitalPinToInterrupt(pinOnOff), switchMotorOnOff, RISING);
    coolDown = millis();
}

void loop()
{
    if(state == M_RUNNING)
    {
        if(millis() - coolDown > COOLDOWN_MS)
            if(digitalRead(pinVelUp) && (vel < VEL_MAX))
            {
                vel += VEL_STEP;
                coolDown = millis();
            }else if(digitalRead(pinVelDown) && (vel > VEL_MIN))
            {
                vel -= VEL_STEP;
                coolDown = millis();
            }
    }else
    {
        vel = 0;
        digitalWrite(LED_BUILTIN,!digitalRead(LED_BUILTIN));
        delay(200);
    }
    analogWrite(pinPWM,vel);
}

void switchMotorOnOff()
{
    if(millis() - coolDown > COOLDOWN_MS)
    {
        state = !state;
        vel = 128;
        coolDown = millis();
        digitalWrite(LED_BUILTIN,HIGH);
    }
}