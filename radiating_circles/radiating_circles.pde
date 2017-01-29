PImage bg;
int seqCounter;
int[] sizes = { 
  80, 40, 20, 10, 0
};
int xoffset = 80;
int yoffset = 0;

int xPos=50;

void setup(){
  size(640, 351);
  frameRate(30);
  bg = loadImage("Nike_floorplan.jpg");
  print("setup complete");

}

void makeRow(int size, int rowNumber){
  noFill();
  for (int n = 0; n < 6; n++){
    strokeWeight(1);
    stroke(3, 171, 255);
    ellipse (xoffset+(n*100), yoffset+(rowNumber*100), size, size);
  }
}

void makeRowMasking(int size, int rowNumber){
  noFill();
  for (int n = 0; n < 6; n++){
    if ((n>0) && (n<5)){
      strokeWeight(3);
      stroke(3, 171, 255);
    }
    else{
      strokeWeight(1);
      stroke(3, 171, 255);
    }
    ellipse (xoffset+(n*100), yoffset+(rowNumber*100), size, size);
  }
}

void makeConversation(int size){
  strokeWeight(3);
  stroke(255, 87, 3);
  ellipse(width*0.5+10, 200, size, size);
}

void draw(){
  if (millis() < 5000){
    seqCounter = 0;
  }else{
  seqCounter = (millis()/4000) % 7; //7 steps, 4 seconds each
  }
  //print(seqCounter);
  background(bg);
  
  //phase 1
  if ((seqCounter == 0) || (seqCounter == 1)){
    xPos=50;
    for (int i = 0; i < sizes.length; i++){
      // make size a little bit bigger
      makeRow(sizes[i], 1);
      makeRow(sizes[i], 2);
      makeRow(sizes[i], 3);
      makeRow(sizes[i], 4);
      sizes[i] += 2;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] > 80) {
        sizes[i] = 0;
      }
    }
  }
  
  //phase 2
  if (seqCounter == 2){
    for (int i = 0; i < sizes.length; i++){
      makeConversation(sizes[i]);
      makeRow(sizes[i], 1);
      makeRow(sizes[i], 2);
      makeRow(sizes[i], 3);
      makeRow(sizes[i], 4);
      sizes[i] += 2;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] > 80) {
        sizes[i] = 0;
      }
    }
  }
    //phase 3  
    if ((seqCounter == 3) || (seqCounter == 4)){
    for (int i = 0; i < sizes.length; i++){
      makeConversation(sizes[i]);
      makeRowMasking(sizes[i], 1);
      makeRowMasking(sizes[i], 2);
      makeRowMasking(sizes[i], 3);
      makeRowMasking(sizes[i], 4);
      sizes[i] += 2;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] > 80) {
        sizes[i] = 0;
      }
    }
  }
  
  
  //phase 4 - noon sounds
   if ((seqCounter == 5) || (seqCounter == 6)){
    for (int i = 0; i < sizes.length; i++){
      // make size a little bit bigger
      makeRow(sizes[i], 1);
      makeRow(sizes[i], 2);
      makeRow(sizes[i], 3);
      makeRow(sizes[i], 4);
      sizes[i] += 2;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] > 80) {
        sizes[i] = 0;
      }
    }
    fill(255, 162, 31, 35);
    noStroke();
    ellipse(xPos, 200, 40, 300);
    xPos=xPos+2;
    if (xPos>width+20){
      xPos=-20;
    }
  }
  //saveFrame();
}