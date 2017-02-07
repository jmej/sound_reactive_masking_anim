PImage bg;
int seqCounter;
int frameCount;
float maxSize;
float sizeOffset;
float[] sizes =  new float[6];
int xPos=150;
float xoffset = 0;
float yoffset = 0;

void setup(){
  //size(2872, 1574);
  size(1436, 787); //low res version
  frameRate(30);
  maxSize = width * 0.0957;
  sizeOffset = maxSize / 6;
  for (int s = 0; s < 6; s++){
    sizes[s] = maxSize-sizeOffset*s;
  }
  //xoffset = width / 13.05; //why isn't this the same as width * 0.1305? (which == 374ish)
  xoffset = maxSize*1.15;
  yoffset = maxSize*0.55;
  //bg = loadImage("floorplan.jpg");
  bg = loadImage("floorplan_lowres.jpg");

}

float sizeBasedAlpha(float size){
  float alpha = 0.0;
  if (size <= maxSize){
      alpha = 255.0;
      //alpha = map(size, 0, 60, 0, 255);
    }
    if (size > (maxSize/2)){
      alpha = map(size, maxSize/2, maxSize, 255, 0);
    }
    return alpha;
}

void makeRow(float size, int rowNumber){
  float alpha = 0.0;
  noFill();
  for (int n = 0; n < 9; n++){
    strokeWeight(2);
    alpha = sizeBasedAlpha(size);
    stroke(3, 171, 255, alpha);
    ellipse (xoffset+(n*maxSize), yoffset+(rowNumber*maxSize), size, size);
  }
}

void makeRowMasking(float size, int rowNumber){
  float alpha = 0.0;
  noFill();
  for (int n = 0; n < 9; n++){
    if ((n>2) && (n<7)){
      strokeWeight(4);
      alpha = sizeBasedAlpha(size);
      stroke(3, 171, 255, alpha);
    }
    else{
      strokeWeight(2);
      alpha = sizeBasedAlpha(size);
      stroke(3, 171, 255, alpha);
    }
    ellipse (xoffset+(n*maxSize), yoffset+(rowNumber*maxSize), size, size);
  }
}

void makeConversation(float size){
  float alpha = 0.0;
  strokeWeight(4);
  alpha = sizeBasedAlpha(size);
  stroke(255, 87, 3, alpha);
  ellipse(xoffset+maxSize*4.5, yoffset+(3*maxSize)-(maxSize*0.5), size, size);
}

void draw(){
  if (frameCount < 120){
    seqCounter = 0;
    frameCount++;
  }else{
  seqCounter = (frameCount/120) % 5; //7 steps, 4 seconds each
  frameCount++;
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
      makeRow(sizes[i], 4);
      sizes[i] += 0.5;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] > maxSize) {
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
      sizes[i] += 0.5;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] >= maxSize) {
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
      sizes[i] += 0.5;
      //draw a circle using x as the height and width of the circle
      if(sizes[i] > maxSize) {
        sizes[i] = 0;
      }
    }
  }
  
  //saveFrame();
  //phase 4 - noon sounds
   //if ((seqCounter == 5) || (seqCounter == 6)){
   // for (int i = 0; i < sizes.length; i++){
   //   // make size a little bit bigger
   //   makeRow(sizes[i], 1);
   //   makeRow(sizes[i], 2);
   //   makeRow(sizes[i], 3);
   //   makeRow(sizes[i], 4);
   //   sizes[i] += 1;
   //   //draw a circle using x as the height and width of the circle
   //   if(sizes[i] > 300) {
   //     sizes[i] = 0;
   //   }
   // }
   // fill(255, 162, 31, 35);
   // noStroke();
   // ellipse(xPos, 200, 40, 300);
   // xPos=xPos+3;
   // if (xPos>width+20){
   //   xPos=-20;
   // }
  }
  
//}