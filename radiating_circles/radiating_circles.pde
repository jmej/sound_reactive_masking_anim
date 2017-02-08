PImage bg;
int seqCounter;
int frameCount;
float maxSize;
float sizeOffset;
float[] sizes = new float[6];
float[] convoSizes = new float[6];
float[] maskingSizes = new float[6];
int xPos=150;
float xoffset = 0;
float yoffset = 0;

void setup(){
  //size(2872, 1574);
  size(1436, 787); //low res version
  frameRate(30);
  maxSize = width * 0.0957;
  sizeOffset = maxSize / 6;
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
  float alphaSized;
  noFill();
  for (int n = 0; n < 9; n++){
    if ((n>2) && (n<7)){
      strokeWeight(4);
      alphaSized = sizeBasedAlpha(size);
      if (frameCount > 500){
        if (frameCount > 625){
          alpha = 0;
        }else{
          alpha = map(frameCount, 500, 625, alphaSized, 0.0);
        }
      }else{
        alpha = alphaSized;
      }
      stroke(3, 171, 255, alpha);
    }
    else{
      strokeWeight(0);
      alpha = sizeBasedAlpha(size);
      stroke(3, 171, 255, alpha);
    }
    ellipse (xoffset+(n*maxSize), yoffset+(rowNumber*maxSize), size, size);
  }
}

void makeConversation(float size){
  float alpha = 0.0;
  float alphaSized;
  strokeWeight(4);
  alphaSized = sizeBasedAlpha(size);
    if (frameCount > 500){
      if (frameCount > 600){
        alpha = 0;
      }else{
        alpha = map(frameCount, 500, 600, alphaSized, 0.0);
      }
    }else{
      alpha = alphaSized;
    }
  stroke(255, 87, 3, alpha);
  ellipse(xoffset+maxSize*4.5, yoffset+(3*maxSize)-(maxSize*0.5), size, size);
}

void draw(){
  if (frameCount == 1080){ // 120 frames * 9 steps
    frameCount = 0;
  }
  if (frameCount < 120){
     seqCounter = 0;
     frameCount++;
     }else{
     seqCounter = (frameCount/120) % 9; //9 steps, 4 seconds each
     frameCount++;
   }
   println(frameCount);
   println(seqCounter);
   background(bg);
   //background(255);
  
  //phase 1
  if (frameCount == 1){
    for (int s = 0; s < 6; s++){
      sizes[s] = (maxSize-sizeOffset*s) - (maxSize-sizeOffset*s)*2;
    }
  }

  xPos=50;
  for (int i = 0; i < sizes.length; i++){
    float sizeToDisplay = 0; //trick to get a delay on the first handful of circles (which otherwise start with negative sizes)
    if (sizes[i] < 0){
      sizeToDisplay = 0;
    }else{
      sizeToDisplay = sizes[i];
    }
    makeRow(sizeToDisplay, 1);
    makeRow(sizeToDisplay, 2);
    makeRow(sizeToDisplay, 3);
    makeRow(sizeToDisplay, 4);
    sizes[i] += 0.5;
    if(sizes[i] > maxSize) {
      if (frameCount < 800){
        sizes[i] = 0;
      }
    }
    convoSizes[i] += 0.5;
    if(convoSizes[i] > maxSize) {
      if (frameCount < 400){
        convoSizes[i] = 0;
      }
    }
  }
  
  //phase 2
  if (frameCount == 241){
    for (int s = 0; s < 6; s++){
      convoSizes[s] = (maxSize-sizeOffset*s) - (maxSize-sizeOffset*s)*2;
    }
  }
  if (seqCounter > 1){
    for (int i = 0; i < convoSizes.length; i++){
      float sizeToDisplay = 0; //trick to get a delay on the first handful of circles (which otherwise start with negative sizes)
      if (convoSizes[i] < 0){
        sizeToDisplay = 0;
      }else{
        sizeToDisplay = convoSizes[i];
      }
      makeConversation(sizeToDisplay);
    }
  }
   //phase 3
    if (frameCount == 280){
      for (int s = 0; s < 6; s++){
        maskingSizes[s] = (maxSize-sizeOffset*s) - (maxSize-sizeOffset*s)*2;
      }
    }
    if (frameCount > 280){
      for (int i = 0; i < maskingSizes.length; i++){
        float sizeToDisplay = 0; //trick to get a delay on the first handful of circles (which otherwise start with negative sizes)
        if (maskingSizes[i] < 0){
          sizeToDisplay = 0;
        }else{
          sizeToDisplay = maskingSizes[i];
        }
          makeRowMasking(sizeToDisplay, 1);
          makeRowMasking(sizeToDisplay, 2);
          makeRowMasking(sizeToDisplay, 3);
          makeRowMasking(sizeToDisplay, 4);
          maskingSizes[i] += 0.5;
          if(maskingSizes[i] > maxSize) {
            if (frameCount < 300){
              maskingSizes[i] = 0;
            }
          }
      }
    }
  
  saveFrame();
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