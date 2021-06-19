import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.sound.*;
 
Minim minim;
AudioPlayer player;
SoundFile song;
String songName = "sawsquarenoise - Boss Theme.mp3";
ddf.minim.analysis.FFT fft;
 
float smoothing = 0;
float[] fftReal;
float[] fftImag;
float[] fftSmooth;

void setup(){
  size(1920, 1080, P3D);
  minim = new Minim(this);
  song = new SoundFile(this, songName);
  player = minim.loadFile(songName);
  fft = new ddf.minim.analysis.FFT(player.bufferSize(), player.sampleRate());
  fftSmooth = new float[player.bufferSize()-1];
  fftReal   = new float[player.bufferSize()-1];
}
 
void draw(){
  background(0);
 
  fft.forward(player.right);
  fftReal = fft.getSpectrumReal();
  fftImag = fft.getSpectrumImaginary();
  for(int i = 0; i < player.bufferSize()-1; i+=5)
  {
    float band = fft.getBand(i);
 
    fftSmooth[i] *= smoothing;
    if(fftSmooth[i] < band) fftSmooth[i] = band;
    stroke(255,0,i);
    line( i*5, height, i*5, height - fftSmooth[i]*16 );
    //stroke(i,0,255);
    line( i*5, height, i*5, height - band*16 );
 
 
  }
  
  //float posx = map(player.position(),0,player.length(),0,width);
  //line(posx,0,posx,height);
}
void keyPressed()
{
  if(player.isPlaying())
  {
   player.pause(); 
  }
  else
  {
   player.play(); 
  }
}
