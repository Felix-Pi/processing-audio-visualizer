import g4p_controls.*; //<>//
import peasy.*;
import processing.sound.*;

//domain logic
public boolean songlistLoaded = false; 
public ArrayList<String> songFileNames;
public ArrayList<SoundFile> songFiles;
public ArrayList<GButton> songlistButtons;

SoundFile currentSong;
public int currentSongId = 0;
public float currentSongDuration = 0;

public String progress_slider_prevEvent;
public Float progress_slider_prevValue;
public boolean progress_slider_pressed = false;

public void setup() {

  if (countUploadedMp3Files() == 0) {
    G4P.showMessage(this, "Upload at least 1 mp3 file!", "INFO", 1);
    selectInput("Select a file to process:", "uploadFileSetup");
    return;
  }

  createGUI();
  customGUI();

  ManageSongsWindow.setVisible(false);

  LoadingWindow.setVisible(true);
  MainWindow.setVisible(false);
  load_songlist();

  LoadingWindow.setVisible(false);
  MainWindow.setVisible(true);
}

public void draw() {
  if (songlistLoaded) {
    updateDurationLabel();
    set_play_pause_btn();
  }
}

public ArrayList<String> load_mp3_files() {
  ArrayList<String> result = new ArrayList<String>(); 

  String path = sketchPath() + "/data/";
  File file = new File(path);
  String[] files = file.list();

  for (int i = 0; i < files.length; i++) {
    if (files[i].contains(".mp3")) {
      result.add(files[i]);
    }
  }

  return result;
}


public void insert_songlist_button(String songName, int offset) {
  //add buttons to songlist
  GButton btn_song = new GButton(MainWindow, songlist_song_dummy.getX(), offset, songlist_song_dummy.getWidth(), songlist_song_dummy.getHeight());
  btn_song.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  btn_song.setText(songName);
  btn_song.addEventHandler(this, "songlist_song_click");
  songlist.addControl(btn_song);

  //fill file wrappers
  songlistButtons.add(btn_song);
}

public void load_songlist() {
  //disable dummy button (appearently needed for handler creation)
  songlist_song_dummy.setEnabled(false);
  songlist_song_dummy.setVisible(false);

  songFileNames = load_mp3_files();
  songFiles =new ArrayList<SoundFile>();
  songlistButtons = new ArrayList<GButton>();

  loading_slider.setLimits(0, songFileNames.size());

  int offset = 0;
  for (int i = 0; i < songFileNames.size(); i++) {
    offset += 30;

    String songName = songFileNames.get(i);        

    setProgress(i + 1, songFileNames.size(), songName);
    insert_songlist_button(songName, offset);

    songFiles.add(new SoundFile(this, songName));
  }

  setCurrentSong(currentSongId);
  songlistLoaded = true;
}

/* processing sound stuff */
public void setCurrentSong(int songId) {
  if (songId < 0 || songId > songFileNames.size() - 1) {
    return;
  }

  //stop old currentSong
  if (currentSong != null) {
    if (currentSong.isPlaying()) {
      currentSong.stop();
    }
    if (currentSongId != songId) {
      currentSong.stop();
    }
  }


  //set new currentSong
  currentSong = songFiles.get(songId);
  currentSongId = songId;

  //set song_title value
  song_title.setText(songFileNames.get(songId).replace(".mp3", ""));

  //set currentSongDuration
  currentSongDuration = currentSong.duration();

  //set progress slider ticks
  progress_slider.setLimits(0, currentSongDuration);


  //mark active song
  for (int i = 0; i < songlistButtons.size(); i++) {
    songlistButtons.get(i).setTextPlain();
  }
  songlistButtons.get(currentSongId).setTextBold();
}


/* controls */
public void play() {
  setCurrentSong(currentSongId);
  currentSong.play();
}

public void pause() {
  //todo check if playing
  if (currentSong.isPlaying()) {
    currentSong.pause();
    songlistButtons.get(currentSongId).setTextBold();
  }
}

public void set_play_pause_btn() {
  if (currentSong.isPlaying()) {
    btn_play_pause.setText("pause");
  } else {
    btn_play_pause.setText("play");
  }
}

public void play_pause() {
  set_play_pause_btn();
  if (!currentSong.isPlaying()) {
    play();
  } else {
    pause();
  }
}

public void stop_playback() {
  if (currentSong != null && currentSong.isPlaying()) {
    currentSong.stop();
  }
}

public void next() {
  if (currentSongId < songFiles.size()) {
    currentSongId +=1;
  } else {
    currentSongId = 0;
  }

  setCurrentSong(currentSongId);
  set_play_pause_btn();
  play();
}

public void back() {
  if (currentSongId > 0) {
    currentSongId -=1;
  } else {
    currentSongId = songFiles.size() - 1;
  }

  setCurrentSong(currentSongId);
  set_play_pause_btn();
  play();
}

public void updateDurationLabel() {
  if (currentSong.isPlaying() && !progress_slider_pressed) {
    duration_label.setText(nf(currentSong.position(), 0, 2) + " / " + nf(currentSongDuration, 0, 2)); 
    //progress_slider.setValue(currentSong.percent() * 0.01f);
    progress_slider.setValue(currentSong.position());
  }
}

/* DEBUG */
public void _debug(String msg) {
  if (debug_label != null) {
    debug_label.setText("Debug: " + msg);
  }
  println(msg);
}


// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
}
