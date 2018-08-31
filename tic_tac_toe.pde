////////////////////////////////////////////////////////////////
////////////////  Author: Rowan Emma Switzer    ////////////////
////////////////        @justrowingby           ////////////////
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
////////////////     Game Flow Explanation      ////////////////
////////////////////////////////////////////////////////////////

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
// the last letter that won starts regardless.
// this is indicated in the top right corner.

// the users can play as many rounds and/or games
// as they like before closing the program
// by closing the java applet window

////////////////////////////////////////////////////////////////
////////////////       Global Variables         ////////////////
////////////////////////////////////////////////////////////////

boolean startScreen = true;
// determines whether the start screen should be drawn
boolean playing = false;
// determines whether the playing board should be drawn,
// whether the game should accept clicks as the placement
// of Xs and Os, and whether the game should check for wins and ties
boolean winScreen = false;
// determines whether the win-screen should be drawn
// win-screen is displayed after every round
// win-screen holds score and the ability to play again
boolean tooMuch = false;
// inserted as a joke, if you play with more than 99
// X-wins, O-wins, or ties, individually, the game
// will ask you to stop playing and go outside
int turn = 0;
// is it X's turn, or O's?
// 0 indicates X
// 1 indicates O
int[] stateOfBoard = new int[9];
// stores the current state of the board
// possible values are 0, 1, 2
// a 0 indicates an empty tile
// a 1 indicates an X occupying a tile
// a 2 indicates an O occupying a tile
int[] colors = new int[9];
// stores the state of special color values on the board
// possible values are 0, 1, 2
// a 0 indicates normal play. X gets blue and O gets red
// a 1 is used when a win has occurred. the winning three-in-a-row
// gets a colors[] value of 1 and turns green
// a 2 is used when a tie occurs. every letter on the board
// gets a color[] value of 2 and turns magenta
int xWins = 0;
int yWins = 0;
int ties = 0;
// score values for each condition,
// stored between rounds, but not separate games

////////////////////////////////////////////////////////////////
////////////////    Setup: Opening of Window    ////////////////
////////////////////////////////////////////////////////////////

void setup(){
  size(400, 400);
  // defines size of java applet window to be 400x400 pixels
  // in theory, this value can be adjusted, and the drawings will adjust
  // but this has not been extensively tested
  background(185);
  // background color is gray. it can be anything you like
  textAlign(LEFT);
  // don't change this.
  fill(0);
  textSize(sqrt(height*width)/3.125);
  // text size is defined based on the size of the window
  // in an attempt to accomodate possible variance of window size
  for(int krj = 0; krj < 9; krj++){
    stateOfBoard[krj] = 0;
    colors[krj] = 0;
  }
  // the board is initialized
  // with the state of each tile starting as empty (0)
  // and the state of each tile's special colors being regular play (0)
}

////////////////////////////////////////////////////////////////
////////////////           Draw Loop            ////////////////
////////////////////////////////////////////////////////////////

