
:-use_module(library(between)).

/*
* Prints player turn message:
* print_turn(+Type)
*/
print_turn(samurai):- write('\nSamurais turn ([source x][source y]-[x dest][y dest]):\n').
print_turn(ninja):-   write('\nNinjas turn ([source x][source y]-[x dest][y dest]):\n').

/*
* Prints winner message:
* congratulate(+Type)
*/
congratulate(samurai):- write('\nGOOD JOB! Samurais have WON!\n(Press any key to continue)\n').
congratulate(ninja):-   write('\nGOOD JOB! Ninjas have WON!\n(Press any key to continue)\n').

/*
* Displays the game, i.e. the board and the turn message, for the given game state:
* display_game(+GameState)
* GameState = Board-Size-Points1-Points2-Type
*/
display_game(Board-Size-_-_-Type):-
    print_board(Board, Size),
    print_turn(Type).

/*
* Prints the board given by Board:
* print_board(+Board, +Size)
*/ 
print_board(Board, Size):-
    clear_screen,
    print_top_bar(Size),
    print_rows(Board, Size),
    print_letters(Size).

/*
* Prints the top bar (i.e. the first line) of the board:
* print_top_bar(+Size)
*/ 
print_top_bar(Size):-
  print_n_times(' ', 11),
  print_n_times(' ___________ ', Size), nl.

/*
* Prints all rows of a board:
* print_rows(+Board, +Size)
*/
print_rows(Board, Size):-
    print_rows(Board, Size, Size).

print_rows([Row], Index, Size):-
    print_lines(Row, Index, Size), !.

print_rows([Row|List], Index, Size):-
    print_lines(Row, Index, Size), nl,
    NextIndex is Index - 1,
    print_rows(List, NextIndex, Size).
    
/*
* Prints all lines depending on the row:
* print_lines(+Row, +RowIndex, +Size)
*/
print_lines(Row, RowIndex, Size):- 
    print_line(Row, RowIndex, 5, Size), nl,
    print_line(Row, RowIndex, 4, Size), nl,
    print_line(Row, RowIndex, 3, Size), nl,
    print_line(Row, RowIndex, 2, Size), nl,
    print_line(Row, RowIndex, 1, Size).

/*
* Prints a single line depending on the row and line index:
* print_line(+Row, +RowIndex, +LineIndex, +Size)
*/
print_line(Row, 8, 5, _):- write('      _    '), print_cols(Row, 8, 5), !. 
print_line(Row, 8, 4, _):- write('     (_)   '), print_cols(Row, 8, 4), !.
print_line(Row, 8, 3, _):- write('     (_)   '), print_cols(Row, 8, 3), !.
 
print_line(Row, 7, 5, _):- write('      __   '), print_cols(Row, 7, 5), !. 
print_line(Row, 7, 4, _):- write('       /   '), print_cols(Row, 7, 4), !.
print_line(Row, 7, 3, _):- write('      /    '), print_cols(Row, 7, 3), !. 

print_line(Row, 6, 4, _):- write('      /    '), print_cols(Row, 6, 4), !.
print_line(Row, 6, 3, _):- write('     (_)   '), print_cols(Row, 6, 3), !.

print_line(Row, 5, 5, _):- write('      _    '), print_cols(Row, 5, 5), !.
print_line(Row, 5, 4, _):- write('     |_    '), print_cols(Row, 5, 4), !.
print_line(Row, 5, 3, _):- write('      _)   '), print_cols(Row, 5, 3), !.

print_line(Row, 4, 5, _):- write('       .   '), print_cols(Row, 4, 5), !.
print_line(Row, 4, 4, _):- write('      /|   '), print_cols(Row, 4, 4), !.
print_line(Row, 4, 3, _):- write('     \'-|   '), print_cols(Row, 4, 3), !.

print_line(Row, 3, 5, _):- write('      _    '), print_cols(Row, 3, 5), !.
print_line(Row, 3, 4, _):- write('      _)   '), print_cols(Row, 3, 4), !.
print_line(Row, 3, 3, _):- write('      _)   '), print_cols(Row, 3, 3), !.

print_line(Row, 2, 5, _):- write('      _    '), print_cols(Row, 2, 5), !.
print_line(Row, 2, 4, _):- write('       )   '), print_cols(Row, 2, 4), !.
print_line(Row, 2, 3, _):- write('      /_   '), print_cols(Row, 2, 3), !.

print_line(Row, 1, 4, _):- write('      /|   '), print_cols(Row, 1, 4), !.
print_line(Row, 1, 3, _):- write('       |   '), print_cols(Row, 1, 3), !.

print_line(_, 1, 1, _):- !.

print_line(_, _, 1, Size):- 
    print_n_times(' ', 11), 
    print_n_times('|-----------|', Size), !.

print_line(Row, RowIndex, LineIndex, _):-
    print_n_times(' ', 11),
    print_cols(Row, RowIndex, LineIndex), !.

/*
* Prints all columns of a row:
* print_cols(+Pieces, +RowIndex, +LineIndex)
*/
print_cols([Piece], RowIndex, LineIndex):-
    print_col(Piece, RowIndex, LineIndex).
    
print_cols([Piece|Pieces], RowIndex, LineIndex):-
    print_col(Piece, RowIndex, LineIndex),
    print_cols(Pieces, RowIndex, LineIndex).

/*
* Prints a column depending on the current piece:
* print_col(+Piece, +RowIndex, +LineIndex)
*/
print_col(piece(empty), 1, 2):- write('|___________|'), !.
print_col(piece(empty), _, _):- write('|           |').

print_col(piece(samurai), _, 5):- write('|  /_\\      |').
print_col(piece(samurai), _, 4):- write('| [-_-]     |').
print_col(piece(samurai), _, 3):- write('| --|-ol==> |').
print_col(piece(samurai), 1, 2):- write('|__/ \\______|').
print_col(piece(samurai), _, 2):- write('|  / \\      |').

print_col(piece(ninja), _, 5):- write('|    //     |').
print_col(piece(ninja), _, 4):- write('|   [-*-]~  |').
print_col(piece(ninja), _, 3):- write('|  x--|--   |').
print_col(piece(ninja), 1, 2):- write('|____/ \\____|').
print_col(piece(ninja), _, 2):- write('|    / \\    |').

/*
* Prints a string/char n times to the output stream:
* print_n_times(+Value, +Count)
*/
print_n_times(Value, N):-
    between(1, N, _T),
    write(Value),
    fail.
print_n_times(_N, _C).

print_letters(6):-
    write('                             _             _            _            __           __  '), nl,
    write('                /\\          |_)           /            | \\          |_           |_ '), nl,
    write('               /--\\         |_)           \\_           |_/          |__          |  '), nl.

print_letters(7):-
    write('                             _             _            _            __           __           _    '), nl,
    write('                /\\          |_)           /            | \\          |_           |_           /   '), nl,
    write('               /--\\         |_)           \\_           |_/          |__          |            \\_?'), nl.

print_letters(8):-
    write('                             _             _            _            __           __           _                 '), nl,
    write('                /\\          |_)           /            | \\          |_           |_           /            |_| '), nl,
    write('               /--\\         |_)           \\_           |_/          |__          |            \\_?          | |'), nl.

/*
* Clears the screen:
* clear_screen
*/
clear_screen:- write('\33\[2J').