import processing.sound.*;
import controlP5.*;


SoundFile file;
FFT fft;
Amplitude amp;
AudioIn in;
ControlP5 cp5;
Chart myChart;
Chart myChart1;
Chart myChart2;
int bands = 100;
float[] spectrum = new float[bands];
ArrayList<Float> amplitude = new ArrayList<Float>();

void setup() {
  for (int i = 0; i < bands; i++) {
    amplitude.add(0.0);
  }

  size(1200, 700);
  background(255);

  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "test.mp3");
  file.play();

  fft = new FFT(this);
  fft.input(file);

  amp = new Amplitude(this);
  amp.input(file);

  cp5 = new ControlP5(this);



  myChart = cp5.addChart("fft bar")
               .setPosition(50, 50)
               .setSize(250, 250)
               .setRange(0, 10)
               .setView(Chart.BAR_CENTERED) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(5)
               .setColorCaptionLabel(color(40))
               ;


  myChart1 = cp5.addChart("fft line")
               .setPosition(350, 50)
               .setSize(250, 250)
               .setRange(0, 10)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(5)
               .setColorCaptionLabel(color(40))
               ;

  myChart2 = cp5.addChart("amplitude")
               .setPosition(40, 400)
               .setSize(250, 250)
               .setRange(0, 10)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(5)
               .setColorCaptionLabel(color(40))
               ;

myChart.addDataSet("incoming");
myChart.setData("incoming", new float[bands]);

myChart1.addDataSet("incoming1");
myChart1.setData("incoming1", new float[bands]);

myChart2.addDataSet("incoming2");
myChart2.setData("incoming2", new float[bands]);


}

void draw() {
background(255);
  fft.analyze(spectrum);

  if(amplitude.size() == bands) {
    amplitude.remove(0);
  }
  amplitude.add(amp.analyze());

  for(int i = 0; i < bands; i++){
    myChart.push("incoming", 3 + spectrum[i] * 3 * 7 );
    myChart1.push("incoming1", 3 + spectrum[i] * 3 * 7 );
    myChart2.push("incoming2",  3 + amplitude.get(i));

  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  //line( i, height, i, height - spectrum[i] * height * 7 );
  }
}