void draw(){

  if(tooMuch){
    background(185);
    textAlign(CENTER);
    textSize(sqrt(height*width)/27);
    fill(0);
    text("You've been playing a long time. Maybe go outside?", width/2, height/2);
  }
  else{
    if(winScreen ){
      delay(1000);
      fill(190);
      strokeWeight(sqrt(height*width)/80);
      rect(width*6/24, height*10.25/24, width*12/24, height*3.5/24, sqrt(height*width)/100);
      rect(width*6/24, height*14.5/24, width*12/24, height*3.5/24, sqrt(height*width)/100);

      rect(width*6/24, height*6/24, width*3/24, height*3.5/24, sqrt(height*width)/100);
      rect(width*10.5/24, height*6/24, width*3/24, height*3.5/24, sqrt(height*width)/100);
      rect(width*15/24, height*6/24, width*3/24, height*3.5/24, sqrt(height*width)/100);
      fill(0);
      textAlign(CENTER);
      textSize(sqrt(height*width)/13.5);
      text("NEW ROUND", width/2, height*12.70/24);
      text("NEW GAME", width/2, height*17/24);
      fill(0, 0, 200);
      text(xWins, width*7.5/24, height*8.4/24);
      fill(200, 0, 200);
      text(ties, width/2, height*8.4/24);
      fill(200, 0, 0);
      text(yWins, width*16.5/24, height*8.4/24);
      textAlign(LEFT);
      textSize(sqrt(height*width)/3.125);
    }

    if(playing){
        if((stateOfBoard[0]==1 && stateOfBoard[1]==1 && stateOfBoard[2]==1) ||
            (stateOfBoard[3]==1 && stateOfBoard[4]==1 && stateOfBoard[5]==1) ||
            (stateOfBoard[6]==1 && stateOfBoard[7]==1 && stateOfBoard[8]==1) ||
            (stateOfBoard[0]==1 && stateOfBoard[3]==1 && stateOfBoard[6]==1) ||
            (stateOfBoard[1]==1 && stateOfBoard[4]==1 && stateOfBoard[7]==1) ||
            (stateOfBoard[2]==1 && stateOfBoard[5]==1 && stateOfBoard[8]==1) ||
            (stateOfBoard[0]==1 && stateOfBoard[4]==1 && stateOfBoard[8]==1) ||
            (stateOfBoard[2]==1 && stateOfBoard[4]==1 && stateOfBoard[6]==1)
          ){
            if((stateOfBoard[0]==1 && stateOfBoard[1]==1 && stateOfBoard[2]==1)){ colors[0]=1; colors[1]=1; colors[2]=1;}
            if((stateOfBoard[3]==1 && stateOfBoard[4]==1 && stateOfBoard[5]==1)){ colors[3]=1; colors[4]=1; colors[5]=1;}
            if((stateOfBoard[6]==1 && stateOfBoard[7]==1 && stateOfBoard[8]==1)){ colors[6]=1; colors[7]=1; colors[8]=1;}
            if((stateOfBoard[0]==1 && stateOfBoard[3]==1 && stateOfBoard[6]==1)){ colors[0]=1; colors[3]=1; colors[6]=1;}
            if((stateOfBoard[1]==1 && stateOfBoard[4]==1 && stateOfBoard[7]==1)){ colors[1]=1; colors[4]=1; colors[7]=1;}
            if((stateOfBoard[2]==1 && stateOfBoard[5]==1 && stateOfBoard[8]==1)){ colors[2]=1; colors[5]=1; colors[8]=1;}
            if((stateOfBoard[0]==1 && stateOfBoard[4]==1 && stateOfBoard[8]==1)){ colors[0]=1; colors[4]=1; colors[8]=1;}
            if((stateOfBoard[2]==1 && stateOfBoard[4]==1 && stateOfBoard[6]==1)){ colors[2]=1; colors[4]=1; colors[6]=1;}
            xWins++;
            playing = false;
            winScreen = true;
        }
        if((stateOfBoard[0]==2 && stateOfBoard[1]==2 && stateOfBoard[2]==2) ||
            (stateOfBoard[3]==2 && stateOfBoard[4]==2 && stateOfBoard[5]==2) ||
            (stateOfBoard[6]==2 && stateOfBoard[7]==2 && stateOfBoard[8]==2) ||
            (stateOfBoard[0]==2 && stateOfBoard[3]==2 && stateOfBoard[6]==2) ||
            (stateOfBoard[1]==2 && stateOfBoard[4]==2 && stateOfBoard[7]==2) ||
            (stateOfBoard[2]==2 && stateOfBoard[5]==2 && stateOfBoard[8]==2) ||
            (stateOfBoard[0]==2 && stateOfBoard[4]==2 && stateOfBoard[8]==2) ||
            (stateOfBoard[2]==2 && stateOfBoard[4]==2 && stateOfBoard[6]==2)
          ){
            if((stateOfBoard[0]==2 && stateOfBoard[1]==2 && stateOfBoard[2]==2)){ colors[0]=1; colors[1]=1; colors[2]=1;}
            if((stateOfBoard[3]==2 && stateOfBoard[4]==2 && stateOfBoard[5]==2)){ colors[3]=1; colors[4]=1; colors[5]=1;}
            if((stateOfBoard[6]==2 && stateOfBoard[7]==2 && stateOfBoard[8]==2)){ colors[6]=1; colors[7]=1; colors[8]=1;}
            if((stateOfBoard[0]==2 && stateOfBoard[3]==2 && stateOfBoard[6]==2)){ colors[0]=1; colors[3]=1; colors[6]=1;}
            if((stateOfBoard[1]==2 && stateOfBoard[4]==2 && stateOfBoard[7]==2)){ colors[1]=1; colors[4]=1; colors[7]=1;}
            if((stateOfBoard[2]==2 && stateOfBoard[5]==2 && stateOfBoard[8]==2)){ colors[2]=1; colors[5]=1; colors[8]=1;}
            if((stateOfBoard[0]==2 && stateOfBoard[4]==2 && stateOfBoard[8]==2)){ colors[0]=1; colors[4]=1; colors[8]=1;}
            if((stateOfBoard[2]==2 && stateOfBoard[4]==2 && stateOfBoard[6]==2)){ colors[2]=1; colors[4]=1; colors[6]=1;}
          yWins++;
          playing = false;
          winScreen = true;
        }

      if( (!(stateOfBoard[0]==0)) && (!(stateOfBoard[1]==0)) && (!(stateOfBoard[2]==0)) && (!(stateOfBoard[3]==0)) && (!(stateOfBoard[4]==0)) && (!(stateOfBoard[5]==0)) && (!(stateOfBoard[6]==0)) && (!(stateOfBoard[7]==0)) && (!(stateOfBoard[8]==0))
          && (!((stateOfBoard[0]==1 && stateOfBoard[1]==1 && stateOfBoard[2]==1) ||
            (stateOfBoard[3]==1 && stateOfBoard[4]==1 && stateOfBoard[5]==1) ||
            (stateOfBoard[6]==1 && stateOfBoard[7]==1 && stateOfBoard[8]==1) ||
            (stateOfBoard[0]==1 && stateOfBoard[3]==1 && stateOfBoard[6]==1) ||
            (stateOfBoard[1]==1 && stateOfBoard[4]==1 && stateOfBoard[7]==1) ||
            (stateOfBoard[2]==1 && stateOfBoard[5]==1 && stateOfBoard[8]==1) ||
            (stateOfBoard[0]==1 && stateOfBoard[4]==1 && stateOfBoard[8]==1) ||
            (stateOfBoard[2]==1 && stateOfBoard[4]==1 && stateOfBoard[6]==1)))
          && (!((stateOfBoard[0]==2 && stateOfBoard[1]==2 && stateOfBoard[2]==2) ||
            (stateOfBoard[3]==2 && stateOfBoard[4]==2 && stateOfBoard[5]==2) ||
            (stateOfBoard[6]==2 && stateOfBoard[7]==2 && stateOfBoard[8]==2) ||
            (stateOfBoard[0]==2 && stateOfBoard[3]==2 && stateOfBoard[6]==2) ||
            (stateOfBoard[1]==2 && stateOfBoard[4]==2 && stateOfBoard[7]==2) ||
            (stateOfBoard[2]==2 && stateOfBoard[5]==2 && stateOfBoard[8]==2) ||
            (stateOfBoard[0]==2 && stateOfBoard[4]==2 && stateOfBoard[8]==2) ||
            (stateOfBoard[2]==2 && stateOfBoard[4]==2 && stateOfBoard[6]==2)))
      ){
        for(int krj = 0; krj < 9; krj++){
          colors[krj] = 2;
        }
        ties++;
        playing = false;
        winScreen = true;
      }
      background(185);
      textAlign(LEFT);
      textSize(sqrt(height*width)/3.125);
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
      textSize(sqrt(height*width)/3.125);

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

        if(stateOfBoard[i] == 1){
          if(colors[i] == 1){
            fill(0, 200, 0);
            text("X", xMin + width/16.5, yMax - height/27*1.5);

          }
          if(colors[i] == 2){
            fill(200, 0, 200);
            text("X", xMin + width/16.5, yMax - height/27*1.5);
          }
          if(colors[i] == 0){
            fill(0, 0, 200);
            text("X", xMin + width/16.5, yMax - height/27*1.5);
          }

        }
        if(stateOfBoard[i] == 2){
          if(colors[i] == 1){
            fill(0, 200, 0);
          }
          if(colors[i] == 2){
            fill(200, 0, 200);
          }
          if(colors[i] == 0){
            fill(200, 0, 0);
          }
          text("O", xMin + width/27, yMax - height/27*1.5);
        }
      }
    }

    if(startScreen){
      fill(190);
      strokeWeight(sqrt(height*width)/80);
      rect(width*6/24, height*10.25/24, width*12/24, height*3.5/24, sqrt(height*width)/100);
      fill(0);
      textAlign(CENTER);
      textSize(sqrt(height*width)/13.5);
      text("NEW GAME", width/2, height*12.70/24);
      textAlign(LEFT);
      textSize(sqrt(height*width)/3.125);
    }
  }
  if(xWins > 99 || yWins > 99 || ties > 99){
    tooMuch = true;
    redraw();
  }
}

