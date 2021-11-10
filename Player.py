import chess


class player:
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

    def makeMove(self, board, move):
        if(self.recommendMoves == True):
            self.Recommend(board)

        move = input('DESIRED MOVE: ')
        if (move == 'quit'):
            print('GAME ENDED')
            return
        while(1):
            try:
                board.push_san(move)
                break
            except:
                print('INVALID MOVE\n')
                move = input('DESIRED MOVE: ')
