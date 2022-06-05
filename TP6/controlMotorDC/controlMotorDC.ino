#define VEL_MAX 230
#define VEL_MIN 26
#define VEL_STEP 26
#define M_STOPPED 0
#define M_RUNNING 1
#define M_MANUAL 0
#define M_REMOTE 1
#define COOLDOWN_MS 100

int pinPWM = 3;
int pinOnOff = 2;
int pinVelUp = 7;
int pinVelDown = 8;
unsigned long coolDown;
byte vel = 128;
bool state = M_STOPPED;
bool mode = M_MANUAL;
bool stringComplete;
String inputString;

void setup()
{
    pinMode(LED_BUILTIN, OUTPUT);
    pinMode(pinPWM, OUTPUT);
    pinMode(pinOnOff, INPUT);
    pinMode(pinVelUp, INPUT);
    pinMode(pinVelDown, INPUT);
    attachInterrupt(digitalPinToInterrupt(pinOnOff), switchMotorOnOff, RISING);
    coolDown = millis();

    Serial.begin(9600);
    inputString.reserve(200);
}

void loop()
{
    if(state == M_RUNNING)
    {
        if((millis() - coolDown > COOLDOWN_MS) && (mode == M_MANUAL))
        {
            if(digitalRead(pinVelUp)) motorVelUp();
            else if(digitalRead(pinVelDown)) motorVelDown();
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
    if((millis() - coolDown > COOLDOWN_MS) && (mode == M_MANUAL))
    {
        state = !state;
        vel = 128;
        coolDown = millis();
        digitalWrite(LED_BUILTIN,HIGH);
    }
}

void motorVelUp()
{
    if(vel < VEL_MAX) vel += VEL_STEP;
    coolDown = millis();
}
void motorVelDown()
{
    if(vel > VEL_MIN) vel -= VEL_STEP;
    coolDown = millis();
}
bool setMotorVel(float velPercent)
{
    bool ret = true;
    if((velPercent <= 100) && (velPercent >= 0)) vel = velPercent*255/100;
    else ret = false;
    return ret;
}

void serialEvent()
{
    while (Serial.available())
    {
        char code, inChar = (char)Serial.read();
        float velPercent;
        String ret = "$TD2,OK*";
        inputString += inChar;
        if (inChar == '\n')
        {
            code = inputString.charAt(5);
            if(inputString.substring(0,5).equals("$TD2,") && (inputString.length() <= 12) && inputString.endsWith("*\n") && (code == 'a' || mode == M_REMOTE))
            {
                switch (code)
                {
                    case 'a':
                        mode = M_REMOTE;
                    break;
                    case 'b':
                        mode = M_MANUAL;
                    break;
                    case 'c':
                        state = M_RUNNING;
                        vel = 128;
                        digitalWrite(LED_BUILTIN,HIGH);
                    break;
                    case 'd':
                        state = M_STOPPED;
                        vel = 128;
                    break;
                    case 'e':
                        motorVelUp();
                    break;
                    case 'f':
                        motorVelDown();
                    break;
                    case 'g':
                        velPercent = inputString.substring(7,inputString.indexOf('*')).toFloat();
                        if(!setMotorVel(velPercent)) ret = "$TD2,Err*";
                    break;
                    default:
                        ret = "$TD2,Err*";
                    break;
                }
            }else ret = "$TD2,Err*";
            Serial.println(ret);
            inputString = "";
        }
    }
}