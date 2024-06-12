module ALU(A, B, C, Borrow, Carry, Equal, Less, More);
  input [7:0] A, B;
  output reg [7:0] C;
  output reg Borrow, Carry, Equal, Less, More;
  
  always @*
    case({A,B})
      4'b0000 : C = A + B;
      4'b0001 : C = A - B;
      4'b0010 : C = A ^ B;
      4'b0011 : C = A & B;
      4'b0100 : C = ~(A | B);
      4'b0101 : C = ~(A & B);
      4'b0110 : C = A < B;
      4'b0111 : C = A > B;
      4'b1000 : C = (A == B); 
      default : C = 8'b00000000;
    endcase

  always @*
  begin 
    if (C > 8'b11111111)
      Carry = 1'b1;
    else 
      Carry = 1'b0;

    if (A < B)
      Borrow = 1'b1;
    else
      Borrow = 1'b0;

    if (A == B)
      Equal = 1'b1;
    else
      Equal = 1'b0;

    if (A < B)
      Less = 1'b1;
    else
      Less = 1'b0;

    if (A > B)
      More = 1'b1;
    else
      More = 1'b0;
  end
endmodule
