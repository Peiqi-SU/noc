// Peiqi Su
// Nature of Code for Data Viz
PFont font;
int countries = 78;
int years = 10;
String countryName[] = new String[countries];
String thisCountry;
ArrayList countryNumber = new ArrayList(countries);

Mover[] movers = new Mover[10];

Liquid liquid;
int topHeight = 100;

void setup() {
  size(800, 600);
  loadData("Energy_statistics_2009_Oil_consumption.csv");
  font = loadFont("Whitney-BlackItalic-48.vlw");
  reset();
  // Create liquid object
  liquid = new Liquid(0, topHeight, width, height-topHeight, 0.1);
}

void draw() {
  background(0, 74, 79);

  // Draw water
  liquid.display();

  for (int i = 0; i < movers.length; i++) {

    // Is the Mover in the liquid?
    if (liquid.contains(movers[i])) {
      // Calculate drag force
      PVector dragForce = liquid.drag(movers[i]);
      // Apply drag force
      movers[i].applyForce(dragForce);
    }

    // Apply gravity
    PVector gravity = new PVector(0, -0.1*movers[i].mass);
    movers[i].applyForce(gravity);

    // Update and display
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();

    // Draw a line to connect each oil drop
    if (i<movers.length-1) {
      stroke(0);
      line(movers[i].location.x, movers[i].location.y, movers[i+1].location.x, movers[i+1].location.y);
    }
  }
  textDisplay();
}

void mousePressed() {
  reset();
}

// Create an 2D array to store the country name and numbers.
// country num = 78; year num = 10
// each row: countryName | 1965 | 1970 | ... | 2005 | 2009
void loadData(String url) {
  Table t = loadTable(url);
  t.removeTitleRow();
  // each country
  for (int j = 0; j < countries; j++) {
    countryName[j] = t.getString(j, "Thousand barrels daily");
    int number[] = new int[years];
    // Load the number of each year.
    for (int i = 0; i < years; i++) {
      if (i == years-1) {
        number[i] = t.getInt(j, "2009");
        //        println(i+":"+number[i]);
      }
      else {
        String temp = nf(1965+i*5, 4);
        number[i] = t.getInt(j, temp);
        //        println(i+":"+number[i]);
      }
    }
    countryNumber.add(number);
  }
}

// Restart all the Mover obj
void reset() {
  int n = round(random(0, countries));
  // Display the country name
  thisCountry = countryName[n];

  // Visualize the number
  int[] temp = (int[]) countryNumber.get(n);

  for (int i = 0; i < movers.length; i++) {
    //    movers[i] = new Mover(random(0.5, 3), 100+i*65, height);
    // Map the mass to radius
    float thisMass = map(temp[i], min(temp), max(temp), 1, 3.5);
    //    println(i+":"+temp[i]);
    movers[i] = new Mover(temp[i], thisMass, 100+i*65, height);
  }
}

// Display the texts on the interface
void textDisplay() {

  // Display the country name
  textAlign(CENTER);
  fill(255, 150); 
  textFont(font, 18);
  text("*thousand barrels daily", width/2+20, 263);
  textFont(font, 36);
  text("Oil Consumption in", width/2, 290);
  fill(223, 230, 114);
  textFont(font, 48);
  text(thisCountry, width/2, 350);

  // Display the instructions
  fill(223, 230, 114, 150); 
  textFont(font, 18);
  textAlign(CENTER);
  text("click mouse to change contry", width/2, 380);

  // Display the years
  fill(0, 175);
  textFont(font, 14);
  for (int i = 0; i < years; i++) {
    if (i == years-1) {
      text("2009", 100+i*65, topHeight-40);
    }
    else {
      String temp = nf(1965+i*5, 4);
      text(temp, 100+i*65, topHeight-40);
    }
  }
}

