// Q) Design 16 x 16 bidirectional memory. Use gate primitive bufif1or bufif0todesign bidirectional data bus. 
      Use Tri-state buffer only at the dataoutputfrom the memory, it should not be present at data input to memory.


module bidirectional(data,data_out,addr,wr,rd,CLK,enable);
  inout [15:0] data;
  input wr,rd,CLK,enable;
  input [3:0] addr;
  output [15:0] data_out;
  wire [15:0] mem_out;
  wire ctrl;
  reg [15:0] data_in;
  
   // Control signal for the tri-state buffer
  assign ctrl = enable & rd;

  // Bidirectional data bus handling
  always @(*) begin
    if (wr && enable) begin
      data_in = data;
    end else begin
      data_in = 16'bz;
    end
	 end
  memory MEM(.IN(data_in),.addr(addr),.rd(rd),.wr(wr),.CLK(CLK),.OUT(mem_out));  // Instantiation
  bufif1 m1 (data_out,data_in,ctrl);    // Gate-level modeling
  
  assign data_out = enable ? mem_out : 16'bz;
 
endmodule  

module memory(IN,addr,rd,wr,CLK,OUT);
  input [15:0] IN;
  input [3:0] addr;
  input rd,wr,CLK;
  output reg [15:0] OUT;
  reg [15:0] mem [15:0];
  
  always @(posedge CLK) begin
   if (rd) begin
    OUT <= mem[addr];
	 end
	if (wr) begin
	 mem[addr] <= IN;
	end
	end
	
 endmodule
