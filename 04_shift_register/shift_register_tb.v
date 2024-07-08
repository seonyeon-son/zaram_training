`define CLKFREQ		100
`define	SIMCYCLE	10

`include "shift_register.v"

module shift_register_tb;
// --------------------------------------------------
//		DUT Signals & Instantiate
// --------------------------------------------------
	parameter		N = 8;

	reg				clk;
	reg				load;
	reg				Sin;
	reg  [N-1:0]	D;
	wire [N-1:0]	Q;
	wire			Sout;

	shift_register
	u_shift_register(
		.clk		(clk	),
		.load		(load	),
		.Sin		(Sin	),
		.D			(D		),
		.Q			(Q		),
		.Sout		(Sout	)
	);

// --------------------------------------------------
//	Clock
// --------------------------------------------------
	always	#(1000/`CLKFREQ)
		clk = ~clk;

// --------------------------------------------------
//	Tasks
// --------------------------------------------------
	task init;
		begin
			clk		= 0;
			load	= 0;
			Sin		= 0;
			D		= 0;
		end
	endtask

// --------------------------------------------------
//	Test Stimulus
// --------------------------------------------------
	integer		i;
	initial begin
		init();

		for (i=0; i<`SIMCYCLE; i++) begin		// Serial to Parallel
			@(posedge clk);
			load	= 0;
			D		= $urandom;
			Sin		= $urandom;
		end

			@(posedge clk);					// N-bit register
			load	= 1;
			D		= $urandom;
			Sin		= $urandom;

		for (i=0; i<`SIMCYCLE; i++) begin		// Parallel to Serial
			@(posedge clk);
			load	= 0;
			D		= $urandom;
			Sin		= $urandom;
		end

		#1000;
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
				$dumpfile("shift_register_tb.vcd");
				$dumpvars;
			end
		end
	
		endmodule
	







