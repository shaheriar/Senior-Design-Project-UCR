from MoveEval import MoveEval
import chess
from Player import Player
from hardware import *
import Points
import random
from math import inf
import copy
import pandas as pd


class AI(Player):
    difficulty = 0

    def __init__(self, recommendMoves, difficulty):
        super().__init__(recommendMoves)
        self.difficulty = difficulty

    def minimax(self, board, depth, turn, alpha, beta):
        #boardCopy = copy.deepcopy(board)
        if depth == 0 or board.is_checkmate() or board.is_stalemate():
            eval = Points.heuristic(board, turn, self.difficulty)
            endEval = MoveEval("empty", eval)
            return endEval

        if(not turn):
            maxValue = MoveEval("", -inf)
            for i in board.legal_moves:
                #boardCopy = copy.deepcopy(board)
                # print(boardCopy)
                # print('\n')
                board.push(i)
                value = self.minimax(board, depth - 1, True,
                                     alpha, beta)
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
                value = self.minimax(
                    board, depth - 1, False, alpha, beta)
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
        print('\n'+'\U0001F914'+"...Thinking..."+'\U0001F914'+'\n')
        tuple = self.minimax(board, depth, turn, MoveEval(
            "", -inf), MoveEval("", inf))
        move = tuple.move
        # Light up board for AI move: BLUE
        setLEDS([(move[-2:], BLUE), (move[0:2], BLUE)])
        print("Move made is: ", move)
        get_move([move])
        board.push_san(move)

        # string form of the board
        boardlist = ""  # list()
        columns = chess.FILE_NAMES
        for j in reversed(range(1, 9)):
            for i in columns:
                sqr = board.piece_at(chess.parse_square(i+str(j)))
                if (sqr != None):
                    boardlist += sqr.symbol()
                else:
                    boardlist += '.'
        # adding the string to the csv
        data = {'Moves': [boardlist]}
        df = pd.DataFrame(data)
        df.to_csv(historyFile, mode='a', index=False, header=False)

        return (board)
        # history.append(board.fen())

    def makeFirstMove(self, board, historyFile):
        firstmoves = []
        for i in board.legal_moves:
            firstmoves.append(i.uci())
        rnd = random.randint(0, len(firstmoves)-1)
        move = firstmoves[rnd]
        setLEDS([(move[-2:], BLUE), (move[0:2], BLUE)])
        get_move([move])
        board.push_san(move)

        # string form of the board
        boardlist = ""
        columns = chess.FILE_NAMES
        for j in reversed(range(1, 9)):
            for i in columns:
                sqr = board.piece_at(chess.parse_square(i+str(j)))
                if (sqr != None):
                    boardlist += sqr.symbol()
                else:
                    boardlist += '.'
        # adding the string to the csv
        data = {'Moves': [boardlist]}
        df = pd.DataFrame(data)
        df.to_csv(historyFile, mode='a', index=False, header=False)

        return (board)
        # history.append(board.fen())
