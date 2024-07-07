`define CLKFREQ		100
`define SIMCYCLE	20

`include	"bin_to_gray.v"
`include	"gray_to_bin.v"

module gray_bin_tb;

// --------------------------------------------------
//		DUT Signals & Instantiate
// --------------------------------------------------
	
	parameter N = 8;

	reg				i_clk;
	reg	 [N-1:0]	i_bin;
	wire [N-1:0]	o_gray;
	wire [N-1:0]	binary;

	bin_to_gray
	#(
		. N		(N		)
	)
	u_bin_to_gray(
		. gray	(o_gray	),
		. bin	(i_bin	)
	);

	gray_to_bin
	#(
		. N		(N		)
	)
	u_gray_to_bin (
		. bin	(binary	),
		. gray	(o_gray	)
	);

// --------------------------------------------------
always #(500/`CLKFREQ) i_clk = ~i_clk;

// --------------------------------------------------
//	Task
// --------------------------------------------------
	task init;
		begin
			i_clk = 0;
			i_bin = 8'b0;
		end
	endtask


// --------------------------------------------------
//	Test Stimulus
// --------------------------------------------------
integer i;

initial begin
	init();

	for(i = 0; i<`SIMCYCLE; i++)begin
		i_bin = $urandom;
		#(1000/`CLKFREQ);
	end
	#100;
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
				$dumpfile("gray_bin_tb.vcd");
				$dumpvars;
			end
		end
	
		endmodule
