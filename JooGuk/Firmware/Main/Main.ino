
/**
 *
 *Joo-Guk project.
 *
 * @brief This is opensource monocopter project @n
    * Released under GNU GPL (General Public License) v3.0 @n
    * Infos, updates, bug reports and feedback:
    * https://github.com/DroneDeveloper/Joo-Guk 
    * 
 * @details Control Android native plugin.
 * @author Park Jaewan, Lee Suhyeon, Kim Hyunjun
 * @date 2017-09-22
 * @version 0.0.1
 * @todo Create main control algorithm @n
    * Build wireless serial communication @n
    * Build magnetometer's calibration function @n
 * @see
 * UPDATE LOG @n
    * 170922 [smooth()] -> created @n
    * 170922 [loop()] -> created @n
    * 170922 [setup()] -> created @n
    * Copyright by Makers guild (c) 2017 all right reserved. @n
 * REFERENCE @n
 * https://github.com/jarzebski/Arduino-HMC5883L/blob/master/HMC5883L_compass/HMC5883L_compass.ino @n
 * https://www.researchgate.net/profile/James_Houghton3/publication/237758639_Fly-by-wire_Control_of_a_Monocopter/links/56cb530708ae1106370b84c8/Fly-by-wire-Control-of-a-Monocopter.pdf @n
 * 
 * @warning This script is not experimented. Read the script carefully please.
 */
#include <Wire.h>
#include <SoftwareSerial.h>
#include <HMC5883L.h>
#include <Servo.h>
HMC5883L compass;

//---------------------------------Control--------------------------------
Servo Throttle,aileron;

int ch1; 
int ch2; 
int ch3; 
int ch4; 
int YAW;

//----------------------------------Count---------------------------------
 int Count = 1;
 int front;
 int left;
 int right;
 int back;
 
 //----------------------------Smooth Filter------------------------------
 const int numReadings = 30;
 int readings[numReadings];      // the readings from the analog input
 int index = 0;                  // the index of the current reading
 int total = 0;                  // the running total
 
 int smooth(int aim)
{
  int average = 0; 
  total= total - readings[index];        
  readings[index] = aim; 
  total= total + readings[index];       
  index += index;                    
  if (index >= numReadings)              
   index = 0;                           
  average = total / numReadings; 
  
  return average ;
}
//------------------------------------------------------------------------

void setup() {
  #if DEBUG
    Serial.begin(OUTPUT_BAUD_RATE);
    Serial.println("Initializing..");
    while (!compass.begin())
    {
      Serial.println("Could not find a valid HMC5883L sensor.");
      delay(500);
    }
  #endif
  
  Throttle.attach(throttlePin); //Throttle
  aileron.attach(aileronPin); //aileron
    
    //Throttle.write(89);
    //aileron.write(89);
    
  // Set measurement range
  compass.setRange(HMC5883L_RANGE_1_3GA);

  // Set measurement mode
  compass.setMeasurementMode(HMC5883L_CONTINOUS);

  // Set data rate
  compass.setDataRate(HMC5883L_DATARATE_30HZ);

  // Set number of samples averaged
  compass.setSamples(HMC5883L_SAMPLES_8);

  // Set calibration offset. See HMC5883L_calibration.ino
  compass.setOffset(0, 0);
  
   ch1 = pulseIn(0, HIGH, 25000); 
   ch2 = pulseIn(1, HIGH, 25000); 
   ch3 = pulseIn(10, HIGH, 25000); 
   ch4 = pulseIn(11, HIGH, 25000);
}

void loop() {
  Vector norm = compass.readNormalize();

  // Calculate heading
  float heading = atan2(norm.YAxis, norm.XAxis);

  // Set declination angle on your location and fix heading
  // You can find your declination on: http://magnetic-declination.com/
  // (+) Positive or (-) for negative
  // For Seoul / South Korea declination angle is 4'26E (negative)
  // Formula: (deg + (min / 60.0)) / (180 / M_PI);
  float declinationAngle = (-8.0 + (23.0 / 60.0)) / (180 / M_PI);
  heading += declinationAngle;

  // Correct for heading < 0deg and heading > 360deg
  if (heading < 0)
  {
    heading += 2 * PI;
  }

  if (heading > 2 * PI)
  {
    heading -= 2 * PI;
  }

  // Convert to degrees
  float headingDegrees = heading * 180/M_PI; 
  
  YAW = headingDegrees;
    
     if ( Count <= 40)
  {
     // Firstly, set heading until 40 loop.
     front = smooth(YAW);
     Count++;
  }
  else
  {
    // Based on heading, find left, right, back direction.
    if(front == 0)
    {
      left = -90;
      right = 90;
      back = 180;
    }
    
    if(front > 0 && front < 90)
    {
      left = front - 90 ;
      right = front + 90 ;
      back = front - 180 ;
    }
    
    if(front == 90)
    {
      left = 0;
      right = 180;
      back = -90;
    }
    
    if(front > 90 && front < 180)
    {
      left = front - 90 ;
      right = front - 270 ;
      back = front - 180 ;
    }
    
    if(front == 180)
    {
      left = 90;
      right = -90;
      back = 0;
    }
    
    if(front >= -180 && front < -90)
    {
      left = front + 270 ;
      right = front + 90 ;
      back = front + 180 ;
    }
    
    if(front == -90)
    {
      left = 180;
      right = 0;
      back = 90;
    }
    
    if(front > -90 && front < 0)
    {
      left = front - 90 ;
      right = front + 90 ;
      back = front + 180 ;
    }
    
  }
  
  
  
  
    
    
    //aileron.writeMicroseconds(ch);
    //Throttle.writeMicroseconds(ch3);

}
