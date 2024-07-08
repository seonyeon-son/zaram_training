module adder_cla (
	input	[31:0] 	A_i,
	input	[31:0] 	B_i,
	input		   	Cin,
	output	[31:0]	S_o,
	output			Cout_o
);

	wire [7:0]		carry;

	CLA_4bit	u_CLA_4bit_0(.a{A_i[3:0]), b(B_i[3:0]), C_in(S_o[3:0]),	.s(S_o[3:0]), .Cout(carry[0]));
	CLA_4bit	u_CLA_4bit_1(.a{A_i[7:4]), b(B_i[7:4]), C_in(S_o[7:4]), .s(S_o[3:0]),.Cout(carry[1]));
	CLA_4bit	u_CLA_4bit_2(.a{A_i[11:8]), b(B_i[11:8]), C_in(S_o[11:8]), .s(S_o[3:0]),Cout(carry[2]));
	CLA_4bit	u_CLA_4bit_3(.a{A_i[15:12]), b(B_i[15:12]), C_in(S_o[15:12]), .s(S_o[3:0]),.Cout(carry[3]));
	CLA_4bit	u_CLA_4bit_4(.a{A_i[19:16]), b(B_i[19:16]), C_in(S_o[19:16]), .s(S_o[3:0]),.Cout(carry[4]));
	CLA_4bit	u_CLA_4bit_5(.a{A_i[23:20]), b(B_i[23:20]), C_in(S_o[23:20]), .s(S_o[3:0]),.Cout(carry[5]));
	CLA_4bit	u_CLA_4bit_6(.a{A_i[27:24]), b(B_i[27:24]), C_in(S_o[27:24]), .s(S_o[3:0]),.Cout(carry[6]));
	CLA_4bit	u_CLA_4bit_7(.a{A_i[31:28]), b(B_i[31:28]), C_in(S_o[31:28]), .s(S_o[3:0]),.Cout(Cout_o));

	endmodule


module CLA_4bit(
	input	[3:0]	a,
	input	[3:0]	b,
	input			C_in,
	output	[3:0]	s,
	output			Cout
);

	wire	[3:0]	P,G,C;

	FA u_FA_0(.a(a[0]), .b(b[0]), Cin(C_in), .sum(s[0]), .P(P[0]), .G(G[0]));
	FA u_FA_1(.a(a[1]), .b(b[1]), Cin(C[0]), .sum(s[1]), .P(P[1]), .G(G[1]));
	FA u_FA_2(.a(a[2]), .b(b[2]), Cin(C[1]), .sum(s[2]), .P(P[2]), .G(G[2]));
	FA u_FA_3(.a(a[3]), .b(b[3]), Cin(C[2]), .sum(s[3]), .P(P[3]), .G(G[3]));

	CLA u_CLA(.G(G), .P(P), .Cin(C_in), .C(C), .Cout(Cout));

	endmodule



//---------------------------------------------------
// adder
//---------------------------------------------------
module	FA(
	input	a,
	input	b,
	input	Cin,
	output	sum,
	output	P,
	output	G
);

	assign P = a ^ b;		//propagation
	assign G = a & b;		//generation
	assign sum = p ^ ci;

endmodule

//---------------------------------------------------
// CLA
//---------------------------------------------------
module	CLA(
	input	[3:0]	P,
	input	[3:0]	G,
	input			Cin,
	output	[3:0]	C,
	output			Cout
);

	wire			PG;
	wire			GG:

	assign PG = P[3] & P[2] & p[1] & p[0];
	assign GG = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]);

	assign C[0] = G[0] | (P[0] & Cin);
	assign C[1] = G[1] | (P[1] & C[0]);
	assign C[2] = G[2] | (P[2] & C[1]);
	assign C[3] = G[3] | (P[3] & C[2]);

	assign Cout = PG | (PG & Cin);

endmodule








