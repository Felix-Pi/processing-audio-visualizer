import controlP5.*;
import processing.sound.*;
ControlP5 cp5;


public ArrayList<String> songFileNames;
public int currentSongId = 0;
public SoundFile currentSong = null;
public float volume = 0.6;
public float speed = 1.0;

public ArrayList<String> load_mp3_files() {
  ArrayList<String> result = new ArrayList<String>();

  String path = sketchPath() + "/data/";
  File file = new File(path);
  String[] files = file.list();

  for (int i = 0; i < files.length; i++) {
      result.add(files[i]);
  }

  return result;
}



void setup() {
  songFileNames = load_mp3_files();
  setCurrentSongId(0);

  size(1100, 600);

  cp5 = new ControlP5(this);

  cp5.addButton("prev_song").setPosition(200,500).setSize(200,19);
  cp5.addButton("play").setPosition(450,500).setSize(80,19);
  cp5.addButton("pause").setPosition(550,500).setSize(80,19);
  cp5.addButton("next_song").setPosition(700,500).setSize(200,19);
  cp5.addButton("stop_song").setPosition(950,500).setSize(50,19);

  cp5.addSlider("progressSlider").setPosition(200,550).setSize(800,20);
  cp5.addSlider("volumeSlider").setPosition(1010,450).setSize(20,100).setRange(0.0,1.0).setValue(0.5);
  cp5.addSlider("speedSlider").setPosition(1050,450).setSize(20,100).setRange(0.5,2.0).setNumberOfTickMarks(4).setValue(1.0);

  cp5.addScrollableList("songlist_menu").setPosition(10, 10).setSize(200, 690).setBarHeight(20).setItemHeight(20)
  .addItems(songFileNames).setType(ScrollableList.LIST);

  cp5.addTextlabel("currentSongLabel").setPosition(210,10);

  cp5.addButton("add_song").setPosition(940,10).setSize(50,19);
  cp5.addButton("delete_song").setPosition(1020,10).setSize(50,19);

  setCurrentSongId(0);
  setProgressSliderRange();

  currentSong.pause();
}

void setCurrentSongId(int id) {
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

String getCurrentSongTitle() {
  println(songFileNames);
  return songFileNames.get(currentSongId);
}

void setCurrentSong() {
  stop_song();

  String songName = getCurrentSongTitle();

  currentSong = new SoundFile(this, songName);
  currentSong.cue(0);
  currentSong.jump(0);

  setProgressSliderRange();
  setProgressSliderValue();

  songlistMenuItemActive();

  updateCurrentSongLabel(songName);
}

void setProgressSliderRange() {
  try {
    Slider s = (Slider)cp5.getController("progressSlider");
    s.setRange(0, currentSong.duration());
  } catch(Exception e) {
    //occures on setup
  }
}

void setProgressSliderValue() {
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

void updateCurrentSongLabel(String val) {
  try {
    Textlabel s = (Textlabel)cp5.getController("currentSongLabel");
    s.setText(val);
  } catch(NullPointerException e) {
        //occures on setup
  }
}

void play() {
  if(!currentSong.isPlaying()) {
    songlistMenuItemActive();
    currentSong.play();
  }

  println("play:");
}

void pause() {
    if(currentSong.isPlaying()) {
        currentSong.pause();
}
  println("pause:");
}

void next_song(int n) {
  stop_song();
  setCurrentSongId(currentSongId + 1);
  println("next_song:", n);
}

void prev_song(int n) {
    stop_song();
    setCurrentSongId(currentSongId - 1);
  println("prev_song:", n);
}

void stop_song() {
  if(currentSong != null) {
    currentSong.stop();
  }
  println("prev_song:");
}

void setVolume(float vol) {
    volume = vol;
    setVolume();
}

void setVolume() {
  if(currentSong != null) {
    currentSong.amp(volume);
  }
}

void setSpeed(float sp) {
    speed = sp;
    setSpeed();
}

void setSpeed() {
  if(currentSong != null) {
    currentSong.rate(speed);
  }
}

void songlistMenuItemActive() {
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

void progressSlider(float position) {
  //println("progressSlider: jump to: " + position);
  currentSong.jump(position);
}

void volumeSlider(float volume) {
  setVolume(volume);
  println("volumeSlider " + volume);
}


void speedSlider(float speed) {
  setSpeed(speed);
  println("speedSlider " + speed);
}

void add_song() {
    selectInput("Select a file to process:", "uploadFile");
}

boolean uploadFile(File selection) {
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


boolean delete_song() {
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



void controlEvent(ControlEvent theEvent) {
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


void draw() {
  background(220);
  setProgressSliderValue();
}
