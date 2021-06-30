// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
import peasy.*;
import processing.sound.*;
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
SoundFile song;
String songName = "file_example_MP3_1MG.mp3";
ddf.minim.analysis.FFT fft;

float smoothing = 0;
float[] fftReal;
float[] fftImag;
float[] fftSmooth;

void fileSelected (File selection){

    if (selection == null) {
        println("Window was closed or the user hit cancel.");
    } else {
        println("User selected " + selection.getAbsolutePath());
    
        if (selection.getName().contains(".mp3")) {
      
            String Path = sketchPath() + "/data/" + selection.getName();
            File newFile = new File (Path);
            selection.renameTo(newFile);
            println(this, "Successfully uploaded '"+ selection.getName());
            
            songName = selection.getName();
            println(songName + "loading...");
            
            song = new SoundFile(this, songName);
            player = minim.loadFile(songName);
            println("loading complete");
        } else {
          println(this, "Please select a MP3 File!", "INFO", 1);
        }
    }
}

public void setup(){
  size(1500, 700, JAVA2D);
  createGUI();
  customGUI();
  //Songlist = new ArrayList<Song>();
  // Place your setup code here
  minim = new Minim(this);
  song = new SoundFile(this, songName);
  player = minim.loadFile(songName);          
  fft = new ddf.minim.analysis.FFT(player.bufferSize(), player.sampleRate());
  fftSmooth = new float[player.bufferSize()-1];
  fftReal   = new float[player.bufferSize()-1];
}

public void draw(){
  background(230);
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
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}
