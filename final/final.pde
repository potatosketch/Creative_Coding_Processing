import processing.sound.*;

PImage img;
PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;

SoundFile song;
SoundFile song01;
SoundFile bg;
SoundFile ding;
SoundFile GO;
SoundFile ht;

float lift=550;

float mx=mouseX;
float my=mouseY;
int rects =30;

float ex=random(0,width);
float ey=random(70,height);
float lastX;
float lastY;

float hx=random(0,width);
float hy=random(70,height);
int add=70;

int score;

float time;
float maxtime=120;

int fd = 6;
int refd = 6;
int leftfd = 6;
int rifd = 6;

Circle[] circles = new Circle[fd];
reCircle[] recircles = new reCircle[refd];
leftCircle[] leftcircles = new leftCircle[leftfd];
riCircle[] ricircles = new riCircle[rifd];

void setup() {
  size(600, 400);
  background(0);
  smooth();
  img = loadImage("ufo.png");
  img1 = loadImage("star.png");
  img2 = loadImage("game.png");
  img3 = loadImage("ufomouse.png");
  img4 = loadImage("heart.png");
  img5 =loadImage("s.png");
  
  song = new SoundFile(this,"error.mp3");
  song01 = new SoundFile(this,"error01.mp3");
  song.amp(0.1);
  song01.amp(0.1);
  bg = new SoundFile(this,"bgm.mp3");
  bg.loop();
  bg.amp(0.3);
  ding = new SoundFile(this,"ding.mp3"); 
  ding.amp(0.2);
  GO = new SoundFile(this,"GO.mp3");
  GO.amp(0.3);
  ht = new SoundFile(this,"ht.mp3");
  ht.amp(0.3);
     
  for (int z=0; z<fd; z++) {
    circles[z] = new Circle();
 } 
 
  for (int r=0; r<fd; r++) {
    recircles[r] = new reCircle();
 } 
 
  for (int w=0; w<leftfd; w++) {
    leftcircles[w] = new leftCircle();
 }   
 
  for (int t=0; t<rifd; t++) {
    ricircles[t] = new riCircle();
 } 

}

