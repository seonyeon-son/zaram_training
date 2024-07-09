`include "traffic_light.v"

`define CLKFREQ 50
`define SIMCYCLE 10

module traffic_light_tb;

	reg c_p;
	reg c_r;
	reg c_TA;
	reg c_TB;
	reg c_clk;
	reg c_rstn;
	wire [1:0] c_LA;
	wire [1:0] c_LB;

	traffic_light
	u_traffic_light(
		.c_p				(c_p				),
		.c_r				(c_r				),
		.c_TA				(c_TA				),
		.c_TB				(c_TB				),
		.c_clk				(c_clk				),
		.c_rstn				(c_rstn				),
		.c_LA				(c_LA				),
		.c_LB				(c_LB				)
	);


//-----------------------------------------
// Clock
//-----------------------------------------
	always #(500/`CLKFREQ) c_clk = ~c_clk;
//-----------------------------------------
// Tasks
//-----------------------------------------
	task init;
		begin 
			c_p = 0;
			c_r = 0;
            c_TA = 0;
            c_TB = 0;
            c_clk = 0;
            c_rstn = 0;
		end 
	endtask
//-----------------------------------------
// Test Stimulus 
//-----------------------------------------

	integer i;
	initial begin 
		init();
				@(posedge c_clk);
				#10;
				c_rstn = 1;

				c_p = 1'b1;
				c_TA = 1'b1;
				c_r = 1'b0;
				c_TB = 1'b0;
				
				@(posedge c_clk); 
				#10;
					
				c_p = 1'b0;
				c_TA = 1'b0;
				c_r = 1'b1;
				c_TB = 1'b1;
			
				@(posedge c_clk); 
				#10;
				
				c_p = 1'b1;
				c_TA = 1'b1;
				c_r = 1'b0;
				c_TB = 1'b0;
				
				@(posedge c_clk); 
				#10;
			
				c_p = 1'b0;
				c_TA = 1'b0;
				c_r = 1'b1;
				c_TB = 1'b1;
			
				@(posedge c_clk); 
				#10;
			$finish;
		end 
		
// ---------------------------------------------------
// Dump VCD
// ---------------------------------------------------

	reg [8*32-1:0] vcd_file;
	initial begin
		if($value$plusargs("vcd_file=%s", vcd_file)) begin
			$dumpfile(vcd_file);
			$dumpvars;
		end else begin 
			$dumpfile("traffic_light_tb.vcd");
			$dumpvars;
		end
	end
endmodule
