import g4p_controls.*; //<>//
import peasy.*;
import processing.sound.*;

//domain logic
public boolean songlistLoaded = false; 
public String[] songFileNames;
public SoundFile[] songFiles;
public GButton[] songlistButtons;

SoundFile currentSong;
public int currentSongId = 0;
public float currentSongDuration = 0;


public void setup() {
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

public void load_songlist() {
  //disable dummy button (appearently needed for handler creation)
  songlist_song_dummy.setEnabled(false);
  songlist_song_dummy.setVisible(false);

  //load songfiles from /data/
  String path = sketchPath() + "/data/";
  File file = new File(path);
  String[] files = file.list();

  songlistButtons = new GButton[files.length];
  songFileNames = new String[files.length];
  songFiles = new SoundFile[files.length];


  loading_slider.setLimits(0, files.length);

  int offset = 0;
  for (int i = 0; i < files.length; i++) {
    offset += 30;

    String songName = files[i];        

    //loading screen
    loading_amount.setText((i + 1) + "/" + files.length);
    loading_file.setText(songName);
    loading_slider.setValue(i + 1);


    //add buttons to songlist
    GButton btn_song = new GButton(MainWindow, 10, offset, 180, 20);
    btn_song.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    btn_song.setText(songName);
    btn_song.addEventHandler(this, "songlist_song_click");
    songlist.addControl(btn_song);

    //fill file wrappers
    songlistButtons[i] = btn_song;
    songFileNames[i] = songName;
    songFiles[i] = new SoundFile(this, songName);
  }

  setCurrentSong(currentSongId);
  songlistLoaded = true;
}

/* processing sound stuff */
public void setCurrentSong(int songId) {
  if (songId < 0 || songId > songFileNames.length - 1) {
    return;
  }

  //stop old currentSong
  if (currentSong != null && currentSong.isPlaying()) {
    currentSong.stop();
  }

  //set new currentSong
  currentSong = songFiles[songId];
  currentSongId = songId;

  //set song_title value
  song_title.setText(songFileNames[songId].replace(".mp3", ""));

  //set currentSongDuration
  currentSongDuration = currentSong.duration();

  //mark active song
  for (int i = 0; i < songlistButtons.length; i++) {
    songlistButtons[i].setTextPlain();
  }
  songlistButtons[currentSongId].setTextBold();
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
    songlistButtons[currentSongId].setTextBold();
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

public void next() {
  if (currentSongId < songFiles.length) {
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
    currentSongId = songFiles.length - 1;
  }

  setCurrentSong(currentSongId);
  set_play_pause_btn();
  play();
}

public void updateDurationLabel() {
  if (currentSong.isPlaying()) {
    duration_label.setText(nf(currentSong.percent(), 0, 2) + " / " + nf(currentSongDuration, 0, 2)); 
    progress_slider.setValue(currentSong.percent() * 0.01f);
  }
}

/* DEBUG */
public void _debug(String msg) {
  debug_label.setText("Debug: " + msg);
}


// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
}
