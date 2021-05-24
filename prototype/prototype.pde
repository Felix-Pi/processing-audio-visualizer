import processing.sound.*;
SoundFile file;
Amplitude amp;
AudioIn in;

void setup() {
  size(640, 360);
  background(255);
    
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "test.mp3");
  file.play();
  
  amp = new Amplitude(this);

  amp.input(file);
}      

void draw() {
 println(amp.analyze());
}
