from AI import AI
import chess
import ast
from Player import Player
import json
# import os
from datetime import datetime
from Points import heuristic, piecePoints
import time
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
        mode = 0
        print('------------------------------')
        print('Smart Chess by The Segfaults')
        print('------------------------------')

        data = await client.recv()
        print(data, "\n")
        # dataParsed = ast.literal_eval(data)
        dataParsed = json.loads(data)
        print(dataParsed, "\n")

        if(dataParsed["gamemode"] == 1):
            player1 = Player(dataParsed["white"])
            player2 = Player(dataParsed["black"])
            return 1
        elif(dataParsed["gamemode"] == 2):
            player1 = Player(dataParsed["white"])
            AI = AI(False, 0)
            return 2

        return

    async def start(self, gameMode, client):
        turn = False  # WHITE IS 0, BLACK IS 1
        move = ''
        x = 0
        svg = ''
        board = chess.Board()
        now = datetime.now()
        history = []
        # try:
        # os.mkdir('SaveGames')
        # except:
        # print()
        #path = 'SaveGames\\'+now.strftime("%m_%d_%Y__%H_%M_%S")
        # os.mkdir(path)
        while (not board.is_checkmate() or not board.is_stalemate() or not board.is_fivefold_repetition()):
            isGameOver = await client.recv()
            if (isGameOver == 'Draw'):
                print('GAME ENDED BY DRAW')
                # Save game up to here
                break
            elif isGameOver == 'Resign':
                print("GAME ENDED BY DRAW")
                # Save game up to here
                break
            # try:
            #svg = chess.svg.board(board=board, lastmove=board.peek())
            # except:
            #svg = chess.svg.board(board=board)
            #abspath = path+'\\'+str(x)+'.png'
            #svg2png(svg, write_to=abspath, scale=2)
            print('\n')
            print('-----------')
            print('Smart Chess')
            print('-----------')

            symbolprint(board)

            # ------------------------------------------------------------------------------------------
            # try:
            #    plt.imshow(Image.open(BytesIO(svg2png(chess.svg.board(board, lastmove=board.peek())))))
            # except:
            #    plt.imshow(Image.open(BytesIO(svg2png(chess.svg.board(board)))))
            # plt.show(block=False)
            # ------------------------------------------------------------------------------------------

            #fd = os.popen(abspath)
            print('-----------')
            print(arr[turn])
            print('SCORE: ', heuristic(board, turn))
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
            # if (move == 'quit'):
            #     print('GAME ENDED')
            #     if (turn == 1):
            #         print('WHITE WON BY FORFEIT')
            #     else:
            #         print('BLACK WON BY FORFEIT')
            #     choice = input('RESTART? (Y/N): ')
            #     if (choice == 'Y' or choice == 'y'):
            #         board = chess.Board()
            #         continue
            #     else:
            #         return
            if(gameMode == 1):
                if turn == 0:
                    board = player1.makeMove(board, 5, turn)
                else:
                    board = player2.makeMove(board, 5, turn)
            elif(gameMode == 2):
                if turn == 0:
                    board = player1.makeMove(board, 5, turn)
                else:
                    if(x < 2):
                        board = AI.makeFirstMove(board)
                    else:
                        board = AI.makeMove(board, 3, turn)
            elif(gameMode == 3):
                if turn == 0:
                    if(x < 2):
                        board = player1.makeFirstMove(board)
                    else:
                        board = player1.makeMove(board, 3, turn)
                else:
                    if(x < 2):
                        board = player2.makeFirstMove(board)
                    else:
                        board = player2.makeMove(board, 3, turn)

            # with open(path+'\\'+'log.txt', 'a') as f:
            #    f.write(board.fen()+'\n')
            turn = not turn
            moveData = {"move": board.peek().uci()}
            await client.send(json.dumps(moveData))
            time.sleep(1)
            status = await client.recv()
            if (status == 'Time'):
                print('GAME ENDED BY TIME')
                break
            time.sleep(1)
            print('MESSAGE SENT')
            x += 1


def main():
    game = chessGame()
    gameMode = game.menu()
    game.start(gameMode)


if __name__ == "__main__":
    main()
