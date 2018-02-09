`timescale 1 ns / 1 ps

//freq_counter.v
//Adapted from: Rice Rodriguez
//Gets frequency from input square wave



module freq_counter(

	// 100 MHz clock

	input CLK,

	// Pmod port input JA1, renamed in constraints file to IN

	input IN,

	// Register for frequency

	output reg [11:0] freq = 12'b0);



	// Register for one second counter

	reg[31:0] count = 32'b0;

	// Register for input counter

	reg [11:0] edge_count = 12'b0;

	// Register for storing last signal, used for detecting rising edge

	reg last = 0;



	// Note: Line 37 changes the maximum value the counter will count to before resetting.

	// Because this module is coded for a 100 MHz clock, it is set to 100 million, as that is the

	// number of ticks in one second at this clock speed. If this code were implemented on a

	// different board with a different clock speed, this is the only line that would need to be

	// changed. Adjust it for the appropriate clock speed as needed.



	//localparam max = 'd10000;           // Uncomment this out for testbench

	 localparam max = 'd100000000;         // Comment this for testbench



	// Flip-flop stores last value in register

	always @(posedge CLK) begin

		last <= IN;

	end



	always @ (posedge CLK)

	begin

		case (1)

			// Increment counter if it hasn't reached the maximum value yet.

			count < max: begin

				// If detecting a HIGH and the last value was LOW, then it's a rising edge

				count <= count + 1;

				if(~last & IN)

					edge_count <= edge_count + 1;

				end

			// If it reached the max, it's been 1 second. Store value in frequency register and

			// reset counters.

			default: begin

				freq <= edge_count;

				edge_count <= 0;

				count <= 0;

			end

		endcase

	end



endmodule