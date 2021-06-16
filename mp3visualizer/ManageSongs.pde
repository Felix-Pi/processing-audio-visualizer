public boolean inputWinowIsOpen = false;


public synchronized void load_files() {
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
  btn_delete_file_dummy.setVisible(false);
  btn_delete_file_dummy.setEnabled(false);


  int offset = 50;
  ArrayList<String> _songFileNames = new ArrayList<String>(songFileNames);
  ArrayList<SoundFile> _songFiles = new ArrayList<SoundFile>(songFiles);

  println(_songFileNames);
  println(_songFiles);
  for (int i = 0; i < _songFileNames.size(); i++) {

    offset += 30;

    String songName = _songFileNames.get(i);        
    SoundFile song = _songFiles.get(i);

    GLabel filename = new GLabel(ManageSongsWindow, filename_dummy.getX(), offset, filename_dummy.getWidth(), filename_dummy.getHeight());
    filename.setText(songName);
    filename.setOpaque(false);
    GLabel samplingrate = new GLabel(ManageSongsWindow, samplingrate_dummy.getX(), offset, samplingrate_dummy.getWidth(), samplingrate_dummy.getHeight());
    samplingrate.setText(""+song.sampleRate());
    samplingrate.setOpaque(false);
    GLabel channels = new GLabel(ManageSongsWindow, channels_dummy.getX(), offset, channels_dummy.getWidth(), channels_dummy.getHeight());
    channels.setText(""+song.channels());
    channels.setOpaque(false);
    GLabel frames = new GLabel(ManageSongsWindow, frames_dummy.getX(), offset, frames_dummy.getWidth(), frames_dummy.getHeight());
    frames.setText("" + song.frames());
    frames.setOpaque(false);
    GLabel duration = new GLabel(ManageSongsWindow, duration_dummy.getX(), offset, duration_dummy.getWidth(), duration_dummy.getHeight());
    duration.setText(""+song.duration());
    duration_dummy.setOpaque(false);
    GButton btn_delete_file = new GButton(ManageSongsWindow, btn_delete_file_dummy.getX(), offset, btn_delete_file_dummy.getWidth(), btn_delete_file_dummy.getHeight());
    btn_delete_file.setText("Delete " + songName);
    btn_delete_file.addEventHandler(this, "btn_delete_file");
    manageSongsPanel.addControl(filename);
    manageSongsPanel.addControl(samplingrate);
    manageSongsPanel.addControl(channels);
    manageSongsPanel.addControl(frames);
    manageSongsPanel.addControl(duration);
    manageSongsPanel.addControl(btn_delete_file);
  }
}

public boolean delete_file(String fileName) {
  println("delete:" + fileName);
  String path = sketchPath() + "/data/";

  File f = new File(dataPath(path + fileName));
  boolean exists = f.exists();
  if (exists) {
    f.delete();
  }

  return exists;
}


boolean uploadFile(File selection) {
  if (selection == null) {
    _debug("Window was closed or the user hit cancel.");
  } else {
    _debug("User selected " + selection.getAbsolutePath());

    if (selection.getName().contains(".mp3")) {
      _debug(selection.getName());

      String path = sketchPath() + "/data/" + selection.getName();
      File newFile = new File (path);

      selection.renameTo(newFile);
      inputWinowIsOpen = false;
      return true;
    } 

    inputWinowIsOpen = false;
    _debug("Select MP3 File!");
  }

  return false;
}

public void uploadFileSetup(File selection) {
  if (uploadFile(selection)) {
    setup();
  } else {
    selectInput("Select a file to process:", "uploadFileSetup");
  }
}

public Integer countUploadedMp3Files() {
  String path = sketchPath() + "/data/";
  File file = new File(path);
  String[] files = file.list();

  Integer counter = 0;
  for (int i = 0; i < files.length; i++) {
    if (files[i].contains(".mp3")) {
      counter +=1;
    }
  }

  return counter;
}