void mousePressed(){
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
          if(stateOfBoard[i]==0){
            if(turn==0){
              stateOfBoard[i] = 1;
              turn = 1;
            } else{
              if(turn==1){
                stateOfBoard[i] = 2;
                turn = 0;
              }
            }
          }
        }
      }
    }
  }

  if(startScreen){
    if (mouseX>width*6/24 && mouseX<width*18/24 && mouseY>height*10.25/24 && mouseY<height*13.75/24){
      startScreen = false;
      playing = true;
      redraw();
    }
  }

  if(winScreen){
    if (mouseX>width*6/24 && mouseX<width*18/24 && mouseY>height*14.5/24 && mouseY<height*18/24){
      if(turn==0){
            turn = 1;
      } else{
        if(turn==1){
          turn = 0;
        }
      }
      for(int krj = 0; krj < 9; krj++){
        stateOfBoard[krj] = 0;
        colors[krj] = 0;
      }
      xWins = 0;
      yWins = 0;
      ties = 0;
      winScreen = false;
      playing = true;
      startScreen = false;
      redraw();
    }
    if(mouseX>width*6/24 && mouseX<width*18/24 && mouseY>height*10.25/24 && mouseY<height*13.75/24){
      if(turn==0){
            turn = 1;
      } else{
        if(turn==1){
          turn = 0;
        }
      }
      for(int krj = 0; krj < 9; krj++){
        stateOfBoard[krj] = 0;
        colors[krj] = 0;
      }
      winScreen = false;
      playing = true;
      startScreen = false;
      redraw();
    }
  }
  redraw();
}
