#define VEL_MAX 230
#define VEL_MIN 26
#define VEL_STEP 26
#define M_STOPPED 0
#define M_RUNNING 1

int pinPWM = 3;
int pinOnOff = 2;
int pinVelUp = 7;
int pinVelDown = 8;
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
}

void loop()
{
    if(state == M_RUNNING)
    {
        if(digitalRead(pinVelUp) && (vel < VEL_MAX)) vel += VEL_STEP;
        else if(digitalRead(pinVelDown) && (vel > VEL_MIN)) vel -= VEL_STEP;
        analogWrite(pinPWM,vel);
    }
}

void switchMotorOnOff()
{
    digitalWrite(pinPWM, 0);
    state = !state;
}