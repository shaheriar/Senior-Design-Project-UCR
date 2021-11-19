from MoveEval import MoveEval
import chess
from Player import Player
import Points
import random
import math
import copy


class AI(Player):
    difficulty = 0

    def __init__(self, recommendMoves, difficulty):
        super().__init__( recommendMoves)
        self.difficulty = difficulty
    
    def minimax(self, board, depth, turn, alpha, beta):
        boardCopy = copy.deepcopy(board)
        if depth == 0 or board.is_checkmate() or board.is_stalemate():
            eval = Points.heuristic(board)
            endEval = MoveEval("empty", eval)
            return endEval

        if(not turn): 
            maxValue = MoveEval("", -math.inf)
            for i in board.legal_moves:
                #boardCopy = copy.deepcopy(board)
                # print(boardCopy)
                # print('\n')
                board.push(i)
                value = self.minimax(board, depth - 1, True, alpha, beta)
                board.pop()
                # print(value)
                if(value.evaluation >= maxValue.evaluation):
                    maxValue = value
                    maxValue.move = i.uci()
                
                if (maxValue.evaluation >= alpha.evaluation):
                    alpha = maxValue
                if (beta.evaluation <= alpha.evaluation):
                    break
            return maxValue
        else:
            minValue = MoveEval("", math.inf)
            for i in board.legal_moves:
                #boardCopy = copy.deepcopy(board)
                # print(boardCopy)
                # print('\n')
                board.push(i)
                value = self.minimax(board, depth - 1, False, alpha, beta)
                board.pop()
                # print(value)
                if(value.evaluation <= minValue.evaluation):
                    minValue = value
                    minValue.move = i.uci()
                if (minValue.evaluation <= beta.evaluation):
                    beta = minValue
                if (beta.evaluation <= alpha.evaluation):
                    break
            return minValue
            

    def makeMove(self, board, depth, turn):
        print('\n'+'\U0001F914'+"...Thinking..."+'\U0001F914'+'\n')
        tuple = self.minimax(board, depth, turn, MoveEval("",-math.inf),MoveEval("",math.inf))
        move  = tuple.move
        print("Move made is: ", move)
        board.push_san(move)
        return (board)
        # history.append(board.fen())
    
    def makeFirstMove(self, board):
        firstmoves = []
        for i in board.legal_moves:
            firstmoves.append(i.uci())
        rnd = random.randint(0,len(firstmoves)-1)
        move = firstmoves[rnd]
        board.push_san(move)
        return (board)
        # history.append(board.fen())
