module traffic_light (
	input			clk, rst,
	input			ta, tb,
	input			M
	output	[1:0]	la, lb
);

	reg		[1:0]	la;
	reg		[1:0]	lb;

	reg		[1:0]	cstate;
	reg		[1:0]   nstate;

	parameter	RED	= 2'b11;
	parameter	YELLOW = 2'b01;
	parameter	GREEN = 2'b00;

	parameter	S0 = 2'b00;
	parameter	S1 = 2'b01;
	parameter	S2 = 2'b10;
	parameter	S3 = 2'b11;

	always @(posedge clk) begin
		if(!rst) begin
			cstate	<= S0;
		end else begin
			cstate <= nstate;
		end
	end

	always @(*) begin
		case(cstate)
			S0 : begin
				if(ta) begin
					nstate = S0;
				end else begin
					nstate = S1;
				end
			end

			S1 : begin
				nstate	= S2;
			end
			S2 : begin
				if(M | tb)begin
					nstate = S2;
				end else begin
					nstate = S3;
				end
			end
			S3 : begin
				nstate = S0;
			end
		endcase

	end

	always @(*) begin
		case(cstate)
			S0 : la = GREEN;
			S1 : la = YELLOW;
			S2 : la = RED;
			S3 : la = RED;
		endcase
	end

	always @(*) begin
		case(cstate)
			S0 : lb = RED;
			S1 : lb = RED;
			S2 : lb = GREEN;
			S3 : lb = YELLOW;
		endcase
	end

endmodule

module mode_FSM(
	input P, 
	input R, 
	input mode_rstn,
	input mode_clk,
	output reg mode_M
);

	reg  [1:0] mode_cstate;
	reg  [1:0] mode_nstate;

	parameter S0 = 2'b00;
	parameter S1 = 2'b01;

	always @(posedge mode_clk or negedge mode_rstn) begin 
		if(!mode_rstn) begin 
			mode_cstate <= S0;
		end else begin 
			mode_cstate <= mode_nstate;
		end 
	end 

// next state logic
	always @(*) begin 
		case (mode_cstate)
			S0 : begin 
				if(P) begin    // p=1
					mode_nstate = S1;
				end else begin // p=0
					mode_nstate = S0;
				end
			end
			S1 : begin 
				if(R) begin  // R=1
					mode_nstate = S0;
				end else begin // R=0
					mode_nstate = S1;
				end 
			end 
		endcase 
	end 

// output state logic 	 
	always @(*) begin 
		case (mode_cstate)
			S0 : mode_M = 0;
			S1 : mode_M = 1; 
		endcase
	end 
endmodule

module traffic_light_controller(
	input c_p,
	input c_r,
	input c_TA,
	input c_TB,
	input c_clk,
	input c_rstn,

	output [1:0] c_LA,
	output [1:0] c_LB

);

	reg TA;
	reg TB; 
	reg lights_M;
	reg lights_rstn;
	reg lights_clk;
	wire  [1:0] LB;
	wire  [1:0] LA;

	reg P; 
	reg R; 
	reg mode_rstn;
	reg mode_clk;
	wire mode_M;

	mode_FSM
	u_mode_FSM(
		.P					(c_p				),
		.R					(c_r				),
		.mode_rstn			(c_rstn				),
		.mode_clk			(c_clk				),
		.mode_M				(mode_M				)
	);

	traffic_light
	u_traffic_light(
		.ta					(c_TA				),
		.tb					(c_TB				),
		.M					(mode_M	     		),
		.rst				(c_rstn				),
		.clk				(c_clk				),
		.lb					(c_LB				),
		.la					(c_LA				)
	);

	endmodule


	
