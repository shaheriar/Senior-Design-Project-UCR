#!/usr/bin/env python

import RPi.GPIO as GPIO
import time
GPIO.setmode(GPIO.BCM)
# GPIO.setwarnings(False)


################# GET MOVE FUNCTIONS #####################

# The Mapping of binary bits to pin numbers
BIT0PIN = 17
BIT1PIN = 27
BIT2PIN = 22
BIT3PIN = 5
BIT4PIN = 6
BIT5PIN = 26

# setting the correct pins for output
GPIO.setup((BIT0PIN, BIT1PIN, BIT2PIN, BIT3PIN, BIT4PIN, BIT5PIN), GPIO.OUT)

# setting the pin for input
READPIN = 23
GPIO.setup(READPIN, GPIO.IN)

# how long to wait before reading if a piece is present after setting the GPIO
DELAY = 0.001

SHIFTDELAY = 1/100000

# The array that maps the square number(index) to the chess tile (value) eg:"a4"
squareMap = ["a1", "a2", "a3", "a4", "a5", "a6", "a7", "a8", "b1", "b2", "b3", "b4", "b5", "b6", "b7", "b8", "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "d1", "d2", "d3", "d4", "d5", "d6", "d7", "d8", "e1", "e2", "e3", "e4", "e5", "e6", "e7", "e8", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "g1", "g2", "g3", "g4", "g5", "g6", "g7", "g8", "h1", "h2", "h3", "h4", "h5", "h6", "h7", "h8" ]

# Converts select (0-63 int) to 6 bit Binary number
# Sets Corresponding GPIO representing these bits to high/low
def setGPIO(select):
    if(select & 0b000001):
            GPIO.output(BIT0PIN, GPIO.HIGH)
    else:
        GPIO.output(BIT0PIN, GPIO.LOW)

    if(select & 0b000010):
        GPIO.output(BIT1PIN, GPIO.HIGH)
    else:
        GPIO.output(BIT1PIN, GPIO.LOW)
    
    if(select & 0b000100):
        GPIO.output(BIT2PIN, GPIO.HIGH)
    else:
        GPIO.output(BIT2PIN, GPIO.LOW)
    
    if(select & 0b001000):
        GPIO.output(BIT3PIN, GPIO.HIGH)
    else:
        GPIO.output(BIT3PIN, GPIO.LOW)
    
    if(select & 0b010000):
        GPIO.output(BIT4PIN, GPIO.HIGH)
    else:
        GPIO.output(BIT4PIN, GPIO.LOW)
    
    if(select & 0b100000):
        GPIO.output(BIT5PIN, GPIO.HIGH)
    else:
        GPIO.output(BIT5PIN, GPIO.LOW)

# returns whether a piece is present at square number select
def getSquare(select):
    setGPIO(select)
    time.sleep(DELAY)
    return GPIO.input(READPIN)

# returns an array of 64 boolean values representing the entire board state
def getBoard():
    boardState = [0] * 64
    select = 0
    while select < 64:
        piecePresent = getSquare(select)
        boardState[select] = piecePresent
        select+=1
    return boardState

## LIGHTS UP SQUARE GREEN WHEN A PIECE IS PLACED 
# LIGHTS UP RED WHEN REMOVED
# ONLY WORKS WITH 1 SQUARE
# ################# GET MOVE EXAMPLE #####################

# handles captures and illegal 


# get optional second move as starting position 
def get_move(legal_moves, recMove, inCheck):
    try:
        recMoveLEDS = [(recMove[0:2], BLUE), (recMove[-2:], BLUE) ]
        prev = getBoard()
        current = []
        picked_up_piece = ""
        lastMove = ""
        while(True):
            current = getBoard()

            for i in range(64):

                # if something changed 
                if current[i] != prev[i]:

                    # a piece was picked up at i
                    if current[i] == 0:

                        #find legal moves starting at square i
                        picked_up_piece = squareMap[i]
                        legal_moves_arr = compare_pieces(legal_moves, picked_up_piece)

                        if len(legal_moves_arr) == 0:
                            picked_up_piece = lastMove[0:2]

                        legal_moves_arr = compare_pieces(legal_moves, picked_up_piece)


                        print(legal_moves_arr)
                        setLEDS(legal_moves_arr) #highlight legal moves green

                    #piece was placed at i
                    if current[i] == 1 and picked_up_piece != "":

                    # if piece was placed back down turn everything off
                        if picked_up_piece == squareMap[i]:
                            picked_up_piece = ""
                            setLEDS(recMoveLEDS)

                    # if a move is made from 1 square to another
                        else:
                            moveMade = picked_up_piece + squareMap[i]
                            lastMove = moveMade
                            # print(picked_up_piece + squareMap[i])
                            if moveMade in legal_moves:
                                setLEDS(recMoveLEDS)
                                return picked_up_piece + squareMap[i]
                            else:
                                setLEDS([(picked_up_piece, RED), (squareMap[i], RED)])
            prev = current
    except:
        pass
    GPIO.cleanup()

def compare_pieces(legal_moves, given_piece):
    #return arr of legal moves for given piece
    final_arr = []
    for move in legal_moves:
        if move[:2] == given_piece:
            final_arr.append((move[-2:], GREEN)) #available moves
    return final_arr

################# SHIFT REGISTER FUNCTIONS #####################

#define PINs according to cabling
dataPIN = 2
latchPIN = 3
clockPIN = 4

GPIO.setup((dataPIN,latchPIN,clockPIN),GPIO.OUT)

# LED order
RED = 0
GREEN = 1
BLUE = 2

# converts from this: [('a1', RED), ('h6', BLUE), ('h8', BLUE)]
# to this: [1, ... 1, 0, 0, 0, 0, 0, 1]
# used by setLEDS
def convertToBinary(LEDs, size):
  ret = [0] * size
  for led in LEDs:
    ret[3*int( squareMap.index(led[0]) ) + led[1]] = 1
  return ret

# ALL LEDS WILL BE SAME COLOR
# converts from this: ['a1', 'h6', 'h8'], BLUE
# to this: [0, 0, 1, ... 1, 0, 0, 0, 0, 0, 1]
def convertToBinary2(LEDs, color, size):
  ret = [0] * size
  for led in LEDs:
    ret[3*int(squareMap.index(led)) + color] = 1
  return ret

#turns the array of LEDs on 
def setLEDS(LEDs, size=192):

  LEDs = convertToBinary(LEDs, size)

  #put latch down to start data sending
  GPIO.output(clockPIN,0)
  time.sleep(SHIFTDELAY)
  GPIO.output(latchPIN,0)
  time.sleep(SHIFTDELAY)
  GPIO.output(clockPIN,1)
  time.sleep(SHIFTDELAY)
  
  #load data in reverse order
  for i in range(size-1, -1, -1):
    GPIO.output(clockPIN,0)
    time.sleep(SHIFTDELAY)
    GPIO.output(dataPIN, LEDs[i])
    time.sleep(SHIFTDELAY)
    GPIO.output(clockPIN,1)
    time.sleep(SHIFTDELAY)

  
  #put latch up to store data on register
  GPIO.output(clockPIN,0)
  time.sleep(SHIFTDELAY)
  GPIO.output(latchPIN,1)
  time.sleep(SHIFTDELAY)
  GPIO.output(clockPIN,1)
  time.sleep(SHIFTDELAY)
