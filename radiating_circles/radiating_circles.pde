PImage bg;
int seqCounter;
int[] sizes = { 
  300, 250, 200, 150, 100, 50
};
int xoffset = 300;
int yoffset = 0;

int xPos=50;

void setup(){
  size(2872, 1574);
  frameRate(30);
  bg = loadImage("floorplan.jpg");
  print("setup complete");

}

float sizeBasedAlpha(int size){
  float alpha = 0.0;
  if (size <= 250){
      alpha = 255.0;
      //alpha = map(size, 0, 60, 0, 255);
    }
    if (size > 150){
      alpha = map(size, 150, 300, 255, 0);
    }
    return alpha;
}

void makeRow(int size, int rowNumber){
  float alpha = 0.0;
  noFill();
  for (int n = 0; n < 6; n++){
    strokeWeight(1);
    alpha = sizeBasedAlpha(size);
    stroke(3, 171, 255, alpha);
    ellipse (xoffset+(n*600), yoffset+(rowNumber*300), size, size);
  }
}

void makeRowMasking(int size, int rowNumber){
  float alpha = 0.0;
  noFill();
  for (int n = 0; n < 6; n++){
    if ((n>0) && (n<5)){
      strokeWeight(3);
      alpha = sizeBasedAlpha(size);
      stroke(3, 171, 255, alpha);
    }
    else{
      strokeWeight(1);
      alpha = sizeBasedAlpha(size);
      stroke(3, 171, 255, alpha);
    }
    ellipse (xoffset+(n*600), yoffset+(rowNumber*300), size, size);
  }
}

void makeConversation(int size){
  float alpha = 0.0;
  strokeWeight(3);
  alpha = sizeBasedAlpha(size);
  stroke(255, 87, 3, alpha);
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
  //background(255);
  
  //phase 1
  if ((seqCounter == 0) || (seqCounter == 1)){
    xPos=50;
    for (int i = 0; i < sizes.length; i++){
      // make size a little bit bigger
      makeRow(sizes[i], 1);
      makeRow(sizes[i], 2);
      makeRow(sizes[i], 3);
      sizes[i] += 1;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] > 300) {
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
      sizes[i] += 1;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] >= 300) {
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
      sizes[i] += 1;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] > 300) {
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
      sizes[i] += 1;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] > 300) {
        sizes[i] = 0;
      }
    }
    fill(255, 162, 31, 35);
    noStroke();
    ellipse(xPos, 200, 40, 300);
    xPos=xPos+3;
    if (xPos>width+20){
      xPos=-20;
    }
  }
  //saveFrame();
}