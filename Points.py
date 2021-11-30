import chess
from math import inf

piecePoints = {
    chess.PAWN: 1,
    chess.KNIGHT: 3,
    chess.BISHOP: 3,
    chess.ROOK: 5,
    chess.QUEEN: 9,
    chess.KING: 200
}

def piece_moves(board, turn):
    score = 0
    square_values = {"e4": 1, "e5": 1, "d4": 1, "d5": 1, "c6": 0.5, "d6": 0.5, "e6": 0.5, "f6": 0.5,
                    "c3": 0.5, "d3": 0.5, "e3": 0.5, "f3": 0.5, "c4": 0.5, "c5": 0.5, "f4": 0.5, "f5": 0.5}
    possible_moves = list(board.legal_moves)
    for move in possible_moves:
        if turn == False:
            if move.uci()[2:4] in square_values:
                score += square_values[move.uci()[2:4]]
        else:
            if move.uci()[2:4] in square_values:
                score -= square_values[move.uci()[2:4]]
    if (score > 0):
        return score - 6
    else:
        return score + 6

def material(board):
    # board.
    score = 0
    for i in chess.SQUARES:
        if (board.piece_at(i) != None):
            if (board.color_at(i) == chess.COLORS[0]):
                score += piecePoints[board.piece_type_at(i)]
            else:
                score -= piecePoints[board.piece_type_at(i)]
    return score

def incheck(board, turn):
    score = 0
    if (board.is_check()):
        if (turn == True):
            score += 1
        else:
            score -= 1

    outcome = board.outcome()
    if (outcome != None):
        #print('TERMINATION DETECTED: ', outcome.termination)
        if (outcome.termination == chess.Termination.CHECKMATE):
            #print('DETECTED CHECKMATE')
            if (outcome.winner == chess.COLORS[0]):
                #print('WHITE WINS THE CHECKMATE')
                return inf
            else:
                #print('BLACK WINS THE CHECKMATE')
                return -inf
    return score

def heuristic(board, turn):
    return material(board) + piece_moves(board,turn) + incheck(board,turn)