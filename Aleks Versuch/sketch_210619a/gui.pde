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

public void panel1_Click1(GPanel source, GEvent event) { //_CODE_:panel1:989881:
  println("panel1 - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:panel1:989881:

public void LoadSong(GButton source, GEvent event) { //_CODE_:button1:327723:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
  if(player.isPlaying())
  {
   player.pause(); 
  }
  selectInput("Select a file to process:", "fileSelected");
} //_CODE_:button1:327723:

public void button2_click1(GButton source, GEvent event) { //_CODE_:button2:946902:
  println("button2 - GButton >> GEvent." + event + " @ " + millis());
  if(player.isPlaying())
  {
   player.pause(); 
  }
  else
  {
   player.play(); 
  }
} //_CODE_:button2:946902:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  panel1 = new GPanel(this, 34, 24, 271, 103, "Tab bar text");
  panel1.setCollapsible(false);
  panel1.setDraggable(false);
  panel1.setText("Tab bar text");
  panel1.setOpaque(true);
  panel1.addEventHandler(this, "panel1_Click1");
  button1 = new GButton(this, 19, 45, 80, 30);
  button1.setText("Load Song");
  button1.addEventHandler(this, "LoadSong");
  button2 = new GButton(this, 165, 45, 80, 30);
  button2.setText("Play/Pause");
  button2.addEventHandler(this, "button2_click1");
  panel1.addControl(button1);
  panel1.addControl(button2);
}

// Variable declarations 
// autogenerated do not edit
GPanel panel1; 
GButton button1; 
GButton button2; 
