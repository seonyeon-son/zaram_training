	module traffic_light
(
	output		[8*8-1 : 0]		l_a,
	output		[8*8-1 : 0]		l_b,
	input						p,
	input						r,
	input						t_a,
	input						t_b,
	input						clk,
	input						rstn
);

wire		mode;
reg	[1:0]	state;
wire		state_0;
wire		state_1;
wire		state_2;
wire		state_3;

assign	mode	=	(r)	? 0 :
					(p)	? 1 : 0;
assign	state_0	=	(state == 0) ? 1 : 0;
assign	state_1	=	(state == 1) ? 1 : 0;
assign	state_2	=	(state == 2) ? 1 : 0;
assign	state_3	=	(state == 3) ? 1 : 0;

assign	l_a	=	(state_0)	?	"GREEN"		:
				(state_1)	?	"YELLOW"	:
				(state_2)	?	"RED"		:
				(state_3)	?	"YELLOW"	:	"GREEN";

assign	l_b	=	(state_0)	?	"RED"		:
				(state_1)	?	"YELLOW"	:
				(state_2)	?	"GREEN"		:
				(state_3)	?	"YELLOW"	:	"RED";

always @(posedge clk or negedge rstn) begin
	if(!rstn) begin
		state	= 0;
	end else begin
		if (mode) begin
			state	<= 2;
		end else begin
			if(state_0 & t_a) begin
				state	<=	0;
			end else begin
				if(state_2 & t_b) begin
					state	<=	2;
				end else begin
					state	<=	state + 1;
				end
			end
		end
	end
end

endmodule
