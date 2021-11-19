import chess
from cairosvg import svg2png
from Points import piecePoints


class Player:
    # parameters
    recommendMoves = False

    def __init__(self, recommendMoves):
        self.recommendMoves = recommendMoves

    def Recommend(board):
        # miniMax algo
        pass

    def makeMove(self, board, move, points, turn):
        # if(self.recommendMoves == True):
        #     self.Recommend(board)

        while(1):
            try:
                actualMove = board.parse_san(move)
                # print(board.is_capture(actualMove))
                if(board.is_capture(actualMove)):
                    if(turn == 0):
                        points += piecePoints[board.piece_at(
                            actualMove.to_square).piece_type]
                    else:
                        points -= piecePoints[board.piece_at(
                            actualMove.to_square).piece_type]
                board.push_san(move)
                return (board,points)
                # history.append(board.fen())
                break
            except:
                print('INVALID MOVE\n')
                move = input('DESIRED MOVE: ')
            
