import chess
import Player


class AI(Player):
    difficutly = 0

    def __init__(self, points, name, recommendMoves, difficutly) -> None:
        super().__init__(points, name, recommendMoves)
        self.difficutly = difficutly

    def makeMove(board):
        pass
        # Minimax algo
