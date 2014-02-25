import spacebrew.*; 
import processing.serial.*;

//define the spacebrew server location, pp name and description

String server = "sandbox.spacebrew.cc";
String name = "hungry"; 
String description = "This is an example client which publishes the value of a capacitor sensor from Arduino";

//Spacebrew connection object
Spacebrew sb;

//Serial port object
Serial myPort;

//value of tummy rub
int tummy_rub_val = 0;

//holds temp value of incoming Arduino data
int value = 0;

void setup() {
  size(300, 300);

  //instatiate the spacebrew object
  sb = new Spacebrew ( this ); 

  //add each thing you publish to
  sb.addPublish("tummy_rub", "tummyrub", str(tummy_rub_val));

  //connect to Spacebrew
  sb.connect(server, name, description); 

  //print list of serial devices to console
  println(Serial.list());
  //confirm the port your arduino is connected to
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
}


void draw() {
  background(255); 


  if (myPort.available()> 0) {
    value = myPort.read();
    println("Received data from Arduino: " + value);
  }
  else {
    println("Not connected");
  }

  tummy_rub_val = int(map(value, 0, 140, 0, 30));
  if (sb.connected()) {
    //print client name to screen
    fill(0);
    text("Connected as: " + name, width/2, 25);
    //print current value to screen
    textSize(10); 
    text(value, 25, 25);
    sb.send("tummy_rub", "tummyrub" str(tummy_rub_val));
  }
  else {
    text("Not Connected", 25, 25);
  }


  println("tummy_rub_val = " + tummy_rub_val);
  delay(10);
}

