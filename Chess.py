from AI import AI
import chess
import ast
from Player import Player
import json
# import os
from datetime import datetime
from Points import heuristic, piecePoints
import time
import pandas as pd
from datetime import datetime  
# ------------------------------------------
# import chess.svg
# from cairosvg import svg2png
# from PIL import Image
# import matplotlib.pyplot as plt
# from io import BytesIO
# ------------------------------------------


def symbolprint(board):
    print(board.unicode(invert_color=True))


arr = ['\nWHITE\'S TURN\n', '\nBLACK\'S TURN\n']
# player1 = None
# player2 = None
# AI = None


class chessGame:
    #Points = 0

    async def menu(self, client):
        global player1
        global player2
        global AI
        global userColorForAIMode
        print('------------------------------')
        print('Smart Chess by The Segfaults')
        print('------------------------------')

        data = await client.recv()
        print(data, "\n")
        # dataParsed = ast.literal_eval(data)
        dataParsed = json.loads(data)
        print(dataParsed, "\n")

        if(dataParsed["gamemode"] == 1):
            player1 = Player(dataParsed["player1"])
            player2 = Player(dataParsed["player2"])
            return 1

        elif(dataParsed["gamemode"] == 2):
            player1 = Player(dataParsed["player1"])
            AI = AI(False, 0)
            userColorForAIMode = dataParsed["usercolor"]
            return 2

        return

    async def start(self, gameMode, client):
        turn = False  # WHITE IS 0, BLACK IS 1
        numberOfMoves = 0
        isGameOver = None
        board = chess.Board()

        moveHistory = pd. DataFrame(columns=["Moves"])
        now = datetime.now()
        # Where the path of the game history is vvvv
        dt_string = "Game History/"
        dt_string += now.strftime("%d-%m-%Y %H-%M-%S")
        dt_string += ".csv"
        moveHistory.to_csv(dt_string, index=False)


        while (not board.is_checkmate() or not board.is_stalemate() or not board.is_fivefold_repetition()):
            # isGameOver = await client.recv()
            if (isGameOver == 'Draw'):
                print('GAME ENDED BY DRAW')
                # Save game up to here
                break
            elif isGameOver == 'Resign':
                print("GAME ENDED BY RESIGNATION")
                # Save game up to here
                break

            print('\n')
            print('-----------')
            print('Smart Chess')
            print('-----------')

            symbolprint(board)

            print('-----------')
            print(arr[turn])
            # print('SCORE: ', heuristic(board, turn))
            if (board.is_checkmate()):
                print('GAME ENDED BY CHECKMATE')
                if turn == 1:
                    print("White Wins")
                else:
                    print("Black Wins")
                break

            elif (board.is_stalemate()):
                print('GAME ENDED BY STALEMATE')
                break
            elif (board.is_fivefold_repetition()):
                print('GAME ENDED BY FIVEFOLD REPETITION')
                break
            print(board.legal_moves)

            if(gameMode == 1):
                if turn == 0:
                    board = player1.makeMove(board, 5, turn, dt_string)
                else:
                    board = player2.makeMove(board, 5, turn, dt_string)
            elif(gameMode == 2):
                if userColorForAIMode == False:  # The user is white because 0 is white
                    if turn == 0:
                        board = player1.makeMove(board, 5, turn, dt_string)
                    else:
                        if(numberOfMoves < 2):
                            board = AI.makeFirstMove(board, dt_string)
                        else:
                            board = AI.makeMove(board, 3, turn, dt_string)
                else:  # The user is black because 1 is black
                    if turn == 0:
                        if(numberOfMoves < 2):
                            board = AI.makeFirstMove(board, dt_string)
                        else:
                            board = AI.makeMove(board, 3, turn, dt_string)
                    else:
                        board = player1.makeMove(board, 5, turn, dt_string)
            elif(gameMode == 3):
                if turn == 0:
                    if(numberOfMoves < 2):
                        board = player1.makeFirstMove(board, dt_string)
                    else:
                        board = player1.makeMove(board, 3, turn, dt_string)
                else:
                    if(numberOfMoves < 2):
                        board = player2.makeFirstMove(board, dt_string)
                    else:
                        board = player2.makeMove(board, 3, turn, dt_string)

            turn = not turn
            moveData = {"move": board.peek().uci()}
            await client.send(json.dumps(moveData))
            time.sleep(1)
            isGameOver = await client.recv()
            if (isGameOver == 'Time'):
                print('GAME ENDED BY TIME')
                break
            time.sleep(1)
            print('MESSAGE SENT')
            numberOfMoves += 1


def main():
    game = chessGame()
    gameMode = game.menu()
    game.start(gameMode)


if __name__ == "__main__":
    main()
