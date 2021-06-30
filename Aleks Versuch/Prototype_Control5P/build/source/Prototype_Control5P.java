import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Prototype_Control5P extends PApplet {



ControlP5 cp5;


public ArrayList<String> songFileNames;
public int currentSongId = 0;
public SoundFile currentSong = null;
public float volume = 0.6f;
public float speed = 1.0f;

SoundFile file;
FFT fft;
Amplitude amp;
AudioIn in;
Chart myChart;
Chart myChart1;
Chart myChart2;
int bands = 256;
float[] spectrum = new float[bands];
ArrayList<Float> amplitude = new ArrayList<Float>();

public ArrayList<String> load_mp3_files() {
        ArrayList<String> result = new ArrayList<String>();

        String path = sketchPath() + "/data/";
        File file = new File(path);
        String[] files = file.list();

        for (int i = 0; i < files.length; i++) {
                if(!files[i].contains(".ttf")) {
                        result.add(files[i]);
                }
        }

        return result;
}



public void setup() {
        for (int i = 0; i < bands; i++) {
                amplitude.add(0.0f);
        }

        songFileNames = load_mp3_files();
        setCurrentSongId(0);

        
        background(255);

        cp5 = new ControlP5(this);

        cp5.addButton("prev_song").setPosition(50,500).setSize(180,25).setFont(createFont("standard 07_58 Regular.ttf", 16));
        cp5.addButton("play").setPosition(240,500).setSize(180,25).setFont(createFont("standard 07_58 Regular.ttf", 16));
        cp5.addButton("pause").setPosition(430,500).setSize(180,25).setFont(createFont("standard 07_58 Regular.ttf", 16));
        cp5.addButton("next_song").setPosition(620,500).setSize(180,25).setFont(createFont("standard 07_58 Regular.ttf", 16));
        cp5.addButton("stop_song").setPosition(810,500).setSize(180,25).setFont(createFont("standard 07_58 Regular.ttf", 16));

        cp5.addSlider("progressSlider").setPosition(120,550).setSize(800,20).setFont(createFont("standard 07_58 Regular.ttf", 16));
        cp5.addSlider("volumeSlider").setPosition(1010,400).setSize(20,170).setRange(0.0f,1.0f).setValue(0.5f);
        cp5.addSlider("speedSlider").setPosition(1055,400).setSize(20,170).setRange(0.5f,2.0f).setNumberOfTickMarks(4).setValue(1.0f);

        cp5.addScrollableList("songlist_menu").setPosition(10, 10).setSize(200, 690).setBarHeight(20).setItemHeight(20)
        .addItems(songFileNames).setType(ScrollableList.LIST);

        cp5.addTextlabel("currentSongLabel").setPosition(300,10).setColor(0).setFont(createFont("standard 07_58 Regular.ttf", 16));
        cp5.addTextlabel("volLabel").setPosition(1004,575).setText("vol").setColor(0).setFont(createFont("standard 07_58 Regular.ttf", 16));
        cp5.addTextlabel("speedLabel").setPosition(1041,575).setText("speed").setColor(0).setFont(createFont("standard 07_58 Regular.ttf", 16));
        cp5.addTextlabel("fftbarLabel").setPosition(95,404).setText("FFT BAR").setColor(0).setFont(createFont("standard 07_58 Regular.ttf", 16));

        cp5.addButton("add_song").setPosition(700,10).setSize(180,25).setFont(createFont("standard 07_58 Regular.ttf", 16));
        cp5.addButton("delete_song").setPosition(900,10).setSize(180,25).setFont(createFont("standard 07_58 Regular.ttf", 16));

        setCurrentSongId(0);
        setProgressSliderRange();

        fft = new FFT(this);
        fft.input(currentSong);

        amp = new Amplitude(this);
        amp.input(currentSong);

        myChart = cp5.addChart("fft bar")
                  .setPosition(100, 150)
                  .setSize(250, 250)
                  .setRange(0, 10)
                  .setView(Chart.BAR_CENTERED) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
                  .setStrokeWeight(5)
                  .setColorCaptionLabel(color(40))
                  .setFont(createFont("standard 07_58 Regular.ttf", 16))
        ;


        myChart1 = cp5.addChart("fft line")
                   .setPosition(400, 150)
                   .setSize(250, 250)
                   .setRange(0, 10)
                   .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
                   .setStrokeWeight(5)
                   .setColorCaptionLabel(color(40))
                   .setFont(createFont("standard 07_58 Regular.ttf", 16))
        ;

        myChart2 = cp5.addChart("amplitude")
                   .setPosition(700, 150)
                   .setSize(250, 250)
                   .setRange(0, 10)
                   .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
                   .setStrokeWeight(5)
                   .setColorCaptionLabel(color(40))
                   .setFont(createFont("standard 07_58 Regular.ttf", 16))
        ;

        myChart.addDataSet("incoming");
        myChart.setData("incoming", new float[bands]);

        myChart1.addDataSet("incoming1");
        myChart1.setData("incoming1", new float[bands]);

        myChart2.addDataSet("incoming2");
        myChart2.setData("incoming2", new float[bands]);

        currentSong.pause();
}

public void setCurrentSongId(int id) {
        if (id >= songFileNames.size()) {
                id = 0;
        }
        if(id < 0) {
                id = songFileNames.size() - 1;
        }

        println("setting currentSongId from '"+ currentSongId + "' to '"+ id +"'");
        currentSongId = id;

        setCurrentSong();
}

public String getCurrentSongTitle() {
        println(songFileNames);
        return songFileNames.get(currentSongId);
}

public void setCurrentSong() {
        stop_song();

        String songName = getCurrentSongTitle();

        currentSong = new SoundFile(this, songName);
        currentSong.cue(0);
        currentSong.jump(0);

        fft = new FFT(this);
        fft.input(currentSong);

        amp = new Amplitude(this);
        amp.input(currentSong);

        setProgressSliderRange();
        setProgressSliderValue();

        songlistMenuItemActive();

        updateCurrentSongLabel(songName);
}

public void setProgressSliderRange() {
        try {
                Slider s = (Slider)cp5.getController("progressSlider");
                s.setRange(0, currentSong.duration());
        } catch(Exception e) {
                //occures on setup
        }
}

public void setProgressSliderValue() {
        if(currentSong != null) {
                if(currentSong.isPlaying()) {
                        try {
                                cp5.getController("progressSlider").setValue(currentSong.position());
                        } catch(NullPointerException e) {
                                //occures on setup
                        }
                }
        }
}

public void updateCurrentSongLabel(String val) {
        try {
                Textlabel s = (Textlabel)cp5.getController("currentSongLabel");
                s.setText(val);
        } catch(NullPointerException e) {
                //occures on setup
        }
}

public void play() {
        if(!currentSong.isPlaying()) {
                songlistMenuItemActive();
                currentSong.play();
        }

        println("play:");
}

public void pause() {
        if(currentSong.isPlaying()) {
                currentSong.pause();
        }
        println("pause:");
}

public void next_song(int n) {
        stop_song();
        setCurrentSongId(currentSongId + 1);
        println("next_song:", n);
}

public void prev_song(int n) {
        stop_song();
        setCurrentSongId(currentSongId - 1);
        println("prev_song:", n);
}

public void stop_song() {
        if(currentSong != null) {
                currentSong.jump(0);
                currentSong.stop();
        }
        println("prev_song:");
}

public void setVolume(float vol) {
        volume = vol;
        setVolume();
}

public void setVolume() {
        if(currentSong != null) {
                currentSong.amp(volume);
        }
}

public void setSpeed(float sp) {
        speed = sp;
        setSpeed();
}

public void setSpeed() {
        if(currentSong != null) {
                currentSong.rate(speed);
        }
}

public void songlistMenuItemActive() {
        if(currentSong.isPlaying()) {
                try {
                        if((int) cp5.get(ScrollableList.class, "songlist_menu").getValue() != currentSongId) {
                                cp5.get(ScrollableList.class, "songlist_menu").setValue((float) currentSongId);
                        }
                } catch(Exception e) {
                        //occures on setup
                }
        }
}
/*
 * UI Element callback funtions
 */

public void progressSlider(float position) {
        //println("progressSlider: jump to: " + position);
        currentSong.jump(position);
}

public void volumeSlider(float volume) {
        setVolume(volume);
        println("volumeSlider " + volume);
}


public void speedSlider(float speed) {
        setSpeed(speed);
        println("speedSlider " + speed);
}

public void add_song() {
        selectInput("Select a file to process:", "uploadFile");
}

public boolean uploadFile(File selection) {
        if (selection == null) {
                println("Window was closed or the user hit cancel.");
        } else {
                println("User selected " + selection.getAbsolutePath());

                String fileName = selection.getName();

                String path = sketchPath() + "/data/" + fileName;
                File newFile = new File (path);

                selection.renameTo(newFile);

                songFileNames.add(fileName);

                cp5.get(ScrollableList.class, "songlist_menu").setItems(songFileNames);

                return true;

        }

        return false;
}


public boolean delete_song() {
        String fileName = getCurrentSongTitle();
        println("delete:" + fileName);
        String path = sketchPath() + "/data/";

        File f = new File(dataPath(path + fileName));
        boolean exists = f.exists();
        if (exists) {
                f.delete();

                songFileNames.remove(currentSongId);
                cp5.get(ScrollableList.class, "songlist_menu").setItems(songFileNames);
        }

        return exists;
}



public void controlEvent(ControlEvent theEvent) {
        // DropdownList is of type ControlGroup.
        // A controlEvent will be triggered from inside the ControlGroup class.
        // therefore you need to check the originator of the Event with
        // if (theEvent.isGroup())
        // to avoid an error message thrown by controlP5.

        if (theEvent.isGroup()) {
                // check if the Event was triggered from a ControlGroup
                //println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
        }
        else if (theEvent.isController()) {
                if("songlist_menu [ScrollableList]".equals( theEvent.getController() + "" )) {

                        println("songlist_menu selected: " +theEvent.getController().getValue());
                        setCurrentSongId((int) theEvent.getController().getValue());
                }
                //println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
        }
}


public void draw() {
        background(255);
        fft.analyze(spectrum);

        if(amplitude.size() == bands) {
                amplitude.remove(0);
        }


        amplitude.add(amp.analyze());

        for(int i = 0; i < bands; i++) {
                myChart.push("incoming", 3 + spectrum[i] * 3 * 7);
                myChart1.push("incoming1", 3 + spectrum[i] * 3 * 7 );
                myChart2.push("incoming2",  3 + amplitude.get(i));
                setProgressSliderValue();
        }
}
  public void settings() {  size(1100, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Prototype_Control5P" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
