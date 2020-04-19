`timescale 1ns / 1ps

module main_ttt (   
		MemOE, MemWR, RamCS, QuadSpiFlashCS, // Disable the two memory chips

        ClkPort,                           // the 100 MHz incoming clock signal
		BtnL, BtnR, BtnU, BtnD,            // the Left, Up, Down, and the Right buttons 
		
		BtnC,                             // the center button (this is our reset in most of our designs)
		An7, An6, An5, An4, An3, An2, An1, An0,			       // 1 anode for 1 SSD (state num)
		Ca, Cb, Cc, Cd, Ce, Cf, Cg,        // 7 cathodes
		Dp                                 // Dot Point Cathode on SSDs
	  );


	/*  INPUTS */
	input	ClkPort;	
	input		BtnL, BtnR, BtnC, BtnU, BtnD;
	
	
	/*  OUTPUTS */
	// Control signals on Memory chips 	(to disable them)
	output 	MemOE, MemWR, RamCS, QuadSpiFlashCS;
	// SSD Outputs
	output 	Cg, Cf, Ce, Cd, Cc, Cb, Ca, Dp;
	output 	An0; // showing state num
	
	/*  LOCAL SIGNALS */
	wire			reset, ClkPort;
	wire			board_clk, sys_clk;
	wire [1:0]		ssdscan_clk;
	reg [26:0]	    DIV_CLK;
	wire 			UP, DOWN, L, R;										//wire aliasing control for buttons
	wire 			Q_IDLE, Q_PLAYER, Q_COMPUTER, Q_DONE;				//state signals
	wire 			winner_found, full, start, legal_move, pc;			//state flags
	reg [2:0] 		state_num;
	reg [2:0] 		state_sum;
	wire [3:0] 		selected_state;
	reg 			hot1_state_error;	
	reg 			selected_state_value;	
	reg [3:0]		SSD;
	wire [3:0]		SSD0;	
	reg [6:0]  		SSD_CATHODES;
	wire [6:0] 		SSD_CATHODES_blinking; // blinks when game is over (Q_DONE state)
	
//-------
	assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;
//-------
// Dividing the clock

	BUFGP BUFGP1 (board_clk, ClkPort);
	assign reset = BtnC; 												//Center button for resetting game
	
	always @ (posedge board_clk, posedge reset)							//clock divider for SSD
	begin : CLOCK_DIVIDER
		if (reset)
			DIV_CLK <= 0;
		else
			DIV_CLK <= DIV_CLK + 1'b1;
	end
	
	assign sys_clk = DIV_CLK[25]; // (~1.5Hz)
	
	// INPUT BUTTONS
	assign {UP, DOWN, L, R} = {BtnU, BtnD, BtnL, BtnR};
	
	
// State Machine (FSM)

	sm_ttt (
		.Clk(sys_clk),
		.reset(reset),
		.Q_IDLE(Q_IDLE),
		.Q_PLAYER(Q_PLAYER), 
		.Q_COMPUTER(Q_COMPUTER),
		.Q_DONE(Q_DONE),
		.start(start),
		.legal_move(legal_move),
		.pc(pc),
		.winner_found(winner_found),
		.full(full)
	);
	
// OUTPUT VGA MONITOR

	// calculate state_sum for SSD0
	always @ (Q_IDLE, Q_PLAYER, Q_COMPUTER, Q_DONE)
	begin
		state_sum = Q_IDLE + Q_PLAYER + Q_COMPUTER + Q_DONE;
	end
	
	assign SSD0 = state_num;
	assign AN0 = 
	
	
	assign SSD_CATHODES_blinking = SSD_CATHODES | ( {7{Q_DONE & sys_clk}} );
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES_blinking, 1'b1);
	
	always @ (state_num)
	begin : HEX_TO_SSD
		case (state_num)
			2'b00: SSD_CATHODES = 7'b0000001; //0 == Q_IDLE
			2'b01: SSD_CATHODES = 7'b1001111; //1 == Q_PLAYER
			2'b10: SSD_CATHODES = 7'b0010010; //2 == Q_COMPUTER
			2'b11: SSD_CATHODES = 7'b0000110; //3 == Q_DONE
			default: SSD_CATHODES = 7'bXXXXXXX; // technically not needed since all cases are taken care of
		endcase
	end
endmodule
