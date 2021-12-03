from gpiozero import *

def chipSelect(pos):
    # sends a binary value to be decoded into a single wire high. ie 011 => 00001000
    pass

def readData(pos):
    chipSelect(pos)
    # read data from the board
    pass

def compareStates(prevBoard, currentBoard):
    prevBoard = currentBoard
    currentBoard = getBoard()
    for i in range(0, 64):
        if prevBoard[i] != currentBoard[i]:
            return (i, prevBoard[i], currentBoard[i])
    pass

def getBoard():
    board = []
    for i in range(0, 64):
        board.append(readData(i))
    return board

def lightLED(pos, color):
    pass