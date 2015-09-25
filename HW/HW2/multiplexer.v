
module behavioralMultiplexer(out, address0,address1, in0,in1,in2,in3);
//behavioral module written by professor
output out;
input address0, address1;
input in0, in1, in2, in3;
wire[3:0] inputs = {in3, in2, in1, in0};
wire[1:0] address = {address1, address0};
assign out = inputs[address];
endmodule

module structuralMultiplexer(out, address0,address1, in0,in1,in2,in3);
// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50
//initialize inputs, outputs, and wires in between
output out;
input address0, address1;
input in0, in1, in2, in3;
  wire naddress0;
  wire naddress1;
  wire nA0andnA1;
  wire A0andnA1;
  wire nA0andA1;
  wire A0andA1;
  `NOT address0inv(naddress0, address0); //not gate for address 0
  `NOT address1inv(naddress1, address1); //not gate for address 1
  `AND andgate0(nA0andnA1, naddress0, naddress1, in0); //and gate for naddress0, naddress1, in0 with output nA0andnA1
  `AND andgate1(A0andnA1, address0, naddress1, in1); //and gate for address0, naddress1, in1 with output A0andnA1
  `AND andgate2(nA0andA1, naddress0, address1, in2);//and gate for naddress0, address1, in2 with output nA0andA1
  `AND andgate3(A0andA1, address0, address1, in3); //and gate for address0, address1, in0 with output A0andA1
  `OR orgate(out, nA0andnA1, A0andnA1, nA0andA1, A0andA1); //or gate for nA0andA1, A0andnA1, nA0andA1, A0andA1 with output out
endmodule


module testMultiplexer; 
//initialize inputs and outputs
reg address0,address1;
reg in0,in1,in2,in3;
wire out;
//behavioralMultiplexer multiplexer (out, address0,address1, in0,in1,in2,in3);
structuralMultiplexer multiplexer (out, address0, address1, in0, in1, in2, in3); // Swap after testing
//display the truth table and input-dependents results
initial begin
$display("A1 A0 | in0 in1 in2 in3 | out | Expected Output");
address0=0;address1=0; in0=0;in1=0;in2=0;in3=0; #200
$display(" %b  %b |  %b   %b   %b   %b  |  %b  |  False", address1, address0, in0, in1, in2, in3, out);
address0=0;address1=0; in0=1;in1=0;in2=0;in3=0; #200
$display(" %b  %b |  %b   %b   %b   %b  |  %b  |  True", address1, address0, in0, in1, in2, in3, out);
address0=1;address1=0; in0=0;in1=0;in2=0;in3=0; #200
$display(" %b  %b |  %b   %b   %b   %b  |  %b  |  False", address1, address0, in0, in1, in2, in3, out);
address0=1;address1=0; in0=0;in1=1;in2=0;in3=0; #200
$display(" %b  %b |  %b   %b   %b   %b  |  %b  |  True", address1, address0, in0, in1, in2, in3, out);
address0=0;address1=1; in0=0;in1=0;in2=0;in3=0; #200
$display(" %b  %b |  %b   %b   %b   %b  |  %b  |  False", address1, address0, in0, in1, in2, in3, out);
address0=0;address1=1; in0=0;in1=0;in2=1;in3=0; #200
$display(" %b  %b |  %b   %b   %b   %b  |  %b  |  True", address1, address0, in0, in1, in2, in3, out);
address0=1;address1=1; in0=0;in1=0;in2=0;in3=0; #200
$display(" %b  %b |  %b   %b   %b   %b  |  %b  |  False", address1, address0, in0, in1, in2, in3, out);
address0=1;address1=1; in0=0;in1=0;in2=0;in3=1; #200
$display(" %b  %b |  %b   %b   %b   %b  |  %b  |  True", address1, address0, in0, in1, in2, in3, out);
end

endmodule
