// State Machine Design for Tic Tac Toe

module sm_ttt(Clk, reset, ack, Q_IDLE, Q_PLAYER, Q_COMPUTER, Q_DONE, start, legal_move, pc, winner_found, full);

input start, ack, reset, Clk;
output legal_move, pc, winner_found, full;
output Q_IDLE, Q_PLAYER, Q_COMPUTER, Q_DONE;

reg [8:0] player_board, computer_board;
reg [3:0] state; // one-hot states

assign {Q_IDLE, Q_PLAYER, Q_COMPUTER, Q_DONE} = state;

localparam
INIT = 4'b1000,
PLAYER = 4'b0100,
COMPUTER = 4'b0010,
DONE = 4'b0001;

always @ (posedge Clk, posedge reset)
	begin: ST_n_RTL
		if (reset)
			begin
				state <= INIT;
				player_board <= 9'bXXXXXXXXX;
				computer_board <= 9'bXXXXXXXXX;
			end
		else
			begin
				case (state)
					INIT :
						begin
							// State Transitions
							if (start)
								state <= PLAYER;
								
							// reset flags
							winner_found <= 1'bX;
							start <= 1'bX;
							pc <= 1'b0;
							full <= 1'b0;
							legal_move <= 1'b0;
						end
					PLAYER :
						begin
							// State Transitions
							if (legal_move && pc)
								state <= COMPUTER;
							else if (!legal_move && pc)
								state <= INIT;
								
							// RTL
							
						end
					COMPUTER :
						begin
							// State Transitions
							if (pc && (!winner_found || !full))
								state <= INIT;
							else if (pc && (winner_found || full))
								state <= DONE;
							
							// RTL
						end
					DONE :
						begin
							// State Transitions
							if (ack)
								state <= INIT;
						
						end
						
				endcase
			end
		end
	
	// OFL
	
