FINAL PROJECT -- EE354: SPRING 2020
_______________________________________________________________________________________________________________________________
The following project will mimic the game Tic-Tac-Toe with an VGA Monitor display of the game board. The states and state 
transitions are made clear below.


_______________________________________________________________________________________________________________________________
State #1) IDLE:

Transitional Statements
- Asynchronously resets when BTNC is pressed
- "play" Flag determines whether or not the player has made a move ("X"-character), else remains in IDLE state

Functionality (RTL)
-
_______________________________________________________________________________________________________________________________
State #2) PLAYERS_TURN:

Transitional Statements
-"legal_move" flag will be set if the player has placed an "X" in a position that neither they nor the computer has filled,
 else returns to IDLE for legal player move.

Functionality (RTL)
-
_______________________________________________________________________________________________________________________________
State #3) COMPS_TURN:

Transitional Statements
-"board_filled" flag will be set to "1" if there are no other positions for the computer or player to fill, moving to 
 DONE state.
-"winner_found" flag examines the board and sees whether there is a winning combination of "X" or "O" positions.
-(potential) "pc_done" flag set when leaving the computer state, else remains in COMPS_TURN
Functionality (RTL)
