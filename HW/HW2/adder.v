
module behavioralAdder(sum, carryout, a, b, carryin);
//behavioral module written by professor
output sum, carryout;
input a, b, carryin;
assign {carryout, sum}=a+b+carryin;
endmodule

module structuralAdder(sum, carryout, a, b, carryin);
// define gates with delays
`define AND and #50
`define OR or #50
`define XOR xor #50
//initialize inputs, outputs, and wires in between
output sum, carryout;
input a, b, carryin;
wire axnorb;
wire aandb;
wire axnorbandc;
`XOR xnorgate1 (axnorb, a, b); //xor gate for a, b with axnorb as output
`XOR xnorgate2 (sum, axnorb, carryin); //xor gate for axnorb, c with sum as output
`AND andgate1 (aandb, a, b);//and gate for a,b with aaandb as ouput
`AND andgate2 (axnorbandc, axnorb, c); //and gate for axnorb, c with axnorbandc as output
`OR orgate (carryout, aandb, axnorb); //or gate for aandb, axnorb with carryout as output
endmodule

module testAdder;
//initialize inputs and outputs
reg a, b, carryin;
wire sum, carryout;
//behavioralFullAdder adder (sum, carryout, a, b, carryin);
structuralAdder adder (sum, carryout, a, b, carryin); // Swap after testing
//display the truth table and input-dependents results
initial begin
  $display(" a  b  carryin | carryout  sum | Expected CarryOut | Expected Sum");
  a=0;b=0; carryin=0; #100
  $display(" %b  %b     %b    |    %b       %b  |       False       |       False", a, b, carryin, carryout, sum,);
  a=0;b=0; carryin=1; #100
  $display(" %b  %b     %b    |    %b       %b  |       False       |       True", a, b, carryin, carryout, sum,);
  a=0;b=1; carryin=0; #100
  $display(" %b  %b     %b    |    %b       %b  |       False       |       True", a, b, carryin, carryout, sum,);
  a=0;b=1; carryin=1; #100
  $display(" %b  %b     %b    |    %b       %b  |       True        |       False", a, b, carryin, carryout, sum,);
  a=1;b=0; carryin=0; #100
  $display(" %b  %b     %b    |    %b       %b  |       False       |       True", a, b, carryin, carryout, sum,);
  a=1;b=0; carryin=1; #100
  $display(" %b  %b     %b    |    %b       %b  |       True        |       False", a, b, carryin, carryout, sum,);
  a=1;b=1; carryin=0; #100
  $display(" %b  %b     %b    |    %b       %b  |       True        |       False", a, b, carryin, carryout, sum,);
  a=1;b=1; carryin=1; #100
  $display(" %b  %b     %b    |    %b       %b  |       True        |       True", a, b, carryin, carryout, sum,);
end
endmodule

