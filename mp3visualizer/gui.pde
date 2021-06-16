/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void EXIT_APP(PApplet appc, GWinData data) { //_CODE_:MainWindow:473482:
  appc.background(230);
} //_CODE_:MainWindow:473482:

public void songlist_click(GPanel source, GEvent event) { //_CODE_:songlist:251911:
  _debug(source.getText() + ": " + event);
} //_CODE_:songlist:251911:

public void CENTER(GButton source, GEvent event) { //_CODE_:songlist_song_dummy:200550:
  _debug(source.getText() + ": " + event);

  for (int i = 0; i < songlistButtons.size(); i++) {
    if (songlistButtons.get(i).getText() == source.getText()) {
      setCurrentSong(i);
      play();
      set_play_pause_btn();
      return;
    }
  }
} //_CODE_:songlist_song_dummy:200550:

public void btn_manage_songs_click(GButton source, GEvent event) { //_CODE_:btn_manage_songs:731596:


  try {
    _debug(source.getText() + ": " + event);
    stop_playback();
    load_files();

    MainWindow.setVisible(false);
    ManageSongsWindow.setVisible(true);
  } 
  catch (Exception e) { //ConcurrentModificationException doesn#t exist but is thrown sometimes?!
    e.printStackTrace();
    println(e);
  }
} //_CODE_:btn_manage_songs:731596:

public void btn_next_click(GButton source, GEvent event) { //_CODE_:btn_next:452556:
  _debug(source.getText() + ": " + event);
  next();
} //_CODE_:btn_next:452556:

public void btn_play_pause_click(GButton source, GEvent event) { //_CODE_:btn_play_pause:854686:
  _debug(source.getText() + ": " + event);
  play_pause();
} //_CODE_:btn_play_pause:854686:

public void btn_back_click(GButton source, GEvent event) { //_CODE_:btn_back:786194:
  _debug(source.getText() + ": " + event);
  back();
} //_CODE_:btn_back:786194:

public void btn_stop_click(GButton source, GEvent event) { //_CODE_:btn_stop:231338:
  _debug(source.getText() + ": " + event);
  stop_playback();
} //_CODE_:btn_stop:231338:

public void progress_slider_change(GSlider source, GEvent event) { //_CODE_:progress_slider:519365:
  _debug("progress_slider_change: " + source + ": " + event + "=" + source.getValueF() + "state:" + progress_slider_pressed);
  Float newValue;

  if (event.toString() == "PRESSED") {
    progress_slider_pressed = true;
    println("Pressed: " + source.getValueF());
  }
  if (event.toString() == "RELEASED") {
    progress_slider_pressed = false;
  }

  //click / double click
  if (progress_slider_prevEvent == "CLICKED" && event.toString() == "VALUE_STEADY") {
    newValue = source.getValueF();
    currentSong.jump(newValue);

    progress_slider_pressed = false;
    updateDurationLabel();
    _debug("CLick / DoubleClick detected: newValue=" + newValue);
  }


  //drag
  if (progress_slider_prevEvent == "VALUE_STEADY" && event.toString() == "RELEASED") {
    newValue = progress_slider_prevValue;
    currentSong.jump(newValue);

    progress_slider_pressed = false;
    updateDurationLabel();
    _debug("Drag detected: newValue=" + newValue);
  }

  progress_slider_prevEvent = event.toString();
  progress_slider_prevValue = source.getValueF();
} //_CODE_:progress_slider:519365:

public void volume_slider_chang(GSlider source, GEvent event) { //_CODE_:volume_slider:208684:
  _debug(source + ": " + event + "=" + source.getValueF());

  currentSong.amp( source.getValueF());
  volume_label.setText(nf(source.getValueF() * 100, 0, 2) + "%");
} //_CODE_:volume_slider:208684:

public void speed_slider_change(GSlider source, GEvent event) { //_CODE_:speed_slider:986531:
  _debug(source + ": " + event + "=" + source.getValueF());
  speed_label.setText("x" + nf(source.getValueF(), 0, 2));
  currentSong.rate(source.getValueF());
} //_CODE_:speed_slider:986531:

synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:LoadingWindow:962587:
  appc.background(230);
} //_CODE_:LoadingWindow:962587:

public void panel2_Click1(GPanel source, GEvent event) { //_CODE_:loadingContent:208910:
  _debug(source.getText() + ": " + event);
} //_CODE_:loadingContent:208910:

synchronized public void DrawManageSongsWindow(PApplet appc, GWinData data) { //_CODE_:ManageSongsWindow:775783:
  appc.background(230);
} //_CODE_:ManageSongsWindow:775783:

