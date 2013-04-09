/*
* 1st thing about BIG data: crash your Processing/computer.
 --> save! save! save all the time!
 -------------------------------
 
 * get a sample of the big data, and made a index for yourself
 0                                  5                                                  10                                            15                                            20
 id~hotelName~stars~price~cityName~stateName~countryCode~countryName~address~location~url~tripadvisorUrl~latitude~longitude~latlong~propertyType~chainId~rooms~facilities~checkIn~checkOut~rating
 80171~Fafa Island Resort~3~172~NukuAlofa~~TO~Tonga~Fafa Island PO Box 1444~NukuAlofa
 
 */

// BufferedReader will read one line each time
BufferedReader myReader;

PFont font;

int header = 80;

void setup() {
  size(800, 700);
  colorMode(HSB, 360, 100, 100, 255);
  background(311, 95, 18);

  font = loadFont("Georgia-Italic-36.vlw");

  // manage .csv : 1) load to table; 2) load string funtioin
  // will be load into memory --> bad for big data set
  // ! so use BufferedReader
  myReader = createReader("hotelsbase.csv");

  // java environment: avoid potential crash
  // try - catch
  try {

    // ! cannot use for-loop: do not know the length of data
    // because the data is not in the memory
    // use the while-loop
    String ln;
    int c = 0; // count the line

    // the northernmost hotel
    float northernmostLat = 0;
    float northernmostLon = 0;
    int northernmostStar = 0;
    String northernmostName = null;

    // BufferedReader will read one line each time
    while ( (ln = myReader.readLine ()) != null) {
      // get the specific data
      String[] cols = ln.split("~"); // split the string in to array

      // ! got the "READER FAILED.java.lang.ArrayIndexOutOfBoundsException: 12"
      // this means: no colum 12 in this array
      // so we check the length of the array
      if (cols.length > 11) {

        // pull the star rating, and color diff ratings
        int stars = int(cols[2]); // the the star rating
        float col = map(stars, 0, 5, 0, 60);

        // pull the location data
        float lat = float(cols[12]); // get the latitude -- x
        float lon = float(cols[13]); // get the longitude -- y
        // find the northernmost hotel
        if (lat > northernmostLat) {
          northernmostLat = lat;
          northernmostLon = lon;
          northernmostName = cols[1]; // the the hotel name
          northernmostStar = int(cols[2]);
        }

        float x = 0, y = 0;
        // separate the hotels by their star rating
        switch(stars) {
        case 0:
          // map the lat/lon into the size of sketch
          x = map(lon, -180, 180, 10, width/2-5);
          // float y = map(lat, -90, 90, 0, height);// will be "up-side-down"
          y = map(lat, 90, -90, 20+header, (height-header)/3-10+header);
          break;
        case 1:
          x = map(lon, -180, 180, width/2+5, width-10);
          y = map(lat, 90, -90, 20+header, (height-header)/3-10+header);
          break;
        case 2:
          x = map(lon, -180, 180, 10, width/2-5);
          y = map(lat, 90, -90, (height-header)/3+10+header, (height-header)/3*2-10+header);
          break;
        case 3:
          x = map(lon, -180, 180, width/2+5, width-10);
          y = map(lat, 90, -90, (height-header)/3+10+header, (height-header)/3*2-10+header);
          break;
        case 4:
          x = map(lon, -180, 180, 10, width/2-5);
          y = map(lat, 90, -90, (height-header)/3*2+10+header, (height-header)-20+header);
          break;
        case 5:
          x = map(lon, -180, 180, width/2+5, width-10);
          y = map(lat, 90, -90, (height-header)/3*2+10+header, (height-header)-20+header);
          break;
        }
        // draw the point
        stroke(42, col, 85);
        point(x, y);
      }


      // ! the println need to be commented to prevent too much print work
      // println(ln); // never do this
      // instead, we count the num of line and print some of them:
      if (c % 1000 == 0) {
        // print sth simple to let you know the Processing is working
        println(c); // avoid print the content in each line
      }
      c++;
    }
    // draw the northernmost
    //    println("northernmostStar:"+northernmostStar);
    noStroke();
    float nx = map(northernmostLon, -180, 180, 10, width/2-5);
    float ny = map(northernmostLat, 90, -90, (height-header)/3*2+10+header, (height-header)-20+header);
    ellipseMode(CENTER);
    fill(0, 0, 100, 50);
    ellipse(nx, ny, 40, 40);
    fill(0,0,100,200);
    ellipse(nx, ny, 6, 6);
    textAlign(LEFT);
    textFont(font, 12);
    fill(42, 48, 85);
    text("The Northernmost Hotel:", nx+5, ny-50);
    text(northernmostName, nx+5, ny-35);
    text("Latitude: "+northernmostLat, nx+5, ny-20);
    text("Longitude: "+northernmostLon, nx+5, ny-5);
  } 
  catch(Exception e) {
    println("READER FAILED." + e);
  }
  textDisplay();
}

void draw() {
}

void mousePressed() {
  saveFrame("Hotel-####.png");
}

void textDisplay() {
  textAlign(CENTER);
  fill(42, 61, 84); 
  textFont(font, 36);
  text("0-5 Star Hotels Around The World", width/2, 70);


  // 0
  stroke(42, 0, 85);
  noFill();
  Star s00 = new Star(5, 50, 20+header, 15, 15, -PI / 2.0, 0.50);
  // 1
  noStroke();
  fill(42, 12, 85);
  Star s10 = new Star(5, width/2+45, 20+header, 15, 15, -PI / 2.0, 0.50);
  // 2
  fill(42, 24, 85);
  Star s20 = new Star(5, 50, (height-header)/3+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s21 = new Star(5, 70, (height-header)/3+10+header, 15, 15, -PI / 2.0, 0.50);
  // 3
  fill(42, 36, 85);
  Star s30 = new Star(5, width/2+45, (height-header)/3+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s31 = new Star(5, width/2+65, (height-header)/3+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s32 = new Star(5, width/2+85, (height-header)/3+10+header, 15, 15, -PI / 2.0, 0.50);
  // 4
  fill(42, 48, 85);
  Star s40 = new Star(5, 50, (height-header)/3*2+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s41 = new Star(5, 70, (height-header)/3*2+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s42 = new Star(5, 90, (height-header)/3*2+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s44 = new Star(5, 110, (height-header)/3*2+10+header, 15, 15, -PI / 2.0, 0.50);
  // 5
  fill(42, 60, 85);
  Star s50 = new Star(5, width/2+45, (height-header)/3*2+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s51 = new Star(5, width/2+65, (height-header)/3*2+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s52 = new Star(5, width/2+85, (height-header)/3*2+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s53 = new Star(5, width/2+105, (height-header)/3*2+10+header, 15, 15, -PI / 2.0, 0.50);
  Star s54 = new Star(5, width/2+125, (height-header)/3*2+10+header, 15, 15, -PI / 2.0, 0.50);
}

