# 1 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
# 92 "/media/gabriel/DATOS/Facultad/Ingeniería Electrónica/4/Técnicas Digitales II/Trabajos prácticos/TP4/lucesysonidos/lucesysonidos.ino"
int pinBuzzer = 11;

int takeonme[] = {

  // Take on me, by A-ha
  // Score available at https://musescore.com/user/27103612/scores/4834399
  // Arranged by Edward Truong

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
  pinMode(pinBuzzer, 0x1);
}

int notes = sizeof(takeonme) / sizeof(takeonme[0]) / 2;

// change this to make the song slower or faster
int tempo = 140;

// this calculates the duration of a whole note in ms
int wholenote = (60000 * 4) / tempo;

int divider = 0, noteDuration = 0;

void loop() {
  // iterate over the notes of the melody.
  // Remember, the array is twice the number of notes (notes + durations)
  for (int thisNote = 0; thisNote < notes * 2; thisNote = thisNote + 2) {

    // calculates the duration of each note
    divider = lcdtmAllBoys[thisNote + 1];
    if (divider > 0) {
      // regular note, just proceed
      noteDuration = (wholenote) / divider;
    } else if (divider < 0) {
      // dotted notes are represented with negative durations!!
      noteDuration = (wholenote) / ((divider)>0?(divider):-(divider));
      noteDuration *= 1.5; // increases the duration in half for dotted notes
    }

    // we only play the note for 90% of the duration, leaving 10% as a pause
    tone(pinBuzzer, lcdtmAllBoys[thisNote], noteDuration * 0.9);

    // Wait for the specief duration before playing the next note.
    delay(noteDuration);

    // stop the waveform generation before the next note.
    noTone(pinBuzzer);
  }

}
