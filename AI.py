from MoveEval import MoveEval
import chess
import Player
import Points
import sys


class AI(Player):
    difficulty = 0

    def __init__(self, recommendMoves, difficulty):
        super().__init__( recommendMoves)
        self.difficulty = difficulty

    def minimax(self, board, depth, turn):
        boardCopy = board
        if depth == 0 or board.board.is_checkmate() or board.is_stalemate():
            Points.heuristic(board)
            endEval = MoveEval("empty", eval)
            return endEval

        if(turn) : 
            maxValue = -sys.maxint - 1
            moveStr = ""
            for i in board.legal_moves:
                boardCopy = board
                boardCopy = boardCopy.push_san(i.uci())
                value = self.minimax(boardCopy, depth - 1, False).evaluation
                if(value >= maxValue):
                    maxValue = value
                    moveStr = i.uci()
                else: 
                    continue
            moveToMake = MoveEval(moveStr, maxValue)
            return moveToMake
        else:
            minValue = sys.maxint
            moveStr = ""
            for i in board.legal_moves:
                boardCopy = board
                boardCopy = boardCopy.push_san(i.uci())
                value = self.minimax(boardCopy, depth - 1, True).evaluation
                if(value <= minValue):
                    minValue = value
                    moveStr = i.uci()
                else: 
                    continue
            moveToMake = MoveEval(moveStr, minValue)
            return moveToMake
            

    def makeMove(self, board, depth, turn):
        tuple = self.minimax(board, depth, turn)


    
        # Minimax algo
