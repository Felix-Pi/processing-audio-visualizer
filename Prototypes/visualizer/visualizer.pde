import processing.sound.*;
import ddf.minim.*;


Minim minim;
AudioPlayer player;
FFT fft;
SoundFile song;
String songName = "sawsquarenoise - Boss Theme.mp3";
int bands = 512;
boolean isCompressed;

void setup()
{
  size(1920, 1080);
  minim = new Minim(this);
  fft = new FFT(this, bands);
  song = new SoundFile(this, songName);
  //fft.input(song);
  player = minim.loadFile(songName);
}

void draw()
{
  background(0);
  //stroke(255,0,40);
  
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 10, width );
    float x2 = map( i+1, 0, player.bufferSize(), 0, width );
    line( x1, 250 + player.right.get(i)*50, x2, 260 + player.left.get(i)*250 );
    line( x1, 350 + player.right.get(i)*50, x2, 340 + player.right.get(i+1)*100 );
    rect( x1, 300 + player.right.get(i)*10, x2, 5 + player.right.get(i+1)*100 );
    line( x1, 450 + player.right.get(i)*50, x2, 460 + player.left.get(i)*100 );
    line( x1, 550 + player.right.get(i)*50, x2, 540 + player.right.get(i+1)*250 );
    rect( x1, 500 + player.right.get(i)*10, x2, 5 + player.right.get(i+1)*100 );
    fill(0);
    stroke(255,0,i);
    
  } //<>//
  
  float posx = map(player.position(),0,player.length(),0,width);
  line(posx,0,posx,height);
  
  /*
  for(int i = 0; i < bands; i++)
  {
    fill(0,60,24);
    ellipse(i,300,10,fft.spectrum[i] * 10);
  }
  */
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
