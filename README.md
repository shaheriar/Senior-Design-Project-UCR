# Smart Chessboard

## Table of Contents
- [Overview](#overview)
- [Usage](#usage)
- [How To Build](#how-to-build-and-run-from-source)
- [How To Run](#how-to-run)
- [Diagrams](#diagrams)
- [Dependencies](#dependencies)

## Overview
For our project we would like to use a mix of AI and embedded systems. A brief summary of our idea is a smart chessboard (physical) that highlights your possible moves using LEDs, allows you to receive an AI recommended computer move (the most optimal move for that turn), flashes red when making an illegal move, and allows you to play against AI of various difficulties. We need to make sure our chess engine is accurate to ensure the user is making the moves they want to make. Speed is also a constraint to ensure the moves do not take long to make.

## Team
<a href="https://github.com/shaheriar" target="_blank"><img src="https://avatars.githubusercontent.com/u/49822364?v=4" align="left" height="30px">Shaheriar Malik</a>

<a href="https://github.com/rgiron1" target="_blank"><img src="https://avatars.githubusercontent.com/u/36999776?v=4" align="left" height="30px">Ryan Giron</a>

<a href="https://github.com/JShweiri" target="_blank"><img src="https://avatars.githubusercontent.com/u/31330210?v=4" align="left" height="30px">Jason Shweiri</a>

<a href="https://github.com/simrajsingh" target="_blank"><img src="https://avatars.githubusercontent.com/u/25336991?v=4" align="left" height="30px">Simraj Singh</a>



## Usage
Demo: https://drive.google.com/file/d/1NUwrpwSUZm6x4F9EefskllHDGrh9GksT/view

<img src="https://i.imgur.com/TZHJjqC.png" /><br>
     
<img src="https://i.imgur.com/MeYpJ8G.png" /><br>
     
<img src="https://i.imgur.com/gdqlrtn.png" /><br>
     
<img src="https://i.imgur.com/xZqYGsR.png" /><br>
     
<img src="https://i.imgur.com/eX58mde.png" /><br>
     
<img src="https://i.imgur.com/MK9v85P.png" /><br>


## How To Build and Run From Source
In the project directory, you can run:

### `cd chessboard`
  
### `flutter build web`
  
This creates a directory called build and inside it is another directory called web

in this folder (chessboard/build/web) run `npm serve`
  
open http://localhost:3000 in Google Chrome 
  
`python server.py`
  
`python servergame.py`

## How To Run
Because the build and run process can be tedious we have made a batch file to automate the commands to make it run

### `start.bat`

This will run both the python scripts as well as npm serve and open Google Chrome.<br />

## Diagrams

<img src="https://i.imgur.com/9VhzXgU.png" /><br>

## Dependencies
### Flutter 2 (only to build from source) <br>
### Python 3 <br>
#### - CairoSVG==2.5.2 <br>
#### - chess==1.7.0 <br>
#### - SimpleWebSocketServer==0.1.1 <br>
#### - websockets==10.1 <br>
### Google Chrome or Microsoft Edge <br>

