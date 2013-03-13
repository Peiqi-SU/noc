/***---------------------------------------------------------
 Peiqi SU | Spring 2013, @ITP
 Nature of Code - Midterm
 ---------------------------------------------------------***/
Flock flock;
float r = 50; // The border of motion
Ripple ripple;
import processing.serial.*;

//  Serial port stuff ///////////////////////
int inByte; // the value send from arduino
Serial myPort;        
boolean firstContact = true; 
int NumOfBars=64;    // keep the same number with Arduino:#define BARS XX
//for one mic
int[] serialInArray = new int[NumOfBars];
int serialCount = 0;
boolean mic1 = false;
//for another mic
int[] serialInArray2 = new int[NumOfBars];
int serialCount2 = 0;
boolean mic2 = false;

int theMaxVolum = 0;
int theMaxBarNum = 0;
int theMaxVolum2 = 0;
int theMaxBarNum2 = 0;

boolean voiceControl = false;
// modify the constants here //////////////////////////////////////
final int MINBAR = 6;  // include this bar
final int MAXBAR = 14;  // not include this bar
final int VOICE_THRESHOLD_COME = 50;
final int VOICE_THRESHOLD_COME_2 = 50;
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////

void setup() {
  /// NB SETTINGS ------------------------------------
  myPort = new Serial(this, Serial.list()[4], 57600); 
  //--------------------------------------------------

  size(800, 800);
  colorMode(HSB, 360, 100, 100, 255);
  ellipseMode(CENTER);
  flock = new Flock();
  frameRate(30);
  ripple = new Ripple(0, height/2, 43, 100, 100, 255);
}

void draw() {
  background(255);
  flock.run();
}

// Press key to arract animals to a place
void keyPressed() {
  // e = when eastern people sit
  if (key == 'e' || key == 'E') {
    println("call bird");
    callBird = true;
    hasripple = true;
    ripple = new Ripple(width, height/2, 43, 100, 100, 255);
    ripple.render();
  }
  if (key == 'w' || key == 'W') {
    println("call fish");
    callFish = true;
    hasripple = true;
    ripple = new Ripple(0, height/2, 323, 100, 100, 255);
    ripple.render();
  }
}

// Send Recieve data. Called when data is available
void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  inByte = myPort.read();
  if (firstContact == true) {
    if (inByte == 'A') { 
      myPort.clear();          // clear the serial port buffer
      firstContact = false;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  }
  else {

    // 255 = switch analog input to A1 = mic1 = top bars
    if (inByte == 255) {
      mic1 = true;
      mic2 = false;
      serialCount = 0;
      myPort.clear(); 
      //      println("R");
    }
    // 254 = switch analog input to A2 = mic2 = bottom bars
    else if (inByte == 254) {
      mic2 = true;
      mic1 = false;
      serialCount2 = 0;
      myPort.clear(); 
      //      println("L");
    }
    else if (mic1 && !mic2) {
      // Add the latest byte from the serial port to array:
      serialInArray[serialCount] = inByte;

      if (serialCount>=MINBAR && serialCount<MAXBAR) {
        // find the hithest voice
        if (serialInArray[serialCount]>theMaxVolum) {
          theMaxVolum = serialInArray[serialCount];
          theMaxBarNum = serialCount;
        }
      }
      //
      if (serialCount == NumOfBars-1 ) {
        // Reset serialCount:
        serialCount = -1;
        // draw ellipse
        soundControl1(theMaxVolum, theMaxBarNum);
        theMaxVolum = 0;
        theMaxBarNum = 0;
        // Send a capital A to request new sensor readings:
        myPort.write('A');
      }
      serialCount++;
    }
    else if (mic2 && !mic1) { 
      // Add the latest byte from the serial port to array:
      serialInArray2[serialCount2] = inByte;

      // find the hithest voice
      if (serialCount2>=MINBAR && serialCount2<MAXBAR) {
        // find the hithest voice
        if (serialInArray2[serialCount2]>theMaxVolum) {
          theMaxVolum = serialInArray2[serialCount2];
          theMaxBarNum = serialCount2;
        }
      }
      // If we have 6 bytes:
      if (serialCount2 == NumOfBars-1 ) {
        // Reset serialCount:
        serialCount2 = -1;
        // draw ellipse
        soundControl2(theMaxVolum, theMaxBarNum);
        theMaxVolum = 0;
        theMaxBarNum = 0;
        // Send a capital A to request new sensor readings:
        myPort.write('A');
      }
      serialCount2++;
    }
    else {
      //      println("else what!!! inByte:"+inByte+"-- mic1:"+mic1+"-- mic2:"+mic2);
    }
  }
}
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
/***------------simulation: use keyboard to control program instead of sound ----------------***/
void soundControl1(int maxVolum, int atFrequency) {
  if (maxVolum >= VOICE_THRESHOLD_COME) {
    println("call bird");
    callBird = true;
    hasripple = true;
    ripple = new Ripple(width, height/2, 43, 100, 100, 255);
    ripple.render();
  }
}
//////////////////////////////////////////////////////////////////////
void soundControl2(int maxVolum, int atFrequency) {

  // w = when western people speak
  if (maxVolum >= VOICE_THRESHOLD_COME_2) {
    println("call fish");
    callFish = true;
    hasripple = true;
    ripple = new Ripple(0, height/2, 323, 100, 100, 255);
    ripple.render();
  }
}

