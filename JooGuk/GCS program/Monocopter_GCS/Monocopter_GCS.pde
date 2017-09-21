/*********************************************************************
Makers guild's Monocopter GCS program.

developed by Kim Hyunjun, Lee Suhyeon, Kim Dongseok, Park Jaewan
This program follow CC-BY-NC-SA license.
Copyright by Makers guild (c) 2016
*********************************************************************/


/***********************************************************
Update log
1. Serial function include -161122- Kim Hyunjun
2. Button function include.-161122- Kim Hyunjun
3. Page function include. -161122- Kim Hyunjun
4. Time delay function include. -161122- Kim Hyunjun
***********************************************************/

import processing.serial.*;

//////////////////////////////////////////////////////////////////////////////
//Serial
String serial_list[];
String portName;
boolean check_serial_list = true;
int SERIAL_PORT_NUM = 0;
final static int SERIAL_PORT_BAUD_RATE = 115200;
float Heading_angle = 0.0f; //YAW
float Tilting_angle = 0.0f; //PITCH
float Rolling_angle = 0.0f; //ROLL

float Pressure_value = 0.0f;
float battVolts = 0.0f;
Serial serial;
//////////////////////////////////////////////////////////////////////////////
//button pressed
boolean cliked = false;
//////////////////////////////////////////////////////////////////////////////
//page
int frame=1;
//////////////////////////////////////////////////////////////////////////////
//data
float include_data=0;
//////////////////////////////////////////////////////////////////////////////
//setting GUI
PFont Main_font;
PImage connection;
//////////////////////////////////////////////////////////////////////////////
//Time value
long lastTime = 0;
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

void setup() {
  
     //fullScreen();
     Main_font=loadFont("LucidaSans-Demi-48.vlw");
     connection=loadImage("connection.png");
     textFont(Main_font);
     size(1280,720,P3D); //P3D is used to fullScreen.
     surface.setTitle("Monocopter GCS Program - Makers guild");
     lastTime = millis();
}

void draw() {
  // page_2(); //to test
  method("page_" + frame); //Show the page
   
}

//////////////////////////////////////////////////////////////////////////////
//serial function.
void serialEvent (Serial serial) {
    byte inBuffer[] = serial.readBytesUntil(10);
    if (inBuffer != null) {
      float[] nums = float(split(new String(inBuffer), ';'));
      if (nums.length == 5) {
        Heading_angle = nums[0];
        Tilting_angle = nums[1];
        Rolling_angle= nums[2];
        Pressure_value = nums[3];
        battVolts = nums[4];
      }
    }
}
//////////////////////////////////////////////////////////////////////////////
//mouse clicked
void mouseClicked(){
    if(mouseButton == LEFT)cliked= true;
  }

//////////////////////////////////////////////////////////////////////////////
//arc
void arc_meter(String content, int data,float MIN, float MAX, color Color, float xpos, float ypos, float size){
    //arc_meter(content,data,color,xpos,ypos,size);
    ellipseMode(CENTER);
    noStroke();
    int New_data = int(sqrt(include_data));
    float result;
    if(New_data>=data) 
         New_data = data;
    else include_data+=MAX*2.5;
    fill(#AAAAAA);
    ellipse(xpos,ypos,size,size);
    fill(Color);
    result = map(New_data,MIN,MAX,0,360);
    arc(xpos, ypos, size, size, radians(-90), radians(int(result)-90), PIE);
    fill(255);
    ellipse(xpos,ypos,size*0.95,size*0.95);   //Frame
    fill(0);
    textMode(CENTER);
    
    textSize(size*0.09);
    text(content,xpos-size/123,ypos-size/-(5.4));
    textSize(size*0.16);
    text(New_data/360,xpos-size/215.4,ypos-(3.5));
}