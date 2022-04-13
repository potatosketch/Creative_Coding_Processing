/* @pjs preload="data/rainbow.jpg"; */

PImage img;
int movedup;
int movedbot;
int leng;
int leng1;

void setup(){
img = loadImage("data/rainbow.jpg");
size(600,600);
noStroke();
background(0);
image(img,0,0,300,300);
}

void draw(){

 float d = dist(0,150,mouseX,150);
 movedup = int(map(d,0,width,100,0));
 movedbot = int(map(d,0,width,0,100));
 leng =int(map(d,0,width,5,0));
 leng1 =int(map(d,0,width,0,5));
 for(int x = 0; x<width/2;x++){
 for(int y = 0; y<height/2; y++){

   color c = img.get(x,y);
   int topx = x - int(random(-movedup/2,movedup/2));
   int topy = y - int(random(-movedup,movedup));

   int botx = x - int(random(-movedbot/2,movedbot/2));
   int boty = y - int(random(-movedbot,movedbot));

   int toprx = constrain(topx,0,300);
   int topry = constrain(topy,0,150);
   int botrx = constrain(botx,0,300);
   int botry = constrain(boty,150,300);

   fill(c);
   rect(toprx,topry,leng,leng);
   rect(botrx,botry,leng1,leng1);

 }
 }

}
