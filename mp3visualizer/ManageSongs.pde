public void load_files() {
  ////songlist_song_dummy.setEnabled(false);
  //songlist_song_dummy.setVisible(false);
  ////songlist_song_dummy.setEnabled(false);
  //filename_dummy.setVisible(false);
  ////filename_dummy.setEnabled(false);
  //samplingrate_dummy.setVisible(false);
  ////samplingrate_dummy.setEnabled(false);
  //encoding_dummy.setVisible(false);
  ////encoding_dummy.setEnabled(false);
  //frames_dummy.setVisible(false);
  ////frames_dummy.setEnabled(false);
  //duration_dummy.setVisible(false);
  ////duration_dummy.setEnabled(false);
  //btn_delete_file_dummy.setVisible(false);
  ////btn_delete_file_dummy.setEnabled(false);


  int offset = 50;
  for (int i = 0; i < songFiles.length; i++) {
    offset += 30;

    String songName = songFileNames[i];        
    SoundFile song = songFiles[i];

    filename_dummy = new GLabel(ManageSongsWindow, 10, offset, 140, 20);
    filename_dummy.setText(songName);
    filename_dummy.setOpaque(false);
    samplingrate_dummy = new GLabel(ManageSongsWindow, 160, offset, 100, 20);
    samplingrate_dummy.setText(""+song.sampleRate());
    samplingrate_dummy.setOpaque(false);
    channels_dummy = new GLabel(ManageSongsWindow, 271, offset, 80, 20);
    channels_dummy.setText(""+song.channels());
    channels_dummy.setOpaque(false);
    frames_dummy = new GLabel(ManageSongsWindow, 360, offset, 80, 20);
    frames_dummy.setText("" + song.frames());
    frames_dummy.setOpaque(false);
    duration_dummy = new GLabel(ManageSongsWindow, 451, offset, 80, 20);
    duration_dummy.setText(""+song.duration());
    duration_dummy.setOpaque(false);
    btn_delete_file_dummy = new GButton(ManageSongsWindow, 540, offset, 256, 20);
    btn_delete_file_dummy.setText("Delete " + songName);
    btn_delete_file_dummy.addEventHandler(this, "button1_click1");
    manageSongsPanel.addControl(filename_dummy);
    manageSongsPanel.addControl(samplingrate_dummy);
    manageSongsPanel.addControl(channels_dummy);
    manageSongsPanel.addControl(frames_dummy);
    manageSongsPanel.addControl(duration_dummy);
    manageSongsPanel.addControl(btn_delete_file_dummy);
  }
}