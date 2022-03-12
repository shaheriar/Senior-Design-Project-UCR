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
    square_values = {"e4": 0.3, "e5": 0.3, "d4": 0.3, "d5": 0.3, "c6": 0.1, "d6": 0.1, "e6": 0.1, "f6": 0.1,
                     "c3": 0.1, "d3": 0.1, "e3": 0.1, "f3": 0.1, "c4": 0.1, "c5": 0.1, "f4": 0.1, "f5": 0.1}
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


def pawn_struct(board, turn):
    score = 0
    for j in reversed(range(1, 9)):
        for i in range(chess.FILE_NAMES):
            sqr = board.piece_at(chess.parse_square(
                chess.FILE_NAMES[i]+str(j)))
            if board.piece_at(chess.parse_square(sqr)) == chess.PAWN:
                tl = i-1, j-1
                tr = i-1, j+1
                if tl[0] >= 0 and tl[0] <= 7 and tl[1] >= 0 and tl[1] <= 7:
                    if board.piece_at(chess.parse_square(chess.FILE_NAMES[tl[0]]+str(tl[1]))) == chess.PAWN:
                        if(turn == 0):
                            score += .5
                        else:
                            score -= .5
                if tr[0] >= 0 and tr[0] <= 7 and tr[1] >= 0 and tr[1] <= 7:
                    if board.piece_at(chess.parse_square(chess.FILE_NAMES[tr[0]]+str(tr[1]))) == chess.PAWN:
                        if(turn == 0):
                            score += .5
                        else:
                            score -= .5
    return score


def heuristic(board, turn, difficulty):
    if difficulty == 2:
        return incheck(board, turn)
    if difficulty == 3:
        return material(board) + incheck(board, turn)
    if difficulty == 4:
        return material(board) + piece_moves(board, turn) + incheck(board, turn) + pawn_struct(board, turn)
    else:
        return material(board) + piece_moves(board, turn) + incheck(board, turn) + pawn_struct(board, turn)
