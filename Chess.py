import chess
import chess.svg

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
    board = chess.Board()
    while (not board.is_checkmate() or not board.is_stalemate()):
        print('\n')
        print('-----------')
        print('Smart Chess')
        print('-----------')
        print(board)
        print('-----------')
        if (not turn):
            print('\nWHITE\'S TURN\n')
        else:
            print('\nBLACK\'S TURN\n')
        print(board.legal_moves)
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
        turn = not turn

def main():
    menu()
    start()

if __name__ == "__main__":
    main()