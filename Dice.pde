int[]pileheight = new int[11];
int count = 0;


class Dice{
  int myValue, myX, myY, myR, myC;
  float myS, myXV, myYV, myRV, myG;

  Dice(int x,int y, int r, float s){
    myValue = 1;
    myX = x;
    myY = y;
    myR = r;
    myG = 0;
    myS = s;
    myC = 0;
   myXV = random(-3,3);
   myYV = random(-3,3);
   myRV = random(-4,4);

   
  }

  void roll(){
    if(mousePressed==true && mouseX>myX-30 && mouseX<myX+30 &&mouseY>myY-30 && mouseY<myY+30){
    myValue = (int)(Math.random()*6+1);
    myR+=(int)(random(-30,30));
    }
  }
  
  void launch(){
   myXV = random(-10,10);
   myYV = random(-10,-5);
   myRV = random(-4,4);
   myValue= (int)(random(1,7));
   myG=0;
   myC = 0;
  }
  
  void show(){  
    
  float realspin = myR/57.3;
  pushMatrix();
     translate(myX,myY); 
     rotate(realspin);
    fill(300,300,300);
    
    rect(-20*myS,-40*myS,60*myS,60*myS);
    textSize(40*myS);
    fill(0,0,0);
    if(myValue==1||myValue==3 || myValue==5){
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
  popMatrix();
  
  if(myC<7){
  myY+=myYV;
  }
  myYV=constrain(myYV+.05,-500,500);
  
  myX+=myXV;
  if(myX>1100||myX<0){
    myXV=-0.75*myXV;
    myRV = -.9*myRV;
      if(abs(myXV)<.1){
    myXV = 0;
    
  }
  }
  if(myY>700-(pileheight[constrain(myX/100,0,10)]*20)-myS &&myG==0){
    myG=700-(pileheight[constrain(myX/100,0,10)]*20)-myS;
    pileheight[constrain(myX/100,0,10)] += myS;
  }
  if((myY>myG)&&(myG!=0)||(myY<0)&&(myYV<0)){
    myYV=-.5*myYV;
    myRV = -.9*myRV;
    myXV=myXV*.3;
    myC+=1;
  
  if(myC>6){
    myYV = 0;
    myRV=0;
    myXV=0;
  }

  }
  myR+=myRV;
  count+=myValue;
  


  }
}
  


Dice[]die = new Dice[60];

void setup(){
  int i=0;
for(int radius = 300; radius>0; radius-=80){//circles
for(float x = 300-radius; x<300+radius; x+=100){

 float y = sqrt(sq(radius) - sq(x-300))+300;
    if(i<60){
    die[i] = new Dice((int)x+250,(int)y+40,(int)(random(0,90)),random(.5,1.5));
     die[i+1] = new Dice((int)y+250,(int)x+40,(int)(random(0,90)),random(.5,1.5));
         die[i+2] = new Dice((int)x+250,(int)(300-y+300)+40,(int)(random(0,90)),random(.5,1.5));
     die[i+3] = new Dice((int)(300-y+300)+250,(int)x+40,(int)(random(0,90)),random(.5,1.5));

    }
    i+=4;
  }
  
}
for(int q = 0; q<11; q++){
  pileheight[q]=0;
}
  
  size(1100,700);
  
}

void keyPressed(){
  for(int i=0; i<60; i++){
    die[i].launch();
  }
  for(int q = 0; q<11; q++){
  pileheight[q]=0;
}
}

void draw(){
  background(300,300,300);
  count = 0;
  for(int i = 0; i<60; i++){
  die[i].roll();
  die[i].show();
  }

textSize(40);
text(count,1000,50);

}