void draw() {
  rectMode(CORNER);
  noStroke();
  fill(0);
  rect(0, 0, width, height);
  
  imageMode(CENTER);
  noStroke();
  fill(0,153,255);
  image(img3,mx,my,rects,rects); 
  
  if(my<70){
   my=70;
  }else{
   mx=mouseX;
   my=mouseY;
  }
 
  noStroke();
  fill(0,255,0);
  ellipse(ex,ey,10,10);

  if(mouseX+rects/2 > ex+10/2 
   &&mouseX-rects/2 < ex+10/2 
   &&mouseY-rects/2 < ey+10/2 
   && mouseY+rects/2 > ey-10/2){
   score=score+1;
   lastX=random(0,width);
   lastY=random(70,height);
   ex=lastX;
   ey=lastY;
   ding.play();
  }

  if(time <= 115){
   image(img4,hx,hy,10,10);
    if(mouseX+rects/2 > hx+10/2 
     &&mouseX-rects/2 < hx+10/2 
     &&mouseY-rects/2 < hy+10/2 
     &&mouseY+rects/2 > hy-10/2){
     ht.play();
     lift=lift+add;
     hx=random(0,width);
     hy=random(70,height);
     add=add-10; 
      if(add<=0){
       hx=0;
       hy=0;
      }
    }
  }

  if(lift>=550){
   lift=550;
  } 
  
  strokeWeight(5);
  stroke(150);

  for (int z=0; z<fd; z++) {
    circles[z].move();
  } 
  
  for (int r=0; r<fd; r++) {
    recircles[r].move1();
  } 
  
  for (int w=0; w<leftfd; w++) {
    leftcircles[w].move2();
  }  
  
  for (int t=0; t<rifd; t++) {
    ricircles[t].move3();
  }
  
  rectMode(CORNER);
  fill(255);
  noStroke();
  rect(40,380,550,10);
  fill(255,0,0);
  noStroke();
  rect(40,380,lift,10);
  fill(255);
  noStroke();
  rect(0,0,width,70);
  imageMode(CORNER);
  image(img,300,10,50,25);
  image(img1,240,0,80,70);
  image(img2,280,42,60,20);

  textAlign(CENTER, CENTER); 
  fill(0);
  textSize(15);
  text("SCORE:"+score,50,35);
  time=maxtime-millis()/1000%121;
  text("Time:"+time+"/120s",520,35);
  fill(255,0,0);
  text("Life",20,380);

  if(lift<=0||time<=0.0){
   lift=0;
   time=0;
   ex=-999;
   ey=-999;
   bg.stop();
   // GO.play();
   fill(255,255,0);
   textSize(50);
   text("GAMEOVER",width/2,height/2);
   text("Your Score:"+score,width/2,240);
   }
  }

  class Circle {
   float num,ynum, movey,c,nsnum1,nsnum2,moveme,crsize,move;
    Circle() {
    num = 0;
    ynum=0;
    movey = random(0,height);
    c=random(0,width);
    nsnum1=random(0.01,0.1);
    nsnum2=random(0.01,0.1);
    moveme=random(50,150);
    crsize=random(10,30);
    move=random(1,3); 
  }
  
  void move() {
   fill(200);
   ellipse(c + noise(num,ynum) * moveme, movey,crsize,crsize);
   movey=movey+move;
   if(movey >height){
    movey=0;  
   }
   num=num+nsnum1;
   ynum=ynum+nsnum2;
   
   if(mouseX+rects/2>c + noise(num,ynum) * moveme-crsize/2 
    &&mouseX-rects/2<c + noise(num,ynum) * moveme+crsize/2 
    &&mouseY-rects/2< movey+crsize/2
    &&mouseY+rects/2>movey-crsize/2) {
    //song.play();
    lift=lift-1;
   }
  } 
  }  
  
  class reCircle {
   float renum,reynum, removey,rec,rensnum1,rensnum2,removeme,recrsize,re_move;
    reCircle() {
    renum = 0;
    reynum=0;
    removey = random(0,height);
    rec=random(0,width);
    rensnum1=random(0.01,0.1);
    rensnum2=random(0.01,0.1);
    removeme=random(50,150);
    recrsize= random(10,30);
    re_move=random(1,3);
  }
  
  void move1() {
   fill(180);
   ellipse(rec + noise(renum,reynum) * removeme, removey, recrsize, recrsize);
   removey=removey-re_move;
   if(removey < 0){
    removey=height;  
   }
   renum=renum+rensnum1;
   reynum=reynum+rensnum2;
   
   if(mouseX+rects/2>rec + noise(renum,reynum) * removeme-recrsize/2 
    &&mouseX-rects/2<rec + noise(renum,reynum) * removeme+recrsize/2 
    &&mouseY-rects/2< removey+recrsize/2 
    &&mouseY+rects/2>removey-recrsize/2) {
    lift=lift-1; 
   }    
  }
  }  

  class leftCircle {
   float leftnum,leftynum, leftmovey,leftrec,leftnsnum1,leftnsnum2,leftmoveme,leftsize,left_move;
    leftCircle() {
    leftnum = 0;
    leftynum=0;
    leftmovey = random(0,height);
    leftrec=random(0,width);
    leftnsnum1=random(0.01,0.1);
    leftnsnum2=random(0.01,0.1);
    leftmoveme=random(50,150);
    leftsize= random(10,30);
    left_move=random(1,3);
  }
  
  void move2() {
   stroke(77,40,0);
   fill(102,51,0);
   ellipse(leftrec , leftmovey+ noise(leftnum) * leftmoveme, leftsize, leftsize);
   leftrec=leftrec+left_move;
   if(leftrec > width){
       leftrec=0;  
   }
   leftnum=leftnum+leftnsnum1;
   leftynum=leftynum+leftnsnum2;
   
   if(mouseX+rects/2>leftrec-leftsize/2 
    &&mouseX-rects/2<leftrec+leftsize/2 
    &&mouseY-rects/2<leftmovey+ noise(leftnum) * leftmoveme +leftsize/2 
    &&mouseY+rects/2>leftmovey+ noise(leftnum) * leftmoveme-leftsize/2) {
    //song01.play();
    lift=lift-1;
   }     
  }
  }   


  class riCircle {
   float renum,reynum, removey,rec,rensnum1,rensnum2,removeme,recrsize,re_move;
    riCircle() {
    renum = 0;
    reynum=0;
    removey = random(0,height);
    rec=random(0,width);
    rensnum1=random(0.01,0.1);
    rensnum2=random(0.01,0.1);
    removeme=random(50,150);
    recrsize= random(10,30);
    re_move=random(1,3);
  }
  
  void move3() {
   stroke(77,40,0);
   fill(128,64,0);
   ellipse(rec , removey+ noise(renum,reynum) * removeme, recrsize, recrsize);
   rec=rec-re_move;
   if(rec < 0){
    rec=width;  
   }
   renum=renum+rensnum1;
   reynum=reynum+rensnum2;
   
   if(mouseX+rects/2>rec-recrsize/2 
    &&mouseX-rects/2<rec+recrsize/2 
    &&mouseY-rects/2<removey+ noise(renum,reynum) * removeme +recrsize/2 
    &&mouseY+rects/2>removey+ noise(renum,reynum) * removeme-recrsize/2) {
    lift=lift-1;
   }   
  }
  } 