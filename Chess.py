import chess
import chess.svg

def menu():
    x = 0
    print('Smart Chess by The Segfaults')
    print('Menu Options')
    print('1. Play')
    x = int(input('Menu option: '))
    while (x != 1):
        print('Please enter a valid value')
        x = input('Menu option: ')
    print('Menu Options')
    print('1. vs Human')
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
        print(board)
        if (not turn):
            print('\nWHITE\'S TURN\n')
        else:
            print('\nBLACK\'S TURN\n')
        print(board.legal_moves)
        move = input('DESIRED MOVE: ')
        while(1):
            try:
                board.push_san(move)
                break
            except:
                print('INVALID MOVE\n')
                move = input('DESIRED MOVE: ')
        print(board)
        turn = not turn
        




def main():
    menu()
    start()

if __name__ == "__main__":
    main()