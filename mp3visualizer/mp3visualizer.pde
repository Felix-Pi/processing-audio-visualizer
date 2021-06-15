// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
import peasy.*;

public void load_songlist() {
  //disable dummy button (appearently needed for handler creation)
    songlist_song_dummy.setEnabled(false);
    songlist_song_dummy.setVisible(false);
    String path = sketchPath() + "/data/";
    File file = new File(path);
    String[] files = file.list();

    int offset = 0;
    for (int i = 0; i < files.length; i++) {

            offset += 30;

        
        String f = files[i];
        println(f);
        
        
        GButton song = new GButton(MainWindow, 10, offset, 180, 20);
        song.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
        song.setText(f);
        song.addEventHandler(this, "songlist_song_click");
        songlist.addControl(song);
    }
}
    
public void setup(){
  
  createGUI();
  customGUI();
  // Place your setup code here
    
}

public void draw(){
  background(230);
  
}




/* CUSTOM GUI */

public void songlist_song_click(GPanel source, GEvent event) { //_CODE_:songlist:251911:
  println(source.getText() + " >> GEvent." + event + " @ " + millis());
} //_CODE_:songlist:251911:


// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
  load_songlist();
}
