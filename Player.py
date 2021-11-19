import chess
from cairosvg import svg2png
from Points import piecePoints
import Points
from MoveEval import MoveEval
import math


class Player:
    # parameters
    recommendMoves = False

    def __init__(self, recommendMoves):
        self.recommendMoves = recommendMoves

    def Recommend(self, board, depth, turn):
        boardCopy = board
        if depth == 0 or board.board.is_checkmate() or board.is_stalemate():
            Points.heuristic(board)
            endEval = MoveEval("empty", eval)
            return endEval

        if(turn) : 
            maxValue = -math.inf
            moveStr = ""
            for i in board.legal_moves:
                boardCopy = board
                boardCopy.push_san(i.uci())
                value = int(self.minimax(boardCopy, depth - 1, False).evaluation)
                if(value >= maxValue):
                    maxValue = value
                    moveStr = i.uci()
                else: 
                    continue
            moveToMake = MoveEval(moveStr, maxValue)
            return moveToMake
        else:
            minValue = math.inf
            moveStr = ""
            for i in board.legal_moves:
                boardCopy = board
                boardCopy.push_san(i.uci())
                value = int(self.minimax(boardCopy, depth - 1, True).evaluation)
                if(value <= minValue):
                    minValue = value
                    moveStr = i.uci()
                else: 
                    continue
            moveToMake = MoveEval(moveStr, minValue)
            return moveToMake

    def makeMove(self, board, depth, turn):
        if(self.recommendMoves == True):
            print(self.Recommend(board, depth, turn).move)
        while(1):    
            move = input('DESIRED MOVE: ')
            try:
                board.push_san(move)
                return (board)
                # history.append(board.fen())
            except:
                print('INVALID MOVE\n')
            
