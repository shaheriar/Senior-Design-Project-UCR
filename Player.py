import chess
from cairosvg import svg2png
from Points import piecePoints


class Player:
    # parameters
    points = 0
    name = ""
    recommendMoves = False

    def __init__(self, points, name, recommendMoves):
        self.points = points
        self.name = name
        self.recommendMoves = recommendMoves

    def Recommend(board):
        # miniMax algo
        pass

    def makeMove(self, board, move, history, otherPlayer):
        # if(self.recommendMoves == True):
        #     self.Recommend(board)

        while(1):
            try:
                actualMove = board.parse_san(move)
                print(board.is_capture(actualMove))
                if(board.is_capture(actualMove)):
                    self.points += piecePoints[board.piece_at(
                        actualMove.to_square).piece_type]
                    otherPlayer.points -= piecePoints[board.piece_at(
                        actualMove.to_square).piece_type]
                board.push_san(move)
                history.append(board.fen())
                break
            except:
                print('INVALID MOVE\n')
                move = input('DESIRED MOVE: ')
