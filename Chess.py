import chess
import chess.svg
from cairosvg import svg2png
import os
from datetime import datetime

arr = ['\nWHITE\'S TURN\n','\nBLACK\'S TURN\n']

def menu():
    x = 0    
    print('------------------------------')
    print('Smart Chess by The Segfaults')
    print('------------------------------')    
    print('\nMenu Options')
    print('\n1. Play\n')
    x = int(input('Menu option: '))
    while (x != 1):
        print('Please enter a valid value')
        x = input('Menu option: ')
    print('\nMenu Options')
    print('\n1. vs Human\n')
    x = int(input('Menu option: '))
    while (x != 1):
        print('Please enter a valid value')
        x = int(input('Menu option: '))
    return
    #print('Assists')
    #print('1. Recommended Moves (Y/N)')
    #print('2. vs AI')
    #x = input('Menu option: ')
    #while (x != 1 or x != 2):
    #    print('Please enter a valid value')
    #    x = input('Menu option: ')

def start():
    turn = False #WHITE IS 0, BLACK IS 1
    move = ''
    x = 0
    svg = ''
    board = chess.Board()
    now = datetime.now()
    history = []
    try:
        os.mkdir('SaveGames')
    except:
        print()
    path = 'SaveGames\\'+now.strftime("%m_%d_%Y__%H_%M_%S")
    os.mkdir(path)
    while (not board.is_checkmate() or not board.is_stalemate()):
        try:
            svg = chess.svg.board(board=board, lastmove=board.peek())
        except:
            svg = chess.svg.board(board=board)
        abspath = path+'\\'+str(x)+'.png'
        svg2png(svg, write_to=abspath,scale=2)
        print('\n')
        print('-----------')
        print('Smart Chess')
        print('-----------')
        print(board)
        fd = os.popen(abspath)
        print('-----------')
        print(arr[turn])
        if (board.is_checkmate()):
            print('GAME ENDED BY CHECKMATE')
            break
        
        elif (board.is_stalemate()):
            print('GAME ENDED BY STALEMATE')
            break
        print(board.legal_moves)
        move = input('DESIRED MOVE: ')
        if (move == 'quit'):
            print('GAME ENDED')
            if (turn == 1):
                print('WHITE WON BY FORFEIT')
            else:
                print('BLACK WON BY FORFEIT')
            choice = input('RESTART? (Y/N): ')
            if (choice == 'Y' or choice == 'y'):
                board = chess.Board()
                continue
            else:
                return
        while(1):
            try:
                board.push_san(move)
                history.append(board.fen())
                break
            except:
                print('INVALID MOVE\n')
                move = input('DESIRED MOVE: ')
                
        with open(path+'\\'+'log.txt', 'a') as f:
            f.write(board.fen()+'\n')
        turn = not turn
        x += 1

    

def main():
    menu()
    start()

if __name__ == "__main__":
    main()