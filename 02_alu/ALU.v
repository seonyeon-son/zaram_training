
module ALU
#(
	parameter	N = 32
)
(
	input		[31:0] 	A,
	input		[31:0]	B,
	input		[2:0]	F,
	output reg	C_out,
	output reg	[31:0]	ALU_op
);

always@ (*) begin
	case (F)
		3'b000 : ALU_op 		 = A & B;
		3'b001 : ALU_op 		 = A | B;
		3'b010 : {C_out, ALU_op} = A + B;
		3'b011 : ALU_op 		 = 0;
		3'b100 : ALU_op 		 = A & ~B;
		3'b101 : ALU_op 		 = A | ~B;
		3'b110 : ALU_op 		 = A - B;
		3'b111 : ALU_op 		 = (A > B) ? 0 : 1;

	endcase
end

endmodule



