/**
 * This is adapted from the SaveFile1 demo...
 * 
 * This accepts serial updates from any source (in my case, it
 * was a thermocouple that was immersed in a batch of beer), and 
 * writes it to a timestamped csv file.
 
 BE SURE TO PRESS x TO END THE SKETCH
 
 ...if you don't, you'll lose all the data.
 
 */

import processing.serial.*;

Serial myPort;  // Create object from Serial class
char temperature;       // Data received from the serial port
String readout = "";
PrintWriter output;
PFont fontA;
int i=0;
void setup() 
{
  size(200, 200);
  // Create a new file in the sketch directory
  output = createWriter("datalog-thermocouple-"+day()+" "+hour()+"-"+minute()+".txt");
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  frameRate(30);
  fontA = loadFont("Blox-BRK-48.vlw");
  textFont(fontA, 48);
  // List all the available serial ports:
  //println(Serial.list());
  fill(204);
  // background(0);
  noStroke();
}

void draw() 
{
  if ( myPort.available() > 0) {  // If data is available,
    temperature = char(myPort.read());         // read it and store it in val
    if(temperature=='\r') {
      output.print("\t" + millis()+"\r");
     // println(readout);
      background(0);
      text(readout,50,50);
      readout = "";
    }
    else {
      readout+=temperature;
      output.print(temperature);
    }
  }
}

void keyPressed() { // Press a key to save the data
  if (key == 'x') { // only stop when x is pressed
    output.flush(); // Write the remaining data
    output.close(); // Finish the file
    exit(); // Stop the program
  }
}

