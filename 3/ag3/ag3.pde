float y = 0; 
int fd = 6;
int refd = 6;
int leafnum = 8;

Circle[] circles = new Circle[fd];
reCircle[] recircles = new reCircle[refd];
leCircle[] lecircles = new leCircle[leafnum];

void setup() {
  size(600, 400);
  background(130);
  smooth();
  
  for (int z=0; z<fd; z++) {
    circles[z] = new Circle();
 } 
 
  for (int r=0; r<fd; r++) {
    recircles[r] = new reCircle();
 } 
 
  for (int r=0; r<leafnum; r++) {
    lecircles[r] = new leCircle();
 }  

}

void draw() {
  noStroke();
  fill(0,204,204,50);
  rect(0, 0, width, height);
  strokeWeight(0);
  stroke(210,253,255,50); 
  
float x = 0; 
  for (int i = 0; i < height; i++) {
    line(0,i,3 + noise(x, y) * 200 ,i);
    line(70 + noise(x, y) * 200,i,80 + noise(x, y) * 200 ,i);
    line(100 + noise(x, y) * 200,i,150 + noise(x, y) * 200 ,i);
    line(230 + noise(x, y) * 200, i, 255 + noise(x, y) * 200, i);
    line(290 + noise(x, y) * 200, i, 340 + noise(x, y) * 200, i);
    line(450 + noise(x, y) * 200, i, 600 + noise(x, y) * 200, i);
    x += 0.01;
  }
  
  stroke(206,233,255,50); 
  
  for (int i = 0; i < width; i++) {
    line(i,10 + noise(x, y) * 200 ,i,30 + noise(x, y) * 200);
    line(i,135 + noise(x, y) * 200 ,i,140 + noise(x, y) * 200);
    line(i,150 + noise(x, y) * 200 ,i,200 + noise(x, y) * 200);
    x += 0.01;
  }
  
   y += 0.003;
  
  strokeWeight(5);
  stroke(0,50);

  for (int z=0; z<fd; z++) {
    circles[z].move();
  } 
  
  for (int r=0; r<fd; r++) {
    recircles[r].move1();
  } 
  
  for (int r=0; r<leafnum; r++) {
    lecircles[r].display();
  }   
  
}

  class Circle {
   float num,ynum, movey, lastX, lastY,c,nsnum1,nsnum2,moveme;
    Circle() {
    num = 0;
    ynum=0;
    movey = random(0,height);
    c=random(0,width);
    nsnum1=random(0.01,0.03);
    nsnum2=random(0.0001,0.0003);
    moveme=random(50,150);
  }
  
  void move() {
   point(c + noise(num,ynum) * moveme, movey);
   movey=movey+1;
   if(movey >height){
       movey=0;  
   }
   num=num+nsnum1;
   ynum=ynum+nsnum2;
  } 
}  
  
  class reCircle {
   float renum,reynum, removey, relastX, relastY,rec,rensnum1,rensnum2,removeme;
    reCircle() {
    renum = 0;
    reynum=0;
    removey = random(0,height);
    rec=random(0,width);
    rensnum1=random(0.01,0.03);
    rensnum2=random(0.0001,0.0003);
    removeme=random(50,150);
  }
  
  void move1() {
   point(rec + noise(renum,reynum) * removeme, removey);
   removey=removey-1;
   if(removey < 0){
       removey=height;  
   }
   renum=renum+rensnum1;
   reynum=reynum+rensnum2;
  }
}  

  class leCircle {
   float x2, y2, radius, centX, centY, tt, ttadd,gnclor;
    leCircle() {
    radius=random(10,55);
    centX=random(0,width);
    centY=random(0,height);
    tt=0;
    ttadd=random(0.0007,0.007);
    gnclor=random(70,150);
  }
  
  void display() {
   strokeWeight(3); 
   float rad = noise(tt) * PI * 4;
   x2 = centX + (radius * cos(rad));
   y2 = centY + (radius * sin(rad)); 
   stroke(0, 102, 0);
   fill(0,gnclor,0);
   ellipse(centX,centY,radius*2,radius*2);
   line(centX, centY, x2, y2); 
   tt += ttadd; 
  }  
}