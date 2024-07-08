`define CLKFREQ		100
`define SIMCYCLE	10

`include "barrel_shifter.v"

module	barrel_shifter_tb;
// --------------------------------------------------
//		DUT Signals & Instantiate
// --------------------------------------------------
	reg		[2:0]	k;
	reg 	[7:0]	A_i;
	wire 	[7:0]	Y_o;

	barrel_shifter
	u_barrel_shifter(
		.k		(k		),
		.A_i	(A_i	),
		.Y_o	(Y_o	)
	);

// --------------------------------------------------
//	Tasks
// --------------------------------------------------
	task init;
			begin
				A_i = 0;
				k = 0;
			end
	endtask

// --------------------------------------------------
//	Test Stimulus
// --------------------------------------------------
	integer		i;
	initial begin
		init();

			A_i = 8'b0010_0101;

		for (i=0; i<`SIMCYCLE; i++) begin			//rotate_0
			#(1000/`CLKFREQ);
			k[0] = 0;
			k[1] = 0;
			k[2] = 0;
		end

		for (i=0; i<`SIMCYCLE; i++) begin			//roatate_1
			#(1000/`CLKFREQ);
			k[0] = 1;
			k[1] = 0;
			k[2] = 0;
		end

		for (i=0; i<`SIMCYCLE; i++) begin			//rotate_2
			#(1000/`CLKFREQ);
			k[0] = 0;
			k[1] = 1;
			k[2] = 0;
		end

		for (i=0; i<`SIMCYCLE; i++) begin			//rotate_3
			#(1000/`CLKFREQ);
			k[0] = 1;
			k[1] = 1;
			k[2] = 0;
		end

		for (i=0; i<`SIMCYCLE; i++) begin			//rotate_4
			#(1000/`CLKFREQ);
			k[0] = 0;
			k[1] = 0;
			k[2] = 1;
		end

		for (i=0; i<`SIMCYCLE; i++) begin			//rotate_5
			#(1000/`CLKFREQ);
			k[0] = 1;
			k[1] = 0;
			k[2] = 1;
		end

		for (i=0; i<`SIMCYCLE; i++) begin			//rotate_6
			#(1000/`CLKFREQ);
			k[0] = 0;
			k[1] = 1;
			k[2] = 1;
		end

		for (i=0; i<`SIMCYCLE; i++) begin			//rotate_7
			#(1000/`CLKFREQ);
			k[0] = 1;
			k[1] = 1;
			k[2] = 1;
		end

		for (i=0; i<`SIMCYCLE; i++) begin			//rotate_random
			#(1000/`CLKFREQ);
			k = $urandom;
		end

		$finish;

	end

		
// --------------------------------------------------
//	Dump VCD
// --------------------------------------------------
		reg	[8*32-1:0]	vcd_file;
		initial begin
			if ($value$plusargs("vcd_file=%s", vcd_file)) begin
				$dumpfile(vcd_file);
				$dumpvars;
			end else begin
				$dumpfile("barrel_shifter_tb.vcd");
				$dumpvars;
			end
		end
	
		endmodule
