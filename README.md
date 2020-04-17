FINAL PROJECT -- EE354: SPRING 2020
____________________________________________________________________________________________________________________________
The following project will mimic the game Tic-Tac-Toe with an VGA Monitor display of the game board. The states and state 
transitions are made clear below.

The computer will randomly place the first move, then continue to move in a specific line or diagonal until blocked by the player. In a given turn, the computer will choose to block a player if it is not able to win in its turn, and the player has the potential to win in the next turn.

After debugging the game, I believe I can give the computer another flag to tell it when to give up in the case of a checkmate scenario.


____________________________________________________________________________________________________________________________
State #1) IDLE:

Transitional Statements
- Debounced "reset" flag set when BTNC is pressed
- "play" Flag determines whether or not the player has made a move ("X"-character), else remains in IDLE state

always@(*)
	IDLE:
		begin
			if (~reset && play):
				state <= PLAYERS_TURN;
		end

Functionality (RTL)
-
____________________________________________________________________________________________________________________________
State #2) PLAYERS_TURN:

Transitional Statements
-"legal_move" flag will be set if the player has placed an "X" in a position that neither they nor the computer has filled,
 else returns to IDLE for legal player move.

PLAYERS_TURN:
	begin
		if (legal_move):
			state <= COMPS_TURN;
	end

Functionality (RTL)
-
____________________________________________________________________________________________________________________________
State #3) COMPS_TURN:

Transitional Statements
-"board_filled" flag will be set to "1" if there are no other positions for the computer or player to fill, moving to 
 DONE state.
-"winner_found" flag examines the board and sees whether there is a winning combination of "X" or "O" positions.
-(potential) "pc_done" flag set when leaving the computer state, else remains in COMPS_TURN

COMPS_TURN:
	begin
		if (pc_done && (board_filled || winner_found)):
			state <= DONE;
		else if (~board_filled && ~winner_found):
			state <= IDLE:
	end

Functionality (RTL)
-
____________________________________________________________________________________________________________________________
State #4) DONE:

Transitional Statement
-"reset" (via BTNC) will return to IDLE state.
____________________________________________________________________________________________________________________________

The display will be straight forward and clean. Blank spots with a filled dot in the center represent blank spaces, forrest green "X"s display the player's positions on the board, cherry red "O"s follow the computer's moves.

* | * | *       X | X | O
---------       ---------
* | * | *  -->  O | X | O   	= 		PLAYER WINS!
---------		---------			Want to play again?
* | * | *		O | O | X



