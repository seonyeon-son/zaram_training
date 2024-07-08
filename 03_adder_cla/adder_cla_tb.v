`define CLKFREQ		100			// Clock Freq.
`define SIMCYCLE	`NVEC		//Sim. Cycles
`define	BW_DATA		32			// Bitwidth of ~~
`define	NVEC		10			// # of Test Vector

`include "adder_cla.v"

module adder_cla_tb;
// --------------------------------------------------
//		DUT Signals & Instantiate
// --------------------------------------------------
	reg [`BW_DATA-1:0]	A_i;
	reg [`BW_DATA-1:0]	B_i;
	reg					Cin;
	wire [`BW_DATA-1:0]	S_o;
	wire				Cout_o;

	adder_cla
	u_adder_cla(
		.A_i		(A_i		),
		.B_i		(B_i		),
		.Cin		(Cin		),
		.S_o		(S_o		),
		.Cout_o		(Cout_o		)
	);

// --------------------------------------------------
//	Test Vector Configuration
// --------------------------------------------------
	reg		[`BW_DATA-1:0]	vo_s[0:`NVEC-1];
	reg						vo_c[0:`NVEC-1];
	reg		[`BW_DATA-1:0]	vi_a[0:`NVEC-1];
	reg		[`BW_DATA-1:0]	vi_b[0:`NVEC-1];
	reg						vi_c[0:`NVEC-1];

	initial begin
		$readmemb("./vec/o_s.vec",			vo_s);
		$readmemb("./vec/o_c.vec",			vo_c);
		$readmemb("./vec/i_a.vec",			vi_a);
		$readmemb("./vec/i_b.vec",			vi_b);
		$readmemb("./vec/i_c.vec",			vi_c);
	end	

// --------------------------------------------------
//	Tasks
// --------------------------------------------------
	reg [4*32-1:0] 	taskState;
	reg 			err;

	task init;
		begin
			taskState	= "Init";
			err			= 0;
			A_i  		= 0;
			B_i  		= 0;
			Cin			= 0;
		end
	endtask

	task vecInsert;
		input	[$clog2(`NVEC)-1:0]	i;
		begin
			$sformat(taskState,	"VEC[%3d]", i);
			A_i				= vi_a[i];
			B_i				= vi_b[i];
			Cin				= vi_c[i];
		end
	endtask

	task vecVerify;
		input	[$clog2(`NVEC)-1:0]	i;
		begin
			#(0.1*1000/`CLKFREQ);
			if (S_o				!= vo_s[i]) begin $display("[Idx: %3d] Mismatched o_s", i); end
			if (Cout_o			!= vo_c[i]) begin $display("[Idx: %3d] Mismatched o_c", i); end
			if ((S_o != vo_s[i]) || (Cout_o != vo_c[i])) begin err++; end
			#(0.9*1000/`CLKFREQ);
		end
	endtask

// --------------------------------------------------
//	Test Stimulus
// --------------------------------------------------
	integer		i, j;
	initial begin
		init();
		for (i=0; i<`SIMCYCLE; i++) begin
			vecInsert(i);
			vecVerify(i);
		end
		#(1000/`CLKFREQ);
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
				$dumpfile("adder_cla_tb.vcd");
				$dumpvars;
			end
		end
	
	endmodule
