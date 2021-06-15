import processing.sound.*;
SoundFile file;
FFT fft;
AudioIn in;

int bands = 256;
float[] spectrum = new float[bands];


void setup() {
  size(940, 560);
  background(255);
    
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "test.mp3");
  file.play();
  
  fft = new FFT(this);

  fft.input(file);
}      

void draw() {
background(255);
  fft.analyze(spectrum);

  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  line( i, height, i, height - spectrum[i]*height*7 );
  } 
}
