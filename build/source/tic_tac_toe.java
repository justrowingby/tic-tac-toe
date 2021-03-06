import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class tic_tac_toe extends PApplet {

// game opens on a square, 400x400 pixel java applet window

// game starts on  a start screen with option
// to start a new game

// in the first game, X gets the first move.
// there is an indicator in the upper right hand corner
// which tells whose turn it displayDensity()

// Xs are always blue
// Os are always red

// if the game is won by either side,
// the letters in the winning three-in-a-row
// turn green

// if the game is tied, all letters turn magenta

// regardless of win or tie, the win-screen appears when a game ends
// the win screen displays the score for the current volley of rounds
// X score is on the left in blue, O score is on the right in red
// and number of ties is displayed in a center box in magenta
// the win-screen also displays options for a new round,
// which retains existing scores, or a new game,
// which wipes the existing scores,
// for example, in case a new set of players would like to play

// if a new ROUND is started,
// the winner of the last round gets their turn first

// if a new GAME (set of rounds) is started,
// X gets the first move, as with the very first round

// the users can play as many rounds and/or games
// as they like before closing the program
// by closing the java applet window



boolean startScreen = true;
boolean playing = false;
boolean winScreen = false;
boolean tooMuch = false;
int turn = 0;
int[] S = new int[9];
int[] C = new int[9];
int xWins = 0;
int yWins = 0;
int ties = 0;

public void setup(){
  
  background(185);
  textAlign(LEFT);
  fill(0);
  textSize(sqrt(height*width)/3.125f);
  for(int krj = 0; krj < 9; krj++){
    S[krj] = 0;
    C[krj] = 0;
  }
}

public void draw(){

  if(tooMuch){
    background(185);
    textAlign(CENTER);
    textSize(sqrt(height*width)/27);
    fill(0);
    text("This is really too much. Please go outside.", width/2, height/2);
  }
  else{
    if(winScreen ){
      delay(1000);
      fill(190);
      strokeWeight(sqrt(height*width)/80);
      rect(width*6/24, height*10.25f/24, width*12/24, height*3.5f/24, sqrt(height*width)/100);
      rect(width*6/24, height*14.5f/24, width*12/24, height*3.5f/24, sqrt(height*width)/100);

      rect(width*6/24, height*6/24, width*3/24, height*3.5f/24, sqrt(height*width)/100);
      rect(width*10.5f/24, height*6/24, width*3/24, height*3.5f/24, sqrt(height*width)/100);
      rect(width*15/24, height*6/24, width*3/24, height*3.5f/24, sqrt(height*width)/100);
      fill(0);
      textAlign(CENTER);
      textSize(sqrt(height*width)/13.5f);
      text("NEW ROUND", width/2, height*12.70f/24);
      text("NEW GAME", width/2, height*17/24);
      fill(0, 0, 200);
      text(xWins, width*7.5f/24, height*8.4f/24);
      fill(200, 0, 200);
      text(ties, width/2, height*8.4f/24);
      fill(200, 0, 0);
      text(yWins, width*16.5f/24, height*8.4f/24);
      textAlign(LEFT);
      textSize(sqrt(height*width)/3.125f);
    }

    if(playing){
        if((S[0]==1 && S[1]==1 && S[2]==1) ||
            (S[3]==1 && S[4]==1 && S[5]==1) ||
            (S[6]==1 && S[7]==1 && S[8]==1) ||
            (S[0]==1 && S[3]==1 && S[6]==1) ||
            (S[1]==1 && S[4]==1 && S[7]==1) ||
            (S[2]==1 && S[5]==1 && S[8]==1) ||
            (S[0]==1 && S[4]==1 && S[8]==1) ||
            (S[2]==1 && S[4]==1 && S[6]==1)
          ){
            if((S[0]==1 && S[1]==1 && S[2]==1)){ C[0]=1; C[1]=1; C[2]=1;}
            if((S[3]==1 && S[4]==1 && S[5]==1)){ C[3]=1; C[4]=1; C[5]=1;}
            if((S[6]==1 && S[7]==1 && S[8]==1)){ C[6]=1; C[7]=1; C[8]=1;}
            if((S[0]==1 && S[3]==1 && S[6]==1)){ C[0]=1; C[3]=1; C[6]=1;}
            if((S[1]==1 && S[4]==1 && S[7]==1)){ C[1]=1; C[4]=1; C[7]=1;}
            if((S[2]==1 && S[5]==1 && S[8]==1)){ C[2]=1; C[5]=1; C[8]=1;}
            if((S[0]==1 && S[4]==1 && S[8]==1)){ C[0]=1; C[4]=1; C[8]=1;}
            if((S[2]==1 && S[4]==1 && S[6]==1)){ C[2]=1; C[4]=1; C[6]=1;}
            xWins++;
            playing = false;
            winScreen = true;
        }
        if((S[0]==2 && S[1]==2 && S[2]==2) ||
            (S[3]==2 && S[4]==2 && S[5]==2) ||
            (S[6]==2 && S[7]==2 && S[8]==2) ||
            (S[0]==2 && S[3]==2 && S[6]==2) ||
            (S[1]==2 && S[4]==2 && S[7]==2) ||
            (S[2]==2 && S[5]==2 && S[8]==2) ||
            (S[0]==2 && S[4]==2 && S[8]==2) ||
            (S[2]==2 && S[4]==2 && S[6]==2)
          ){
            if((S[0]==2 && S[1]==2 && S[2]==2)){ C[0]=1; C[1]=1; C[2]=1;}
            if((S[3]==2 && S[4]==2 && S[5]==2)){ C[3]=1; C[4]=1; C[5]=1;}
            if((S[6]==2 && S[7]==2 && S[8]==2)){ C[6]=1; C[7]=1; C[8]=1;}
            if((S[0]==2 && S[3]==2 && S[6]==2)){ C[0]=1; C[3]=1; C[6]=1;}
            if((S[1]==2 && S[4]==2 && S[7]==2)){ C[1]=1; C[4]=1; C[7]=1;}
            if((S[2]==2 && S[5]==2 && S[8]==2)){ C[2]=1; C[5]=1; C[8]=1;}
            if((S[0]==2 && S[4]==2 && S[8]==2)){ C[0]=1; C[4]=1; C[8]=1;}
            if((S[2]==2 && S[4]==2 && S[6]==2)){ C[2]=1; C[4]=1; C[6]=1;}
          yWins++;
          playing = false;
          winScreen = true;
        }

      if( (!(S[0]==0)) && (!(S[1]==0)) && (!(S[2]==0)) && (!(S[3]==0)) && (!(S[4]==0)) && (!(S[5]==0)) && (!(S[6]==0)) && (!(S[7]==0)) && (!(S[8]==0))
          && (!((S[0]==1 && S[1]==1 && S[2]==1) ||
            (S[3]==1 && S[4]==1 && S[5]==1) ||
            (S[6]==1 && S[7]==1 && S[8]==1) ||
            (S[0]==1 && S[3]==1 && S[6]==1) ||
            (S[1]==1 && S[4]==1 && S[7]==1) ||
            (S[2]==1 && S[5]==1 && S[8]==1) ||
            (S[0]==1 && S[4]==1 && S[8]==1) ||
            (S[2]==1 && S[4]==1 && S[6]==1)))
          && (!((S[0]==2 && S[1]==2 && S[2]==2) ||
            (S[3]==2 && S[4]==2 && S[5]==2) ||
            (S[6]==2 && S[7]==2 && S[8]==2) ||
            (S[0]==2 && S[3]==2 && S[6]==2) ||
            (S[1]==2 && S[4]==2 && S[7]==2) ||
            (S[2]==2 && S[5]==2 && S[8]==2) ||
            (S[0]==2 && S[4]==2 && S[8]==2) ||
            (S[2]==2 && S[4]==2 && S[6]==2)))
      ){
        for(int krj = 0; krj < 9; krj++){
          C[krj] = 2;
        }
        ties++;
        playing = false;
        winScreen = true;
      }
      background(185);
      textAlign(LEFT);
      textSize(sqrt(height*width)/3.125f);
      strokeWeight(sqrt(height*width)/40);
      stroke(0);
      fill(0);
      noStroke();
      rect(width/3*1-(sqrt(height*width)/40/2), 0, (sqrt(height*width)/40/2), height);
      rect(width/3*2-(sqrt(height*width)/40/2), 0, (sqrt(height*width)/40/2), height);
      rect(0, height/3*1-(sqrt(height*width)/40/2), width, (sqrt(height*width)/40/2));
      rect(0, height/3*2-(sqrt(height*width)/40/2), width, (sqrt(height*width)/40/2));
      stroke(0);
      textAlign(LEFT);
      textSize(sqrt(height*width)/27);
      if(turn==0){
      text("Turn: X", width*23/27, height*1/24);
      }
      if(turn==1){
      text("Turn: O", width*23/27, height*1/24);
      }
      textSize(sqrt(height*width)/3.125f);

      fill(0);

      for(int i = 0; i < 9; i++){
        float xMin = 0;
        if(i % 3 == 1){
          xMin = width/3;
        }
        if(i % 3 == 2){
          xMin = width/3*2;
        }

        float yMin = 0;
        if(i > 2){
          yMin = width/3;
        }
        if(i > 5){
          yMin = width/3*2;
        }
        float yMax = yMin + width/3;

        if(S[i] == 1){
          if(C[i] == 1){
            fill(0, 200, 0);
            text("X", xMin + width/16.5f, yMax - height/27*1.5f);

          }
          if(C[i] == 2){
            fill(200, 0, 200);
            text("X", xMin + width/16.5f, yMax - height/27*1.5f);
          }
          if(C[i] == 0){
            fill(0, 0, 200);
            text("X", xMin + width/16.5f, yMax - height/27*1.5f);
          }

        }
        if(S[i] == 2){
          if(C[i] == 1){
            fill(0, 200, 0);
          }
          if(C[i] == 2){
            fill(200, 0, 200);
          }
          if(C[i] == 0){
            fill(200, 0, 0);
          }
          text("O", xMin + width/27, yMax - height/27*1.5f);
        }
      }
    }

    if(startScreen){
      fill(190);
      strokeWeight(sqrt(height*width)/80);
      rect(width*6/24, height*10.25f/24, width*12/24, height*3.5f/24, sqrt(height*width)/100);
      fill(0);
      textAlign(CENTER);
      textSize(sqrt(height*width)/13.5f);
      text("NEW GAME", width/2, height*12.70f/24);
      textAlign(LEFT);
      textSize(sqrt(height*width)/3.125f);
    }
  }
  if(xWins > 99 || yWins > 99 || ties > 99){
    tooMuch = true;
    redraw();
  }
}

public void mousePressed(){
  //The following define the clickable bounding boxes for any buttons used.
  //Note that these boundaries should match those drawn in the draw() function.

  if(playing){
    if(!((mouseX > width/3*1-(sqrt(height*width)/40/2) && mouseX < width/3*1+(sqrt(height*width)/40/2)) ||
    (mouseX > width/3*2-(sqrt(height*width)/40/2) && mouseX < width/3*2+(sqrt(height*width)/40/2)) ||
    (mouseY > height/3*1-(sqrt(height*width)/40/2) && mouseY < height/3*1+(sqrt(height*width)/40/2)) ||
    (mouseY > height/3*2-(sqrt(height*width)/40/2) && mouseY < height/3*2+(sqrt(height*width)/40/2)))){
      for(int i = 0; i < 9; i++){
        float xMin = 0;
        if(i % 3 == 1){
          xMin = width/3;
        }
        if(i % 3 == 2){
          xMin = width/3*2;
        }
        float xMax = xMin + width/3;

        float yMin = 0;
        if(i > 2){
          yMin = width/3;
        }
        if(i > 5){
          yMin = width/3*2;
        }
        float yMax = yMin + width/3;

        if (mouseX>xMin && mouseX<xMax && mouseY>yMin && mouseY<yMax){
          if(S[i]==0){
            if(turn==0){
              S[i] = 1;
              turn = 1;
            } else{
              if(turn==1){
                S[i] = 2;
                turn = 0;
              }
            }
          }
        }
      }
    }
  }

  if(startScreen){
    if (mouseX>width*6/24 && mouseX<width*18/24 && mouseY>height*10.25f/24 && mouseY<height*13.75f/24){
      startScreen = false;
      playing = true;
      redraw();
    }
  }

  if(winScreen){
    if (mouseX>width*6/24 && mouseX<width*18/24 && mouseY>height*14.5f/24 && mouseY<height*18/24){
      if(turn==0){
            turn = 1;
      } else{
        if(turn==1){
          turn = 0;
        }
      }
      for(int krj = 0; krj < 9; krj++){
        S[krj] = 0;
        C[krj] = 0;
      }
      xWins = 0;
      yWins = 0;
      ties = 0;
      winScreen = false;
      playing = true;
      startScreen = false;
      redraw();
    }
    if(mouseX>width*6/24 && mouseX<width*18/24 && mouseY>height*10.25f/24 && mouseY<height*13.75f/24){
      if(turn==0){
            turn = 1;
      } else{
        if(turn==1){
          turn = 0;
        }
      }
      for(int krj = 0; krj < 9; krj++){
        S[krj] = 0;
        C[krj] = 0;
      }
      winScreen = false;
      playing = true;
      startScreen = false;
      redraw();
    }
  }
  redraw();
}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "tic_tac_toe" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
