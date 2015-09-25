module behavioralDecoder(out0,out1,out2,out3, address0,address1, enable);
//behavioral module written by professor
output out0, out1, out2, out3;
input address0, address1;
input enable;
assign {out3,out2,out1,out0}=enable<<{address1,address0};
endmodule

module structuralDecoder(out0,out1,out2,out3, address0,address1, enable);
// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50
//initialize inputs, outputs, and wires in between
output out0, out1, out2, out3;
input address0, address1;
input enable;
  wire naddress0;
  wire naddress1;
  `NOT address0inv(naddress0, address0); //not gate for address 0
  `NOT address1inv(naddress1, address1); //not gate for address 1
  `AND andgate0(out0, naddress0, naddress1, enable); //and gate for not address 0, not address 1, and enable
  `AND andgate1(out1, address0, naddress1, enable); //and gate for address 0, not address 1, and enable
  `AND andgate2(out2, naddress0, address1, enable); //and gate for not address 0, address 1, and enable
  `AND andgate3(out3, address0, address1, enable); //and gate for address 0, address 1, and enable
endmodule

module testDecoder; 
//initialize inputs and outputs
reg addr0, addr1;
reg enable;
wire out0,out1,out2,out3;
// behavioralDecoder decoder (out0,out1,out2,out3,addr0,addr1,enable);
structuralDecoder decoder (out0,out1,out2,out3,addr0,addr1,enable); // Swap after testing
//display the truth table and input-dependents results
initial begin
$display("En A0 A1| O0 O1 O2 O3 | Expected Output");
enable=0;addr0=0;addr1=0; #100 
$display("%b  %b  %b |  %b  %b  %b  %b |    All false", enable, addr0, addr1, out0, out1, out2, out3);
enable=0;addr0=1;addr1=0; #100
$display("%b  %b  %b |  %b  %b  %b  %b |    All false", enable, addr0, addr1, out0, out1, out2, out3);
enable=0;addr0=0;addr1=1; #100 
$display("%b  %b  %b |  %b  %b  %b  %b |    All false", enable, addr0, addr1, out0, out1, out2, out3);
enable=0;addr0=1;addr1=1; #100 
$display("%b  %b  %b |  %b  %b  %b  %b |    All false", enable, addr0, addr1, out0, out1, out2, out3);
enable=1;addr0=0;addr1=0; #100 
$display("%b  %b  %b |  %b  %b  %b  %b |     O0 Only", enable, addr0, addr1, out0, out1, out2, out3);
enable=1;addr0=1;addr1=0; #100 
$display("%b  %b  %b |  %b  %b  %b  %b |     O1 Only", enable, addr0, addr1, out0, out1, out2, out3);
enable=1;addr0=0;addr1=1; #100
$display("%b  %b  %b |  %b  %b  %b  %b |     O2 Only", enable, addr0, addr1, out0, out1, out2, out3);
enable=1;addr0=1;addr1=1; #100 
$display("%b  %b  %b |  %b  %b  %b  %b |     O3 Only", enable, addr0, addr1, out0, out1, out2, out3);
end
endmodule
