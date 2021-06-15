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

public void btn_manage_songs_click(GButton source, GEvent event) { //_CODE_:btn_manage_songs:731596:
  println("btn_manage_songs - GButton >> GEvent." + event + " @ " + millis());
  load_files();
  MainWindow.setVisible(false);
  ManageSongsWindow.setVisible(true);
} //_CODE_:btn_manage_songs:731596:

public void content_click(GPanel source, GEvent event) { //_CODE_:content_window:630781:
  println("content - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:content_window:630781:

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

synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:LoadingWindow:962587:
  appc.background(230);
} //_CODE_:LoadingWindow:962587:

public void panel2_Click1(GPanel source, GEvent event) { //_CODE_:loadingContent:208910:
  println("loadingContent - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:loadingContent:208910:

synchronized public void win_draw3(PApplet appc, GWinData data) { //_CODE_:ManageSongsWindow:775783:
  appc.background(230);
} //_CODE_:ManageSongsWindow:775783:

public void panel2_Click2(GPanel source, GEvent event) { //_CODE_:manageSongsPanel:638835:
  println("panel2 - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:manageSongsPanel:638835:

public void button1_click1(GButton source, GEvent event) { //_CODE_:btn_delete_file_dummy:215528:
  println("btn_delete_file_dummy - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:btn_delete_file_dummy:215528:

public void btn_manageSongs_back_click(GButton source, GEvent event) { //_CODE_:btn_manageSongs_back:934174:
  println("btn_manageSongs_back - GButton >> GEvent." + event + " @ " + millis());
  MainWindow.setVisible(true);
  ManageSongsWindow.setVisible(false);
} //_CODE_:btn_manageSongs_back:934174:

public void btn_add_file_click(GButton source, GEvent event) { //_CODE_:btn_add_file:567298:
  println("btn_add_file - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:btn_add_file:567298:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI() {
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  MainWindow = GWindow.getWindow(this, "MainWindow", 0, 0, 1024, 600, JAVA2D);
  MainWindow.noLoop();
  MainWindow.setActionOnClose(G4P.EXIT_APP);
  MainWindow.addDrawHandler(this, "EXIT_APP");
  sidebar = new GPanel(MainWindow, 0, -20, 200, 620, "Sidebar");
  sidebar.setCollapsible(false);
  sidebar.setDraggable(false);
  sidebar.setText("Sidebar");
  sidebar.setOpaque(true);
  sidebar.addEventHandler(this, "sidebar_click");
  programm_name = new GLabel(MainWindow, 10, 30, 180, 30);
  programm_name.setText("MP3 Visualizer");
  programm_name.setOpaque(false);
  songlist = new GPanel(MainWindow, 0, 70, 200, 470, "Songs");
  songlist.setCollapsible(false);
  songlist.setDraggable(false);
  songlist.setText("Songs");
  songlist.setOpaque(true);
  songlist.addEventHandler(this, "songlist_click");
  songlist_song_dummy = new GButton(MainWindow, 10, 30, 180, 30);
  songlist_song_dummy.setText("Face text");
  songlist_song_dummy.addEventHandler(this, "songlist_song_click");
  songlist.addControl(songlist_song_dummy);
  debug_panel = new GPanel(MainWindow, 0, 570, 200, 50, "Debug");
  debug_panel.setCollapsible(false);
  debug_panel.setDraggable(false);
  debug_panel.setText("Debug");
  debug_panel.setOpaque(true);
  debug_panel.addEventHandler(this, "debug_panel_click");
  debug_label = new GLabel(MainWindow, 10, 20, 180, 20);
  debug_label.setText("...");
  debug_label.setOpaque(false);
  debug_panel.addControl(debug_label);
  sidebar.addControl(programm_name);
  sidebar.addControl(songlist);
  sidebar.addControl(debug_panel);
  main_menu = new GPanel(MainWindow, 200, -20, 826, 70, "");
  main_menu.setCollapsible(false);
  main_menu.setDraggable(false);
  main_menu.setOpaque(true);
  main_menu.addEventHandler(this, "mein_menu_click");
  song_title = new GLabel(MainWindow, 10, 30, 150, 30);
  song_title.setTextAlign(GAlign.LEFT, GAlign.LEFT);
  song_title.setText("Current Song");
  song_title.setOpaque(false);
  btn_manage_songs = new GButton(MainWindow, 678, 30, 120, 30);
  btn_manage_songs.setText("ManageSongs");
  btn_manage_songs.addEventHandler(this, "btn_manage_songs_click");
  main_menu.addControl(song_title);
  main_menu.addControl(btn_manage_songs);
  content_window = new GPanel(MainWindow, 200, 50, 824, 550, "Tab bar text");
  content_window.setCollapsible(false);
  content_window.setDraggable(false);
  content_window.setText("Tab bar text");
  content_window.setLocalColorScheme(GCScheme.SCHEME_8);
  content_window.setOpaque(false);
  content_window.addEventHandler(this, "content_click");
  controls = new GPanel(MainWindow, 22, 410, 830, 130, "Controls");
  controls.setCollapsible(false);
  controls.setDraggable(false);
  controls.setText("Controls");
  controls.setLocalColorScheme(GCScheme.SCHEME_8);
  controls.setOpaque(false);
  controls.addEventHandler(this, "controls_click");
  progress_slider = new GCustomSlider(MainWindow, 0, 30, 600, 40, "grey_blue");
  progress_slider.setLimits(0.0, 0.0, 1.0);
  progress_slider.setNumberFormat(G4P.DECIMAL, 2);
  progress_slider.setOpaque(false);
  progress_slider.addEventHandler(this, "progress_slider_change");
  custom_slider2 = new GCustomSlider(MainWindow, 630, 30, 150, 40, "grey_blue");
  custom_slider2.setLimits(0.5, 0.0, 1.0);
  custom_slider2.setNumberFormat(G4P.DECIMAL, 2);
  custom_slider2.setOpaque(false);
  custom_slider2.addEventHandler(this, "custom_slider2_change1");
  control_buttons = new GPanel(MainWindow, 260, 80, 260, 50, "");
  control_buttons.setCollapsible(false);
  control_buttons.setDraggable(false);
  control_buttons.setLocalColorScheme(GCScheme.SCHEME_8);
  control_buttons.setOpaque(false);
  control_buttons.addEventHandler(this, "control_buttons_click");
  btn_next = new GButton(MainWindow, 180, 10, 80, 30);
  btn_next.setText("next");
  btn_next.addEventHandler(this, "btn_next_click");
  btn_play_pause = new GButton(MainWindow, 90, 10, 80, 30);
  btn_play_pause.setText("play");
  btn_play_pause.addEventHandler(this, "btn_play_pause_click");
  btn_back = new GButton(MainWindow, 0, 10, 80, 30);
  btn_back.setText("back");
  btn_back.addEventHandler(this, "btn_back_click");
  control_buttons.addControl(btn_next);
  control_buttons.addControl(btn_play_pause);
  control_buttons.addControl(btn_back);
  duration_label = new GLabel(MainWindow, 0, 20, 600, 20);
  duration_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  duration_label.setText("0 / 0");
  duration_label.setOpaque(false);
  volume_label = new GLabel(MainWindow, 630, 20, 150, 20);
  volume_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  volume_label.setText("50%");
  volume_label.setOpaque(false);
  controls.addControl(progress_slider);
  controls.addControl(custom_slider2);
  controls.addControl(control_buttons);
  controls.addControl(duration_label);
  controls.addControl(volume_label);
  visualize_window_left = new GPanel(MainWindow, 22, 22, 379, 379, "Visualization left");
  visualize_window_left.setCollapsible(false);
  visualize_window_left.setDraggable(false);
  visualize_window_left.setText("Visualization left");
  visualize_window_left.setOpaque(true);
  visualize_window_left.addEventHandler(this, "visualize_window_left_click");
  visualize_window_right = new GPanel(MainWindow, 420, 20, 379, 379, "Visualization right");
  visualize_window_right.setCollapsible(false);
  visualize_window_right.setDraggable(false);
  visualize_window_right.setText("Visualization right");
  visualize_window_right.setOpaque(true);
  visualize_window_right.addEventHandler(this, "visualize_window_right_click");
  content_window.addControl(controls);
  content_window.addControl(visualize_window_left);
  content_window.addControl(visualize_window_right);
  LoadingWindow = GWindow.getWindow(this, "Loading Window", 0, 0, 1024, 600, JAVA2D);
  LoadingWindow.noLoop();
  LoadingWindow.setActionOnClose(G4P.KEEP_OPEN);
  LoadingWindow.addDrawHandler(this, "win_draw2");
  loadingContent = new GPanel(LoadingWindow, 0, 0, 1030, 600, "");
  loadingContent.setCollapsible(false);
  loadingContent.setDraggable(false);
  loadingContent.setOpaque(true);
  loadingContent.addEventHandler(this, "panel2_Click1");
  loading_file = new GLabel(LoadingWindow, 10, 180, 1010, 20);
  loading_file.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  loading_file.setOpaque(false);
  loading_amount = new GLabel(LoadingWindow, 10, 160, 1010, 20);
  loading_amount.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  loading_amount.setOpaque(false);
  loading_title_ = new GLabel(LoadingWindow, 10, 50, 1010, 20);
  loading_title_.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  loading_title_.setText("Loading Files");
  loading_title_.setOpaque(false);
  loading_slider = new GSlider(LoadingWindow, 10, 110, 1010, 40, 10.0);
  loading_slider.setLimits(0.0, 0.0, 1.0);
  loading_slider.setNumberFormat(G4P.DECIMAL, 2);
  loading_slider.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  loading_slider.setOpaque(false);
  loadingContent.addControl(loading_file);
  loadingContent.addControl(loading_amount);
  loadingContent.addControl(loading_title_);
  loadingContent.addControl(loading_slider);
  ManageSongsWindow = GWindow.getWindow(this, "Window title", 0, 0, 1024, 600, JAVA2D);
  ManageSongsWindow.noLoop();
  ManageSongsWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  ManageSongsWindow.addDrawHandler(this, "win_draw3");
  manageContent = new GPanel(ManageSongsWindow, 0, 0, 1030, 600, "Manage Content");
  manageContent.setText("Manage Content");
  manageContent.setOpaque(true);
  manageSongsPanel = new GPanel(ManageSongsWindow, 9, 80, 1000, 510, "Tab bar text");
  manageSongsPanel.setText("Tab bar text");
  manageSongsPanel.setOpaque(true);
  manageSongsPanel.addEventHandler(this, "panel2_Click2");
  filename_dummy = new GLabel(ManageSongsWindow, 10, 40, 140, 20);
  filename_dummy.setText("Filename");
  filename_dummy.setOpaque(false);
  samplingrate_dummy = new GLabel(ManageSongsWindow, 160, 40, 100, 20);
  samplingrate_dummy.setText("SamplingRate");
  samplingrate_dummy.setOpaque(false);
  channels_dummy = new GLabel(ManageSongsWindow, 271, 40, 80, 20);
  channels_dummy.setText("Channels");
  channels_dummy.setOpaque(false);
  frames_dummy = new GLabel(ManageSongsWindow, 360, 40, 80, 20);
  frames_dummy.setText("Frames");
  frames_dummy.setOpaque(false);
  duration_dummy = new GLabel(ManageSongsWindow, 451, 40, 80, 20);
  duration_dummy.setText("Duration");
  duration_dummy.setOpaque(false);
  btn_delete_file_dummy = new GButton(ManageSongsWindow, 540, 40, 256, 20);
  btn_delete_file_dummy.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  btn_delete_file_dummy.setText("Face text");
  btn_delete_file_dummy.addEventHandler(this, "button1_click1");
  manageSongsPanel.addControl(filename_dummy);
  manageSongsPanel.addControl(samplingrate_dummy);
  manageSongsPanel.addControl(channels_dummy);
  manageSongsPanel.addControl(frames_dummy);
  manageSongsPanel.addControl(duration_dummy);
  manageSongsPanel.addControl(btn_delete_file_dummy);
  btn_manageSongs_back = new GButton(ManageSongsWindow, 820, 40, 190, 30);
  btn_manageSongs_back.setText("Back to main");
  btn_manageSongs_back.addEventHandler(this, "btn_manageSongs_back_click");
  btn_add_file = new GButton(ManageSongsWindow, 620, 40, 190, 30);
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
GPanel debug_panel; 
GLabel debug_label; 
GPanel main_menu; 
GLabel song_title; 
GButton btn_manage_songs; 
GPanel content_window; 
GPanel controls; 
GCustomSlider progress_slider; 
GCustomSlider custom_slider2; 
GPanel control_buttons; 
GButton btn_next; 
GButton btn_play_pause; 
GButton btn_back; 
GLabel duration_label; 
GLabel volume_label; 
GPanel visualize_window_left; 
GPanel visualize_window_right; 
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
