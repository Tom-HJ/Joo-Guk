
boolean MouseIsOver(float X_pos, float Y_pos, float Width, float Height) {
    if (mouseX > X_pos && mouseX < (X_pos + Width) && mouseY > Y_pos && mouseY < (Y_pos + Height)) {
      return true;
    }
    return false;
  }
 void Add_Button_Draw(String contents, float X_pos, float Y_pos, float Width, float Height, boolean Value_set){
   pushMatrix();
   noFill();
   stroke(#FA8D08);
   rect(X_pos,Y_pos,Width,Height);
    if(MouseIsOver(X_pos,Y_pos,Width,Height)){
      stroke(#E5D6C3);
      rect(X_pos,Y_pos,Width,Height);

     if(cliked){  //Check value and reset the SERIAL_PORT_NUM // Basic SERIAL_PORT_NUM is 0
       if(!Value_set){
          if(SERIAL_PORT_NUM<1) SERIAL_PORT_NUM=0;
          else SERIAL_PORT_NUM--;
       }
       else {
          if(SERIAL_PORT_NUM>=serial_list.length) SERIAL_PORT_NUM=serial_list.length;
          else SERIAL_PORT_NUM++;
          println(SERIAL_PORT_NUM);
         }
         cliked=false;
       }
     }
     else {
       stroke(#FA8D08);
       rect(X_pos,Y_pos,Width,Height);
     }
    
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(width/28.1);
    text(contents, X_pos + (Width / 2), Y_pos + (Height / 2.63));
    popMatrix();
  }
  
 void Connection_Button_Draw(PImage image, float X_pos, float Y_pos, float Width, float Height, int Frame){
   //image(image,X_pos,Y_pos,Width,Height);
   pushMatrix();
   noFill();
   serial_list = Serial.list();
   portName = Serial.list()[SERIAL_PORT_NUM];
   textAlign(CENTER, CENTER);
    fill(254);
    textSize(width/91.3);
    
    for(int i=0; i<serial_list.length; i++){
        text(serial_list[i],X_pos + (i*(Width/3.43)) + (Width*-0.22), Y_pos + (Height / 0.56));
      }
      
    text("AVAILABLE SERIAL PORTS :",X_pos + (Width / 11.63), Y_pos + (Height / 0.62));
    text("SET THE SERIAL PORT NUMBER :",X_pos + (Width / 6.36), Y_pos + (Height / 0.50));
    text("Using port (" + SERIAL_PORT_NUM + ") : " + portName,X_pos + (Width / 115.11), Y_pos + (Height / 0.46));
    
  
   if(MouseIsOver(X_pos,Y_pos,Width,Height)){
     noFill();
      image(image,X_pos,Y_pos,Width,Height);
      stroke(#E5D6C3);
      rect(X_pos,Y_pos,Width,Height);
     if(cliked){
       serial = new Serial(this, portName, SERIAL_PORT_BAUD_RATE);
       serial.clear();
            frame = Frame;
            print("frame: ");
            println(frame);
       cliked = false;
      }
      
   }
   else {
     noFill();
    stroke(#FA8D08);
    image(image,X_pos,Y_pos,Width,Height);  
    rect(X_pos,Y_pos,Width,Height);
   }
   popMatrix();
 }
 
 void Button_Draw(String contents, float X_pos, float Y_pos, float Width, float Height, int Frame){
    pushMatrix();
    noFill();
    if(MouseIsOver(X_pos,Y_pos,Width,Height)){
      stroke(#E5D6C3);
      rect(X_pos,Y_pos,Width,Height);
     if(cliked){
         frame = Frame;
         cliked = false;
         print("frame: ");
         println(frame);
      }
    }
    else {
      stroke(#FA8D08);
      rect(X_pos,Y_pos,Width,Height);
    }
    
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(width/70.9);
    text(contents, X_pos + (Width / 2), Y_pos + (Height / 0.98));
    popMatrix();
  }
  