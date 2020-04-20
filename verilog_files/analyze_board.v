`default_nettype none

module analyze_board(input_board, result);
  input wire [8:0] input_board;
  output reg [1:0] result;

  localparam DO_NOTHING = 0;
  localparam PLAYER_WINS = 1;
  localparam COMPUTER_WINS = 2;
  localparam DRAW = 3;

  // An X move is 11, an O move is 01 on the board

  always @(*)
    // analyze the board for winning combinations, else leave the game going
    if ((input_board & 18'b111111000000000000) == 18'b111111000000000000)
      result = PLAYER_WINS;
    else if ((input_board & 18'b111111000000000000) == 18'b010101000000000000)
      result = COMPUTER_WINS;
    else if ((input_board & 18'b000000111111000000) == 18'b000000111111000000)
      result = PLAYER_WINS;
    else if ((input_board & 18'b000000111111000000) == 18'b000000010101000000)
      result = COMPUTER_WINS;
    else if ((input_board & 18'b000000000000111111) == 18'b000000000000111111)
      result = PLAYER_WINS;
    else if ((input_board & 18'b000000000000111111) == 18'b000000000000010101)
      result = COMPUTER_WINS;
    else if ((input_board & 18'b110000110000110000) == 18'b110000110000110000)
      result = PLAYER_WINS;
    else if ((input_board & 18'b110000110000110000) == 18'b010000010000010000)
      result = COMPUTER_WINS;
    else if ((input_board & 18'b001100001100001100) == 18'b001100001100001100)
      result = PLAYER_WINS;
    else if ((input_board & 18'b001100001100001100) == 18'b000100000100000100)
      result = COMPUTER_WINS;
    else if ((input_board & 18'b000011000011000011) == 18'b000011000011000011)
      result = PLAYER_WINS;
    else if ((input_board & 18'b000011000011000011) == 18'b000001000001000001)
      result = COMPUTER_WINS;
    else if ((input_board & 18'b110000001100000011) == 18'b110000001100000011)
      result = PLAYER_WINS;
    else if ((input_board & 18'b110000001100000011) == 18'b010000000100000001)
      result = COMPUTER_WINS;
    else if ((input_board & 18'b000011001100110000) == 18'b000011001100110000)
      result = PLAYER_WINS;
    else if ((input_board & 18'b000011001100110000) == 18'b000001000100010000)
      result = COMPUTER_WINS;

    // See if we have some empty squares still left
    else if ((input_board & 18'b110000000000000000) == 18'b000000000000000000)
      result = DO_NOTHING;
    else if ((input_board & 18'b001100000000000000) == 18'b000000000000000000)
      result = DO_NOTHING;
    else if ((input_board & 18'b000011000000000000) == 18'b000000000000000000)
      result = DO_NOTHING;
    else if ((input_board & 18'b000000110000000000) == 18'b000000000000000000)
      result = DO_NOTHING;
    else if ((input_board & 18'b000000001100000000) == 18'b000000000000000000)
      result = DO_NOTHING;
    else if ((input_board & 18'b000000000011000000) == 18'b000000000000000000)
      result = DO_NOTHING;
    else if ((input_board & 18'b000000000000110000) == 18'b000000000000000000)
      result = DO_NOTHING;
    else if ((input_board & 18'b000000000000001100) == 18'b000000000000000000)
      result = DO_NOTHING;
    else if ((input_board & 18'b000000000000000011) == 18'b000000000000000000)
      result = DO_NOTHING;

    // when no one wins and the board is full, the game is a draw
    else result = DRAW;
    
    
endmodule
