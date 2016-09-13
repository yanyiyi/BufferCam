import processing.video.*;

int clickCounter = 0;
Capture cam;
PImage[] buffer;
int lagFrames = 300;
int writeBufferFrameNumber = 0, readBufferFrameNumber = 1;

void setup(){
  //size(720,1280); 
  //ScreenSize is 768 x 1360

  background(50);
  noCursor();
  fullScreen();

  cam = new Capture(this, 1024, 680);
  cam.start();
  buffer = new PImage[lagFrames];

}

void draw() {
  
  if(cam.available()) {
    cam.read();
   
    buffer[writeBufferFrameNumber] = cam.get();
    if(buffer[readBufferFrameNumber] != null){
      image(buffer[readBufferFrameNumber], 0, 0);
    } //end of buffer != null
    
    writeBufferFrameNumber++;
    readBufferFrameNumber++;
   
    //// this two if stand for Looping after buffer frames up to lagFrames setting
    
    if(readBufferFrameNumber >= lagFrames-1){
      readBufferFrameNumber = 0;
    }
    
    if(writeBufferFrameNumber >= lagFrames-1){
      writeBufferFrameNumber = 0;
    }
    
    //// end of Loop setting
    
    
  } //end of cam.available
  
   image(cam, 0, 680);
   
} // end of draw


//// After 6 clicks to stop the app
void mousePressed() {
  if(clickCounter == 5){
  exit(); 
  clickCounter=0;
  }else{
  clickCounter++;
  }
}

