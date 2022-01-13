import chess
from Points import piecePoints
import Points
from MoveEval import MoveEval
from math import inf
import pandas as pd


class Player:
    # parameters
    recommendMoves = False

    def __init__(self, recommendMoves):
        self.recommendMoves = recommendMoves

    def recommend(self, board, depth, turn, alpha, beta):
        #boardCopy = copy.deepcopy(board)
        if depth == 0 or board.is_checkmate() or board.is_stalemate():
            eval = Points.heuristic(board,turn)
            endEval = MoveEval("empty", eval)
            return endEval

        if(not turn): 
            maxValue = MoveEval("", -inf)
            for i in board.legal_moves:
                #boardCopy = copy.deepcopy(board)
                # print(boardCopy)
                # print('\n')
                board.push(i)
                value = self.recommend(board, depth - 1, True, alpha, beta)
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
            minValue = MoveEval("", inf)
            for i in board.legal_moves:
                #boardCopy = copy.deepcopy(board)
                # print(boardCopy)
                # print('\n')
                board.push(i)
                value = self.recommend(board, depth - 1, False, alpha, beta)
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

    def makeMove(self, board, depth, turn, historyFile):
        if(self.recommendMoves == True):
            print('\nRECOMMENDED MOVE:',self.recommend(board, depth, turn, MoveEval("",-inf),MoveEval("",inf)).move)
        while(1):    
            move = input('DESIRED MOVE: ')
            try:
                board.push_san(move)
                #string form of the board
                boardlist = ""
                columns = chess.FILE_NAMES
                for j in reversed(range(1,9)):
                    for i in columns:
                        sqr = board.piece_at(chess.parse_square(i+str(j)))
                        if (sqr != None):
                            boardlist += sqr.symbol()
                        else:
                            boardlist += '.' 
                        # print(boardlist)
                #adding the string to the csv
                #df = pd.read_csv(historyFile)
                data = {'Moves' : [boardlist]}
                df2 = pd.DataFrame(data)
                df2.to_csv(historyFile, mode='a', index=False, header=False)

                return (board)
            except Exception as e:
                print('INVALID MOVE\n')
                print(e)
            
            
