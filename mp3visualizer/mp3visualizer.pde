// Need G4P library //<>// //<>//
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
import peasy.*;

//sound variables
import processing.sound.*;
SoundFile currentSong;
FFT fft;
AudioIn in;

//domain logic
public boolean songlistLoaded = false; 
public String[] songFileNames;
public SoundFile[] songFiles;

public int currentSongId = 0;
public float currentSongDuration = 0;
public int volume = 0;
public int progress = 0;
public int song_length = 0;
public GButton[] songlistButtons;

public void setup() {
  createGUI();
  customGUI();

  load_songlist();

  print(currentSong);
}

public void draw() {
  //background(230);
  if (songlistLoaded) {
    updateDurationLabel();
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

  int offset = 0;
  for (int i = 0; i < files.length; i++) {
    offset += 30;

    String f = files[i];        

    //add buttons to songlist
    GButton song = new GButton(MainWindow, 10, offset, 180, 20);
    song.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    song.setText(f);
    song.addEventHandler(this, "songlist_song_click");
    songlist.addControl(song);

    songlistButtons[i] = song;
    songFileNames[i] = f;
    songFiles[i] = new SoundFile(this, f);
    song_title.setText(f);
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
    currentSong.jump(0);
    currentSong.stop();
  }

  //set new currentSong
  currentSong = songFiles[songId];
  currentSongId = songId;

  //jump do 0
  //currentSong.jump(0);

  //set currentSongDuration
  currentSongDuration = currentSong.duration();

  //mark active song
  for (int i = 0; i < songlistButtons.length; i++) {
    songlistButtons[i].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  }
  songlistButtons[currentSongId].setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
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
    songlistButtons[currentSongId].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  }
}
public void set_play_pause_btn() {
  if (!currentSong.isPlaying()) {
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
  if (currentSongId < songFileNames.length) {
    currentSongId +=1;


    setCurrentSong(currentSongId);
    set_play_pause_btn();
    play();

    return;
  }

  currentSong.jump(0);
}
public void back() {
  if (currentSongId > 0) {
    currentSongId -=1;

    setCurrentSong(currentSongId);
    set_play_pause_btn();
    play();

    return;
  }

  currentSong.jump(0);
}

public void updateDurationLabel() {
  if (currentSong.isPlaying()) {
    duration_label.setText(nf(currentSong.percent(), 0, 2) + " / " + nf(currentSongDuration, 0, 2)); 
    progress_slider.setValue(currentSong.percent() * 0.01f);
  }
}

/* DEBUG */
public void _debug(String msg) {
  debug_label.setText(msg);
}



/* CUSTOM GUI */
public void sidebar_click(GPanel source, GEvent event) { //_CODE_:sidebar:903496:
  println("sidebar - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:sidebar:903496:

public void songlist_click(GPanel source, GEvent event) { //_CODE_:songlist:251911:
  println("songlist - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:songlist:251911:

public void songlist_song_click(GButton source, GEvent event) { //_CODE_:songlist_song_dummy:200550:
  println(source.getText() + " >> GEvent." + event);
  println("sddsd");
  for (int i = 0; i < songlistButtons.length; i++) {
    println("songlistButtonsi: " +songlistButtons[i].getText());
    if (songlistButtons[i].getText() == source.getText()) {
      setCurrentSong(i);
      play();
      set_play_pause_btn();
      return;
    }
  }
} //_CODE_:songlist_song_dummy:200550:

public void debug_panel_click(GPanel source, GEvent event) { //_CODE_:debug_panel:987713:
  println("debug_panel - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:debug_panel:987713:

public void mein_menu_click(GPanel source, GEvent event) { //_CODE_:main_menu:990035:
  println("main_menu - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:main_menu:990035:

public void content_click(GPanel source, GEvent event) { //_CODE_:content:630781:
  println("content - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:content:630781:

public void controls_click(GPanel source, GEvent event) { //_CODE_:controls:328727:
  println("controls - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:controls:328727:

public void progress_slider_change(GCustomSlider source, GEvent event) { //_CODE_:progress_slider:414869:
  //println("custom_slider1 - GCustomSlider >> GEvent." + event + " @ " + millis());

  if (event.toString() == "PRESSED") { //CLICKED
    float percent = progress_slider.getValueF();

    println("progress_slider_changed to:"+ progress_slider.getValueS() +" ("+ source.getValueF() +"%)");
    _debug("progress_slider_changed to: currentSongDuration * percent ("+ percent +"%)");



    //currentSong.jump(currentSongDuration * percent);
  }
  //float percent = progress_slider.getValueF();
  //currentSong.jump(currentSongDuration * percent);
} //_CODE_:progress_slider:414869:

public void custom_slider2_change1(GCustomSlider source, GEvent event) { //_CODE_:custom_slider2:442201:
  println("custom_slider2 - GCustomSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:custom_slider2:442201:

public void control_buttons_click(GPanel source, GEvent event) { //_CODE_:control_buttons:432899:
  println("control_buttons - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:control_buttons:432899:

public void btn_next_click(GButton source, GEvent event) { //_CODE_:btn_next:452556:
  println("btn_next - GButton >> GEvent." + event + " @ " + millis());
  _debug(source.getText() + ": " + event);
  next();
} //_CODE_:btn_next:452556:

public void btn_play_pause_click(GButton source, GEvent event) { //_CODE_:btn_play_pause:854686:
  println("btn_play_pause - GButton >> GEvent." + event + " @ " + millis());
  _debug(source.getText() + ": " + event);
  play_pause();
} //_CODE_:btn_play_pause:854686:

public void btn_back_click(GButton source, GEvent event) { //_CODE_:btn_back:786194:
  println("btn_back - GButton >> GEvent." + event + " @ " + millis());
  _debug(source.getText() + ": " + event);
  back();
} //_CODE_:btn_back:786194:

public void visualize_window_left_click(GPanel source, GEvent event) { //_CODE_:visualize_window_left:390962:
  println("visualize_window_left - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:visualize_window_left:390962:

public void visualize_window_right_click(GPanel source, GEvent event) { //_CODE_:visualize_window_right:319029:
  println("panel1 - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:visualize_window_right:319029:






// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
}
