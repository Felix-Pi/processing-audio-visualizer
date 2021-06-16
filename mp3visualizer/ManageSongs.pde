public ArrayList<GTextIconBase> managementItemHolder;

public synchronized void load_files() {
  btn_delete_file_dummy.setVisible(false);
  btn_delete_file_dummy.setEnabled(false);

  managementItemHolder = new ArrayList<GTextIconBase>();

  ArrayList<String> _songFileNames = new ArrayList<String>(songFileNames);
  ArrayList<SoundFile> _songFiles = new ArrayList<SoundFile>(songFiles);

  int offset = 50;


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

    managementItemHolder.add(filename);
    managementItemHolder.add(samplingrate);
    managementItemHolder.add(channels);
    managementItemHolder.add(frames);
    managementItemHolder.add(duration);
    managementItemHolder.add(btn_delete_file);
  }

  for (GTextIconBase elem : managementItemHolder) {
    manageSongsPanel.addControl(elem);
  }
}

public void redrawManagement() {
  for (GTextIconBase elem : managementItemHolder) {
    elem.setVisible(false);
    elem.setEnabled(false);
    elem.dispose();
  }

  ManageSongsWindow.redraw();
  load_files();
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

      load_songlist();
      redraw();
      G4P.showMessage(this, "Successfully uploaded '"+ selection.getName() +"'", "INFO", 1);
      return true;
    } 


    G4P.showMessage(this, "Please select a MP3 File!", "INFO", 1);
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
