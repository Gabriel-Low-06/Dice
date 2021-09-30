
int[]pileheight = new int[11]; //declare array to store how many dice have built up
int count = 0; //declare int to store sum of all die
int avgheight = 0;
int avgg = 0;

class Dice{ //declare dice class
  int myValue, myX, myY, myR, myC;
  float myS, myXV, myYV, myRV, myG;

  Dice(int x,int y, int r, float s){
    myValue = 1;
    myX = x; //x position of die
    myY = y;//y position of die
    myR = r;//rotation of die
    myG = 0;//height die lands on pile
    myS = s;//size of die
    myC = 0;//how many times die has bounced
   myXV = random(-3,3); //velocity of die in x direction
   myYV = random(-3,3);// y velocity
   myRV = random(-4,4);// rotational velocity (spin)

   
  }

  void roll(){
    if(mousePressed==true && mouseX>myX-30 && mouseX<myX+30 &&mouseY>myY-30 && mouseY<myY+30){
    myValue = (int)(Math.random()*6+1); //if individual die clicked, roll for new value
    myR+=(int)(random(-30,30));
    }
  }
  
  void launch(){
   myXV = random(-10,10); //launch die into sky
   myYV = random(-10,-5); //reset other values
   myRV = random(-4,4);
   myValue= (int)(random(1,7));// roll random value
   myG=0;
   myC = 0;
  }
  
  void show(){  
    
  float realspin = myR/57.3; //convert degrees to radians
  pushMatrix();
  translate(myX,myY); 
  rotate(realspin); //rotate die
  fill(300,300,300);
  rect(-20*myS,-40*myS,60*myS,60*myS); //draw square of dice
  
    fill(0,0,0);
    if(myValue==1||myValue==3 || myValue==5){ //draw pattern on dice
      ellipse(10*myS,-10*myS,10*myS,10*myS);
    } if(myValue==2 || myValue==3){
      ellipse(10*myS,-22*myS,10*myS,10*myS);
      ellipse(10*myS,2*myS,10*myS,10*myS);
    }
    if(myValue==4 || myValue==5 ||myValue==6){
      ellipse(23*myS,-22*myS,10*myS,10*myS);
      ellipse(23*myS,2*myS,10*myS,10*myS);
      ellipse(-3*myS,-22*myS,10*myS,10*myS);
      ellipse(-3*myS,2*myS,10*myS,10*myS);
    }
    if(myValue==6){
      ellipse(10*myS,-22*myS,10*myS,10*myS);
      ellipse(10*myS,2*myS,10*myS,10*myS);
    }
   translate(-myX,-myY);
  popMatrix(); //reset to normal grid to draw other die
  
  if(myC<7){ //if object hasn't bounced too much, update position
  myY+=myYV;
  myX+=myXV;
  }
  myYV=constrain(myYV+.08,-500,500); //change velocity from gravitational acceleration
  
  if(myX>1100||myX<0){ //bounce off walls
    myXV=-0.75*myXV;
    myRV = -.9*myRV;
      if(abs(myXV)<.1){
    myXV = 0; //if almost stopped, stop it fully
    
  }
  }
  if(myY>(300-(pileheight[constrain(myX/100,0,10)]*18)-myS) &&myG==0){ //when object first hits ground, calculate height of "pile it lands on" based on how many die are already there
    myG=(300-(pileheight[constrain(myX/100,0,10)]*18)-myS); 
    pileheight[constrain(myX/100,0,10)] += myS;
  }
  if((myY>myG)&&(myG!=0)&&(myYV>0)||(myY<0)&&(myYV<0)){ //bounce off ground and ceiling
    myYV= myYV/-2;
    myRV = -.9*myRV;
    myXV=myXV*.3;
    myC+=1;
  
  if(myC>6){ //if object has bounced too much, stop it
    myYV = 0;
    myRV=0;
    myXV=0;
  }

  }
  myR+=myRV;//update rotation based on spin
  count+=myValue;//update sum of values on die
  
  avgheight+=myY;
  avgg+=myG
  }
}
  


Dice[]die = new Dice[60];

void setup(){
  int i=0;
for(int radius = 300; radius>0; radius-=80){//code to arrange die in concentric circles at beinning
for(float x = 300-radius; x<300+radius; x+=100){

 float y = sqrt(sq(radius) - sq(x-300))+300;
    if(i<60){
    die[i] = new Dice((int)x+250,(int)y+40,(int)(random(0,90)),random(.5,1.5)); //initializing die in assigned location
     die[i+1] = new Dice((int)y+250,(int)x+40,(int)(random(0,90)),random(.5,1.5));
         die[i+2] = new Dice((int)x+250,(int)(300-y+300)+40,(int)(random(0,90)),random(.5,1.5));
     die[i+3] = new Dice((int)(300-y+300)+250,(int)x+40,(int)(random(0,90)),random(.5,1.5));

    }
    i+=4;
  }
  
}
for(int q = 0; q<11; q++){
  pileheight[q]=0; //setting inital pileheight to 0
}
  
  size(1100,700);
  
}

void keyPressed(){
  for(int i=0; i<60; i++){ //if key pressed, launch all die into sky
    die[i].launch();
  }
  for(int q = 0; q<11; q++){
  pileheight[q]=0; //reset pileheight when die are launched
}
}

void draw(){
  background(300,300,300);
  avgg = 0;
  avgheight = 0;
  count = 0; //reset sum of all die values
  for(int i = 0; i<60; i++){
  die[i].roll();
  die[i].show();
  }



textSize(20);
text(avgheight/60 + ",  " + avgg/60,100,100);
text("Sum of all die is " + count,880,30); //display score in top right

}
