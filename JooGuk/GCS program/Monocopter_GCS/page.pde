////////////////////////////////////(Frame 1)////////////////////////////////////
void page_1() {
  background(0);
  
  if ( millis() - lastTime > 5000 ) {
    pushMatrix();
    noFill();
    stroke(#FA8D08);
    strokeWeight(width/818.1);
    ellipse(width/2.00,height/116.18,width/0.67,height/4.19);
    ellipse(width/2.00,height/1.00,width/0.67,height/4.19);
    popMatrix();
    Add_Button_Draw("+", width/1.50, height/1.36, width/14, height/13.6, true);
    Add_Button_Draw("-", width/1.33, height/1.36, width/14, height/13.6, false);
    Connection_Button_Draw(connection, width/2.49, height/3.20, width/5, height/4.6, 2);
    //lastTime = millis();
  }
  else{
    pushMatrix();
    fill(#FA8D08);
    rect(width/2.51,height/2.23,width/4.70,height/15.22);
    fill(#f7f7f7);
    textSize(width/30.9);
    text("Setting...",width/2.27,height/2.00);
    noFill();
    stroke(#FA8D08);
    strokeWeight(width/818.1);
    ellipse(width/2.00,height/116.18,width/0.67,height/4.19);
    ellipse(width/2.00,height/1.00,width/0.67,height/4.19);
    popMatrix();
  }
  
}
////////////////////////////////////(Frame 2)////////////////////////////////////
void page_2() {
  background(0);
    pushMatrix();
    noFill();
    stroke(#FA8D08);
    rect(width/2.51,height/2.23,width/4.70,height/15.22);
    strokeWeight(width/818.1);
    ellipse(width/2.00,height/116.18,width/0.67,height/4.19);
    ellipse(width/2.00,height/1.00,width/0.67,height/4.19);
    popMatrix();
}
////////////////////////////////////(Frame 3)////////////////////////////////////
void page_3() {
  background(0);
}
////////////////////////////////////(Frame 4)////////////////////////////////////
void page_4() {
  background(0);
}
////////////////////////////////////(Frame 5)////////////////////////////////////
void page_5() {
  background(0);
}
////////////////////////////////////(Frame 6)////////////////////////////////////
void page_6() {
  background(0);
}
////////////////////////////////////(Frame 7)////////////////////////////////////
void page_7() {
  background(0);
}