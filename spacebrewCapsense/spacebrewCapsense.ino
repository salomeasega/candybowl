#include <CapacitiveSensor.h>

/*

DESCRIBE THIS SKETCH HERE

*/

CapacitiveSensor cs_2_4 = CapacitiveSensor(2,4);

void setup() {
  
  //open serial port
  Serial.begin(9600); 
}

  void loop() {
    
  //set up variable to read conductive thread
   long sensorVal = cs_2_4.capacitiveSensor(30);
   
   //print value of conductive thread to serial
   Serial.print("conductive thread : ");
   Serial.println(sensorVal);
   delay(100);
   
   Serial.write(sensorVal);
   
  }
