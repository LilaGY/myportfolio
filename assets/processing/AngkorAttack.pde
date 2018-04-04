//make a new HTML5 audio object named audio
Audio youpi = new Audio();
Audio theme = new Audio();
// make string that will house the audio extension
String youpifile, themefile;

youpifile = "dataAngkorAttack/youpi.wav";
themefile = "dataAngkorAttack/theme.mp3";

youpi.setAttribute("src", youpifile);
theme.setAttribute("src", themefile);
 
//make a variable for volume and set it to 0
//(volume runs between 0 and 1)
float vol = 0;
//make a boolean to keep track when we are fading
bool fadeOut = false;
int col = 0;

class Laser {
  //member variables
  float lsXFixed;
  boolean show,powerup;
  
  Laser() {
  }
  void display(int n) {
    fill(240,240,0);
    if (show) {
      lsX = lsXFixed;
      if (lsY>0) {
        lsY-=15;
        //image(singe[n], lsX,lsY, 60, 56.7);
        image(singe[n], lsX,lsY, 60, 56.7);
      }
      
      //collision detection
      if (lsY<0 || hit == true) {
        show = false;
        hit = false;
      }
    }
  }
  
  void shoot() {
    if (startGame) {
      if (mousePressed && show == false) {
        lsXFixed = ssX;
        lsY = 392;
        show = true;
       }
    }
  }
}

class Spaceship {

  //constructor
  Spaceship() {
  }

  void display(int n) {

    fill(220,0,0);

    /*triangle(ssX+35,495,ssX+45,490,ssX+45,465);
    triangle(ssX+65,495,ssX+55,490,ssX+55,465);
    triangle(ssX+58,485,ssX+42,485,ssX+50,460);*/
    ssY = 392;
    image(singe[n],ssX,ssY,60,56.7);

    if ((millis()>0 && millis()<6000)){
      
      fill(255);
      textSize(40);
      if (millis()>2000 && millis()<=3000) {
        text("3",width/2-10,height/2);
      } else if (millis()>3000 && millis()<=4000) {
        text("2",width/2-10,height/2);
      } else if (millis()>4000 && millis()<=5000) {
        text("1",width/2-10,height/2);
      } else if (millis()>5000) {
        startGame = true;
      }
      
    }
  }
  
  void steer() {
    ssX = mouseX-50;
    
  }
}

class Aliens {
  //member variables
  float aX, aY, groupX, groupY;
  int dir, lvl;
  boolean dead, wait;
  

  Aliens(float aX, float aY, int lvl) { //float aW, float aH
    this.aX = aX;
    this.aY = aY;
    this.lvl = lvl;
    dead = false;
    groupX = 10;
    dir = 1;
    wait = false;
  }

  void display() {
    if (!dead && lvl == 1) {
      fill(150, 150, 0);
      image(banane[0], aX, aY, 50, 40);
      //image(banane[1], aX-7, aY+5, 20, 15);
      //image(banane[0], aX+27, aY+5, 20, 15);
      //image(banane[1], aX+10, aY+5, 20, 15);
    }
    if (!dead && lvl == 2) {
      fill(245, 236, 27);
      image(banane[1], aX, aY, 50, 40);
      //image(banane[1], aX-7, aY+5, 20, 15);
      //image(banane[0], aX+27, aY+5, 20, 15);
      //image(banane[1], aX+10, aY+5, 20, 15);
   }
    
  }

  void travel() {
    if (startGame == true && dead == false) {
      if (lvl == 1) {
        if (sec>500 && sec<517) {
          aX+=37*dir;
          groupX+=37*dir;
          wait = true;
        } else if (groupX>=121 || groupX<=10) {  //if the millis>800 for a given second
          if (wait == true && sec>800) {
            aY+=50;
            dir*=-1;
            wait = false; //keeps the ships from shooting down off the screen
          }
        }
      }
      if (lvl == 2 && counter>=15) {
        if (sec>400 && sec<417 || sec>900 && sec<917) {
          aX+=37*dir;
          groupX+=37*dir;
          wait = true;
        } else if (groupX>=121 || groupX<=10) {  //if the millis>800 for a given second
          if (wait == true && sec>800) {
            aY+=45;
            dir*=-1;
            wait = false; //keeps the ships from shooting down off the screen
          }
        }
      }
    }
  }

  void collision() { 
    if (aX-27<lsX && aX+57>lsX && aY<lsY && aY+35>lsY) {
      dead = true;
      hit = true;
      youpi.play();
      counter+=1;
      aY-=2000;
      aX+=1000;
      println(counter);
    }
    if (counter == 15 && aY<0) {
      lvl = 2;
      aY+=400;
    }
  }
  
