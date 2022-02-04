# from gpiozero import *

class Hardware:
    def getSquare():
        # get what piece is on a square
        pass

    def getBoard():
        # get all the pieces on the board
        pass

    def setLED(x,y,color):
        # sets a square to a color
        pass

    def setLEDs(squares, legalMoves, color):    
        # squares is a list of all the squares we want lit up
        # legalMoves is a list of all the legal moves
        # color is the color we want the squares to be
        pass
    
    def compareBoard(prev, curr):
        # returns nothing or a move
        pass

    def getMove():
        # move = None
        # while(move == None):
        #    move = compareBoard(prev, curr)
        # return move
        pass

"""
Square = 'a2'
allAvailableMoves = ['a2a4', …]

//make comparison
//light up corresponding squares
For a in allavailablemoves:
	If first two chars of a == square:
		setLED(
		Light up led of a's last two chars square

getMove() :
Move = nothing
while(move) != nothing){
Move = compareboard(prev, curr)
}
Return move

// how to send piece picked up?

Software side:
Change to make:
makeMove(self, board, depth, turn, historyFile):
	Move = Hardware.getMove()

convertAvailableMoves(listOfMoves):
	listOfMoves -> string of possible moves
"""

    
