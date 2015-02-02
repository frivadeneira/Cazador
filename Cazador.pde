import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer metralleta;

PFont Arial;
PImage raton,apuntador,fondo;
int reloj,puntaje,enJuego,matar,presionado=0;
int ancho=800;
int alto=600;
int tiempoPausa=40;
int tamanoRatonX=98;
int tamanoRatonY=52;
float posicionX=random(0,702);
float posicionY=random(0,548);
int vidas=4;

void setup(){
  size(ancho,alto);
  minim = new Minim(this);
  metralleta = minim.loadFile("metralleta.mp3");
  Arial = createFont("Arial Bold", 20);
  apuntador = loadImage("apuntador.png");
  raton = loadImage("raton.png");
  fondo = loadImage("pasto.jpg");
}

void draw(){
  background(30);
  frameRate(30);
  textFont(Arial);
  if (enJuego==0){
    inicio();
  }else if (enJuego==1){
    juego();
  }else if (enJuego==2){
    finJuego();
  }
}

void inicio(){
  cursor();
  background(53,147,200);
  textSize(20);
  text("Juego del Cazador",width/2-90,height/2-60);
  text("Diseñado por Daniel Rivadeneira",width/2-160,height/2-30);
  if (reloj<=tiempoPausa){
    text("Haga clic para empezar",width/2-120,height/2+100);
    reloj=reloj+2;
  }else if (reloj<=tiempoPausa*2){
    reloj=reloj+2;
  }else{
    reloj=0;
  }
  if (mousePressed==true){
    enJuego=1;
  }
}

void juego(){
  image(fondo,0,0,width,height);
  fill(255);
  text("Puntaje: "+puntaje,10,20);
  text("Vidas: "+vidas,10,50);
  if (reloj<=tiempoPausa){
    image(raton,posicionX,posicionY);
    reloj=reloj+1;
    if (mousePressed==true){
      metralleta.play();
      if ((mouseX>=posicionX) && (mouseX<=posicionX+tamanoRatonX) && (mouseY>=posicionY) && (mouseY<=posicionY+tamanoRatonY)){
        puntaje=puntaje+1;
        if (matar == 0) {
          raton = loadImage("raton.png");
          matar = matar + 1;
        }else{
          raton = loadImage("ratonmuerto.png");
          matar =0;
        }
      }else{
        vidas=vidas-1;
        if (vidas==0){
          enJuego=2;
        }
      }
    }
  }else if (reloj<=tiempoPausa*2){
    reloj=reloj+1;
  }else{
    posicionX=random(ancho);
    posicionY=random(alto);
    reloj=0;
  }
  noCursor();
  image(apuntador,mouseX -41,mouseY - 41);
}

void mouseReleased(){
  raton = loadImage("raton.png");
  metralleta.pause();
}

void finJuego(){
  background(255,0,0);
  textSize(50);
  fill(255);
  if (reloj<=tiempoPausa*2){
    text("Fin del juego",width/2-160,height/2+30);
    reloj=reloj+1;
  }else{
    enJuego=0;
    puntaje=0;
    vidas=4;
  }
}