  void gameover() {
    textSize(40);
    if (aY>=392) {
      startGame = false;
      fill(255);
      text("GAME OVER",width/2-110,height/2);
    }
    if (counter>=30) {
      startGame = false;
      fill(255);
      image(cup,155,155,170,170);
      text("YOU WIN !",155,370);
    }
  }
}

//Declare Spaceship (monkeys)
Spaceship s1;

//Declare Laser
Laser l1;

//Declare aliens
Aliens[] aliens = new Aliens[30];

//declare monkey's and lazer's positions
float ssX, ssY, lsX, lsY;
int counter, sec;

//startGame boolean variable, true when mouse
//first click happens
boolean startGame,hit;

//declare ints
int seuilnuage=300;
int nbsinge=3;
int nbnuage=10;
int nbbanane=2;

//declare clouds positions arrays
float [] nuageX = new  float[nbnuage] ;
int [] nuageY = new int[nbnuage] ;

//declare monkeys and bananas
int n = int(random(0,3));
PImage [] singe = new PImage[nbsinge];
PImage [] banane = new PImage[nbbanane];
//declare background images
PImage ciel;
PImage temple;
PImage nuage;
PImage cup;

//First launched function, called only once
void setup() {
  noCursor();
  counter = 0;
  startGame = false;
  
  //define frame size
  size(500,700);
  background(0);
  
  //load pictures
  banane[0] = loadImage("dataAngkorAttack/banane.png");
  banane[1] = loadImage("dataAngkorAttack/banane2.png");
  singe[1] = loadImage("dataAngkorAttack/singe.png");
  singe[2] = loadImage("dataAngkorAttack/singe2.png");
  singe[0] = loadImage("dataAngkorAttack/singe3.png");
  ciel = loadImage("dataAngkorAttack/ciel.png");
  temple = loadImage("dataAngkorAttack/temple.png");
  nuage = loadImage("dataAngkorAttack/nuage.png");
  cup = loadImage("dataAngkorAttack/cup.png");
  
  //load sounds
  //youpi = new SoundFile(this, "dataAngkorAttack/youpi.wav");
  //theme = new SoundFile(this, "dataAngkorAttack/theme.mp3");
  
  //play main theme
  theme.play();
  
  //Pop clouds
  for (int i=0; i<nbnuage;i++){
    nuageX[i]=random(-200,550);
    nuageY[i]=int(random(0,seuilnuage));
  }
 
  //new instance of Laser and Shipspace class
  l1 = new Laser();
  s1 = new Spaceship();
  
  //Pop aliens
  for (int i=0;i<15;i++) { // lvl 2 aliens
    aliens[i] = new Aliens((20+80*(i%5)),(40+floor(i/5)*40)-400,2);
  }
  for (int i=15;i<30;i++) { //lvl 1 aliens
    aliens[i] = new Aliens((20+80*((i-15)%5)),(40+floor((i-15)/5)*40),1);
  }
}


//Second launched function, 
//looped while the program runs
void draw() {
  
  //draw sky and temple 
  image(ciel, 0, 0);
  image(temple, -12, 426);
  
  //draw clouds
  for (int i=0; i<nbnuage;i++){
    image(nuage,nuageX[i],nuageY[i],100,50);
  }
  
  //define framerate
  frameRate(60);
  
  //background(0);
  sec = millis()-1000*floor(millis()/1000);
  
  //make aliens move
  for (int i=0;i<aliens.length;i++) {
    aliens[i].display();
    aliens[i].travel();
    aliens[i].collision();
  
    //only way i found to draw clouds under aliens.
    //modulo condition is intended to make the refresh
    //slower
    if (i % 10000000 == 0) {
      redraw_nuages();
    }
    
    aliens[i].gameover();
  }
  
  // lazer and spaceship display (n being a 
  // random monkey sprite generated by new_singe
  // function when mouse is clicked -> firing lazers)
  s1.steer();
  l1.display(n);
  l1.shoot();
  s1.display(n);
  new_singe();
}

//random new monkey 
void new_singe(){
  //when mouse is pressed = lazer is fired
  if (mousePressed == true){
      n = int(random(0,3)); 
      s1.display(n);
      }
}

//change clouds positions and redraw them 
//clouds are moving at various speeds
void redraw_nuages(){
  for (int i=0; i<nbnuage; i++){
    //if cloud get out of the frame 
    if (nuageX[i]>500){
    nuageX[i] = -150;
    }
    else if ((nuageX[i]<500) && (i % 3 == 0)){
      nuageX[i] += 1;
    }
    else if ((nuageX[i]<500) && (i % 2 == 0)){
      nuageX[i] += 0.6;
    }
    else{
      nuageX[i] += 0.3;
    }
  }
  //redraw
  for (int i=0; i<nbnuage;i++){
    image(nuage,nuageX[i],nuageY[i],100,50);
  } 
}
  
