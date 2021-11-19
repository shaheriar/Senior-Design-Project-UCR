import chess
import math

piecePoints = {
    chess.PAWN: 1,
    chess.KNIGHT: 3,
    chess.BISHOP: 3,
    chess.ROOK: 5,
    chess.QUEEN: 9,
    chess.KING: 200
}

def heuristic(board):
    # board.
    score = 0
    for i in chess.SQUARES:
        outcome = board.outcome()
        if (outcome != None):
            #print('TERMINATION DETECTED: ', outcome.termination)
            if (outcome.termination == chess.Termination.CHECKMATE):
                #print('DETECTED CHECKMATE')
                if (outcome.winner == chess.COLORS[0]):
                    #print('WHITE WINS THE CHECKMATE')
                    return math.inf
                else:
                    #print('BLACK WINS THE CHECKMATE')
                    return -math.inf
        if (board.piece_at(i) != None):
            if (board.color_at(i) == chess.COLORS[0]):
                score += piecePoints[board.piece_type_at(i)]
            else:
                score -= piecePoints[board.piece_type_at(i)]
    return score