public void btn_delete_file(GButton source, GEvent event) { //_CODE_:btn_delete_file_dummy:951431:
  _debug(source.getText() + ": " + event);
  
  boolean result = delete_file(source.getText().replace("Delete ", ""));
  println("deleted: " + result);
} //_CODE_:btn_delete_file_dummy:951431:

public void btn_manageSongs_back_click(GButton source, GEvent event) { //_CODE_:btn_manageSongs_back:934174:
  _debug(source.getText() + ": " + event);
  MainWindow.setVisible(true);
  ManageSongsWindow.setVisible(false);
} //_CODE_:btn_manageSongs_back:934174:

public void btn_add_file_click(GButton source, GEvent event) { //_CODE_:btn_add_file:567298:
  _debug(source.getText() + ": " + event);
   selectInput("Select a file to process:", "uploadFile");
} //_CODE_:btn_add_file:567298:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  G4P.setDisplayFont("ORANGE_SCHEME", G4P.PLAIN, 12);
  surface.setTitle("SketchWindow");
  MainWindow = GWindow.getWindow(this, "MainWindow", 0, 0, 1120, 630, JAVA2D);
  MainWindow.noLoop();
  MainWindow.setActionOnClose(G4P.EXIT_APP);
  MainWindow.addDrawHandler(this, "EXIT_APP");
  sidebar = new GPanel(MainWindow, -10, -20, 310, 640, "Sidebar");
  sidebar.setCollapsible(false);
  sidebar.setDraggable(false);
  sidebar.setText("Sidebar");
  sidebar.setOpaque(true);
  programm_name = new GLabel(MainWindow, 20, 30, 180, 30);
  programm_name.setText("MP3 Visualizer");
  programm_name.setOpaque(false);
  songlist = new GPanel(MainWindow, 10, 70, 300, 580, "Songs");
  songlist.setCollapsible(false);
  songlist.setDraggable(false);
  songlist.setText("Songs");
  songlist.setOpaque(true);
  songlist.addEventHandler(this, "songlist_click");
  songlist_song_dummy = new GButton(MainWindow, 10, 30, 280, 30);
  songlist_song_dummy.setText("MP3 Files");
  songlist_song_dummy.addEventHandler(this, "CENTER");
  songlist.addControl(songlist_song_dummy);
  sidebar.addControl(programm_name);
  sidebar.addControl(songlist);
  main_menu = new GPanel(MainWindow, 300, -20, 820, 70, "");
  main_menu.setCollapsible(false);
  main_menu.setDraggable(false);
  main_menu.setOpaque(true);
  song_title = new GLabel(MainWindow, 0, 30, 150, 30);
  song_title.setTextAlign(GAlign.LEFT, GAlign.LEFT);
  song_title.setText("Current Song");
  song_title.setOpaque(false);
  btn_manage_songs = new GButton(MainWindow, 680, 30, 120, 30);
  btn_manage_songs.setText("ManageSongs");
  btn_manage_songs.addEventHandler(this, "btn_manage_songs_click");
  main_menu.addControl(song_title);
  main_menu.addControl(btn_manage_songs);
  content_window = new GPanel(MainWindow, 300, 50, 824, 550, "Tab bar text");
  content_window.setCollapsible(false);
  content_window.setDraggable(false);
  content_window.setText("Tab bar text");
  content_window.setLocalColorScheme(GCScheme.SCHEME_8);
  content_window.setOpaque(false);
  controls = new GPanel(MainWindow, 0, 410, 820, 130, "Controls");
  controls.setCollapsible(false);
  controls.setDraggable(false);
  controls.setText("Controls");
  controls.setLocalColorScheme(GCScheme.SCHEME_8);
  controls.setOpaque(false);
  control_buttons = new GPanel(MainWindow, 280, 90, 520, 50, "");
  control_buttons.setCollapsible(false);
  control_buttons.setDraggable(false);
  control_buttons.setLocalColorScheme(GCScheme.SCHEME_8);
  control_buttons.setOpaque(false);
  btn_next = new GButton(MainWindow, 180, 10, 80, 30);
  btn_next.setText("next");
  btn_next.addEventHandler(this, "btn_next_click");
  btn_play_pause = new GButton(MainWindow, 90, 10, 80, 30);
  btn_play_pause.setText("play");
  btn_play_pause.addEventHandler(this, "btn_play_pause_click");
  btn_back = new GButton(MainWindow, 0, 10, 80, 30);
  btn_back.setText("back");
  btn_back.addEventHandler(this, "btn_back_click");
  btn_stop = new GButton(MainWindow, 420, 10, 80, 30);
  btn_stop.setText("Stop");
  btn_stop.addEventHandler(this, "btn_stop_click");
  control_buttons.addControl(btn_next);
  control_buttons.addControl(btn_play_pause);
  control_buttons.addControl(btn_back);
  control_buttons.addControl(btn_stop);
  duration_label = new GLabel(MainWindow, 190, 10, 440, 20);
  duration_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  duration_label.setText("0 / 0");
  duration_label.setOpaque(false);
  volume_label = new GLabel(MainWindow, 650, 10, 150, 20);
  volume_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  volume_label.setText("50%");
  volume_label.setOpaque(false);
  progress_slider = new GSlider(MainWindow, 190, 40, 440, 40, 10.0);
  progress_slider.setLimits(0.0, 0.0, 1.0);
  progress_slider.setNumberFormat(G4P.DECIMAL, 2);
  progress_slider.setOpaque(false);
  progress_slider.addEventHandler(this, "progress_slider_change");
  volume_slider = new GSlider(MainWindow, 650, 40, 150, 40, 10.0);
  volume_slider.setLimits(0.5, 0.0, 1.0);
  volume_slider.setNumberFormat(G4P.DECIMAL, 2);
  volume_slider.setOpaque(false);
  volume_slider.addEventHandler(this, "volume_slider_chang");
  speed_label = new GLabel(MainWindow, 20, 10, 150, 20);
  speed_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  speed_label.setText("x1");
  speed_label.setOpaque(false);
  controls.addControl(control_buttons);
  controls.addControl(duration_label);
  controls.addControl(volume_label);
  controls.addControl(progress_slider);
  controls.addControl(volume_slider);
  controls.addControl(speed_label);
  visualize_window_left = new GPanel(MainWindow, 22, 22, 379, 379, "Visualization left");
  visualize_window_left.setCollapsible(false);
  visualize_window_left.setDraggable(false);
  visualize_window_left.setText("Visualization left");
  visualize_window_left.setOpaque(true);
  visualize_window_right = new GPanel(MainWindow, 420, 20, 379, 379, "Visualization right");
  visualize_window_right.setCollapsible(false);
  visualize_window_right.setDraggable(false);
  visualize_window_right.setText("Visualization right");
  visualize_window_right.setOpaque(true);
  speed_slider = new GSlider(MainWindow, 20, 450, 150, 40, 10.0);
  speed_slider.setLimits(1.0, 0.5, 2.0);
  speed_slider.setNumberFormat(G4P.DECIMAL, 2);
  speed_slider.setOpaque(false);
  speed_slider.addEventHandler(this, "speed_slider_change");
  content_window.addControl(controls);
  content_window.addControl(visualize_window_left);
  content_window.addControl(visualize_window_right);
  content_window.addControl(speed_slider);
  debug_panel = new GPanel(MainWindow, 300, 610, 800, 20, "Tab bar text");
  debug_panel.setCollapsible(false);
  debug_panel.setDraggable(false);
  debug_panel.setText("Tab bar text");
  debug_panel.setOpaque(false);
  debug_label = new GLabel(MainWindow, 0, 0, 790, 20);
  debug_label.setOpaque(false);
  debug_panel.addControl(debug_label);
  LoadingWindow = GWindow.getWindow(this, "Loading Window", 0, 0, 1120, 600, JAVA2D);
  LoadingWindow.noLoop();
  LoadingWindow.setActionOnClose(G4P.KEEP_OPEN);
  LoadingWindow.addDrawHandler(this, "win_draw2");
  loadingContent = new GPanel(LoadingWindow, 0, 0, 1120, 600, "");
  loadingContent.setCollapsible(false);
  loadingContent.setDraggable(false);
  loadingContent.setOpaque(true);
  loadingContent.addEventHandler(this, "panel2_Click1");
  loading_file = new GLabel(LoadingWindow, 10, 180, 1100, 20);
  loading_file.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  loading_file.setOpaque(false);
  loading_amount = new GLabel(LoadingWindow, 10, 160, 1100, 20);
  loading_amount.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  loading_amount.setOpaque(false);
  loading_title_ = new GLabel(LoadingWindow, 10, 50, 1100, 20);
  loading_title_.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  loading_title_.setText("Loading Files");
  loading_title_.setOpaque(false);
  loading_slider = new GSlider(LoadingWindow, 10, 110, 1100, 40, 10.0);
  loading_slider.setLimits(0.0, 0.0, 1.0);
  loading_slider.setNumberFormat(G4P.DECIMAL, 2);
  loading_slider.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  loading_slider.setOpaque(false);
  loadingContent.addControl(loading_file);
  loadingContent.addControl(loading_amount);
  loadingContent.addControl(loading_title_);
  loadingContent.addControl(loading_slider);
  ManageSongsWindow = GWindow.getWindow(this, "Window title", 0, 0, 1120, 600, JAVA2D);
  ManageSongsWindow.noLoop();
  ManageSongsWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  ManageSongsWindow.addDrawHandler(this, "DrawManageSongsWindow");
  manageContent = new GPanel(ManageSongsWindow, 0, 0, 1120, 600, "Manage Content");
  manageContent.setCollapsible(false);
  manageContent.setDraggable(false);
  manageContent.setText("Manage Content");
  manageContent.setOpaque(true);
  manageSongsPanel = new GPanel(ManageSongsWindow, 10, 80, 1100, 510, "Mp3 Files");
  manageSongsPanel.setCollapsible(false);
  manageSongsPanel.setDraggable(false);
  manageSongsPanel.setText("Mp3 Files");
  manageSongsPanel.setOpaque(true);
  filename_dummy = new GLabel(ManageSongsWindow, 10, 40, 330, 20);
  filename_dummy.setText("Filename");
  filename_dummy.setOpaque(false);
  samplingrate_dummy = new GLabel(ManageSongsWindow, 350, 40, 100, 20);
  samplingrate_dummy.setText("SamplingRate");
  samplingrate_dummy.setOpaque(false);
  channels_dummy = new GLabel(ManageSongsWindow, 460, 40, 80, 20);
  channels_dummy.setText("Channels");
  channels_dummy.setOpaque(false);
  frames_dummy = new GLabel(ManageSongsWindow, 550, 40, 80, 20);
  frames_dummy.setText("Frames");
  frames_dummy.setOpaque(false);
  duration_dummy = new GLabel(ManageSongsWindow, 640, 40, 80, 20);
  duration_dummy.setText("Duration");
  duration_dummy.setOpaque(false);
  btn_delete_file_dummy = new GButton(ManageSongsWindow, 870, 40, 230, 20);
  btn_delete_file_dummy.setText("Face text");
  btn_delete_file_dummy.addEventHandler(this, "btn_delete_file");
  manageSongsPanel.addControl(filename_dummy);
  manageSongsPanel.addControl(samplingrate_dummy);
  manageSongsPanel.addControl(channels_dummy);
  manageSongsPanel.addControl(frames_dummy);
  manageSongsPanel.addControl(duration_dummy);
  manageSongsPanel.addControl(btn_delete_file_dummy);
  btn_manageSongs_back = new GButton(ManageSongsWindow, 920, 40, 190, 30);
  btn_manageSongs_back.setText("Back to main");
  btn_manageSongs_back.addEventHandler(this, "btn_manageSongs_back_click");
  btn_add_file = new GButton(ManageSongsWindow, 720, 40, 190, 30);
  btn_add_file.setText("Add file");
  btn_add_file.addEventHandler(this, "btn_add_file_click");
  manageContent.addControl(manageSongsPanel);
  manageContent.addControl(btn_manageSongs_back);
  manageContent.addControl(btn_add_file);
  MainWindow.loop();
  LoadingWindow.loop();
  ManageSongsWindow.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow MainWindow;
GPanel sidebar; 
GLabel programm_name; 
GPanel songlist; 
GButton songlist_song_dummy; 
GPanel main_menu; 
GLabel song_title; 
GButton btn_manage_songs; 
GPanel content_window; 
GPanel controls; 
GPanel control_buttons; 
GButton btn_next; 
GButton btn_play_pause; 
GButton btn_back; 
GButton btn_stop; 
GLabel duration_label; 
GLabel volume_label; 
GSlider progress_slider; 
GSlider volume_slider; 
GLabel speed_label; 
GPanel visualize_window_left; 
GPanel visualize_window_right; 
GSlider speed_slider; 
GPanel debug_panel; 
GLabel debug_label; 
GWindow LoadingWindow;
GPanel loadingContent; 
GLabel loading_file; 
GLabel loading_amount; 
GLabel loading_title_; 
GSlider loading_slider; 
GWindow ManageSongsWindow;
GPanel manageContent; 
GPanel manageSongsPanel; 
GLabel filename_dummy; 
GLabel samplingrate_dummy; 
GLabel channels_dummy; 
GLabel frames_dummy; 
GLabel duration_dummy; 
GButton btn_delete_file_dummy; 
GButton btn_manageSongs_back; 
GButton btn_add_file; 
