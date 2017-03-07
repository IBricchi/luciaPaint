import controlP5.*;

//color sliders setup
ControlP5 cp5;
ColorPicker colPick;
Slider sizePick;

import peasy.*;

//peasy cam setup
PeasyCam cam;

//preset original value
color col = color(255,255,255);
color back = color(0,0,0);
color fi = color(255,255,255,0);
int ds = 0;
float sw = 1;
boolean move = false;
float rot = 0.1;

//arraylists
ArrayList<ArrayList> lines;
ArrayList<Integer> colors;
ArrayList<Float> sws;
ArrayList<Integer> fill;
ArrayList<Integer> drawStyle;

//variables with future setups
int count;
float x;
float y;
boolean toclickornottoclickthatisthequestion;
boolean clickCheck;

void setup(){
  //main setups
  //size(500,500,P3D);
  fullScreen(P3D);
  noCursor();
  colorMode(RGB);
  strokeJoin(ROUND);
  
  //camera
  cam = new PeasyCam(this, (height/2.0) / tan(PI*30.0 / 180.0));
  cam.setActive(false);
  cam.pan(parseFloat(width/2), parseFloat(height/2));
  
  //array list setup
  firstSet();
  
  //sliders
  noStroke();
  cp5 = new ControlP5(this);
  colPick = cp5.addColorPicker("color")
    .setPosition(20, 20)
    .setColorValue(color(255, 255, 255, 255));
  sizePick = cp5.addSlider("")
    .setPosition(20,275)
    .setSize(20,255)
    .setRange(1,50)
    .setValue(sw);
}

void draw(){
  //background
  background(back);
  
  //drawing lines
  sw = sizePick.getValue();
  col = colPick.getColorValue();
  for(int i = 1; i < lines.size(); i++){
    stroke(colors.get(i));
    strokeWeight(sws.get(i));
    fill(fill.get(i));
    beginShape();
    for(int j = 0; j < lines.get(i).size(); j += 2){
      if(drawStyle.get(i) == 0){
        curveVertex(parseFloat(lines.get(i).get(j).toString()),parseFloat(lines.get(i).get(j+1).toString()));
      }else if(drawStyle.get(i) == 1){
        point(parseFloat(lines.get(i).get(j).toString()),parseFloat(lines.get(i).get(j+1).toString()));
      }else if(drawStyle.get(i) == 2){
        lines.get(i).set(j,parseFloat(lines.get(i).get(j).toString()) + random(-0.50,0.50));
        lines.get(i).set(j + 1,parseFloat(lines.get(i).get(j + 1).toString()) + random(-0.50,0.50));
        curveVertex(parseFloat(lines.get(i).get(j).toString()),parseFloat(lines.get(i).get(j+1).toString()));
      }
    }
    endShape();
  }
  
  //cursor
  if(back == color(255,255,255)){
    stroke(0,0,0);
  }else{
    stroke(255,255,255);
  }
  strokeWeight(1);
  noFill();
  ellipse(mouseX,mouseY,sw,sw);
  
}
void mouseDragged(){
  //make points for new line
  x = float(mouseX);
  y = float(mouseY);
  if(toclickornottoclickthatisthequestion){
    //make new speace for new line
    if(lines.size() <= count){
      lines.add(new ArrayList<Float>());
    }
    lines.get(count).add(x);
    lines.get(count).add(y);
  
    //allow other line creating functions to work
    clickCheck = true;
  }
}
void mousePressed(){
  if((mouseX > 20 && mouseX < 275 && mouseY > 20 && mouseY < 80) || (mouseX > 20 && mouseX < 40 && mouseY > 255 && mouseY < 510) || (move)){
    toclickornottoclickthatisthequestion = false;
  }else{
    toclickornottoclickthatisthequestion = true;
  }
  //setting other variables for lines
  colors.add(col);
  sws.add(sw);
  fill.add(fi);
  drawStyle.add(ds);
  delay(100);
}
void mouseReleased(){
  //chack if line was drawn
  if(clickCheck){
    count++;
    clickCheck = false;
  }else{
    colors.remove(colors.size()-1);
    sws.remove(sws.size()-1);
    fill.remove(fill.size()-1);
    drawStyle.remove(drawStyle.size()-1);
  }
}
void keyPressed(){
  //eraser
  if(key == 'e'){
    colPick.setColorValue(back);
  }
  if(key == 'w'){
    colPick.setColorValue(color(255,255,255));
  }
  //clear screen
  if(key == 'C'){
    firstSet();
  }
  //reset screen
  if(key == 'R'){
    colPick.setColorValue(color(255, 255, 255, 255));
    sizePick.setValue(1);
    back = color(0,0,0);
    fi = color(255,255,255,0);
    ds = 0;
    firstSet();
  }
  //change background
  if(key == 'B'){
    for(int i = 0; i < colors.size(); i ++){
      if(colors.get(i) == back){
        colors.set(i,col);
      }
    }
    back = col;
  }
  //fill controlls
  if(key == 'f'){
    fi = colPick.getColorValue();
  } 
  if(key == 'F'){
    fi = color(255,255,255,0);
  }
  if(key == '0'){
    ds = 0;
  }
  if(key == '1'){
    ds = 1;
  }
  if(key == '2'){
    ds = 2;
  }
}

void firstSet(){
  count = 1;
  lines = new ArrayList<ArrayList>();
  lines.add(new ArrayList<Integer>());
  lines.get(0).add(1);
  colors = new ArrayList<Integer>();
  colors.add(col);
  sws = new ArrayList<Float>();
  sws.add(sw);
  fill = new ArrayList<Integer>();
  fill.add(fi);
  drawStyle = new ArrayList<Integer>();
  drawStyle.add(ds);
}