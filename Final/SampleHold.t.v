
module testSampleHold();

    wire clk;
    wire [9:0] analog_one;
    wire [9:0] analog_two;
    wire [9:0] register_out;
    wire channel;
    wire peripheralClkEdge;
    wire parallelLoad;
    wire [9:0] parallelDataIn;
    wire [9:0] parallelDataOut;
    wire serialDataOut;
    wire digital_result;
    wire restart;
    reg begintest;
    wire endtest;
    wire dutpassed;

    ADC digital (.clk(clk),
		.restart(restart),
		.analog_one(analog_one),
		.analog_two(analog_two),
		.channel(channel),
		.register_out(register_out)
		);

    shiftregister spi_out (.clk(clk),
		.peripheralClkEdge(peripheralClkEdge),
		.parallelLoad(parallelLoad),
		.parallelDataIn(register_out),
		.serialDataIn(serialDataIn),
		.parallelDataOut(parallelDataOut),
		.serialDataOut(serialDataOut)
		);

    SampleHoldTestBench tester(
	.begintest(begintest),
	.endtest(endtest),
	.dutpassed(dutpassed),
	.clk(clk),
	.analog_one(analog_one),
	.analog_two(analog_two),
	.channel(channel),
	.restart(restart),
	.register_out(register_out),
	.peripheralClkEdge(peripheralClkEdge),
	.parallelLoad(parallelLoad),
	.serialDataIn(serialDataIn),
	.serialDataOut(serialDataOut)
	);

initial begin 
	begintest = 0;
	#10;
	begintest = 1;
	#1000;
end

always @(posedge endtest) begin
	$display("DUT passed?: %b", dutpassed);
end

endmodule

module SampleHoldTestBench(
		input begintest,
		output reg endtest,
		output reg dutpassed,

		output reg clk,
		output reg [9:0] analog_one,
		output reg [9:0] analog_two,
		output reg channel,
		output reg restart,
		input [9:0] register_out,
		
		output reg peripheralClkEdge,
		output reg parallelLoad,
		output reg serialDataIn,
		//input [9:0] parallelDataOut,
		input serialDataOut
	);
    
// Generate clock (50MHz)
initial clk=0;
always #10 clk=!clk;    // 50MHz Clock

    always @(posedge begintest) begin
	//testing values
	endtest = 0;
	dutpassed =1;
	//sets all values to zero to have values
	peripheralClkEdge = 0;
	serialDataIn = 0;
	parallelLoad = 0;
	channel = 0;
	//restart is 1 so that it gives initial values to register_out for comparison
	restart = 1;
	//set analog_one to 11111111 and analog_two to 0000000
	analog_one[9] = 1;
	analog_one[8] = 1;
	analog_one[7] = 1;
	analog_one[6] = 1;
	analog_one[5] = 1;
	analog_one[4] = 1;
	analog_one[3] = 1;
	analog_one[2] = 1;
	analog_one[1] = 1;
	analog_one[0] = 1;
	analog_two[9] = 0;
	analog_two[8] = 0;
	analog_two[7] = 0;
	analog_two[6] = 0;
	analog_two[5] = 0;
	analog_two[4] = 0;
	analog_two[3] = 0;
	analog_two[2] = 0;
	analog_two[1] = 0;
	analog_two[0] = 0;
	#40
	//end restart so that loading to register one can happen
	restart = 0;
	#200
	//all correct values have been loaded into register_out
	//parallel load enable lets register_out bits into shift register
	parallelLoad = 1;
	#20
	parallelLoad = 0;
	//no more parallel load so that serial data out is started with peripheralclkedge
	peripheralClkEdge = 1;
	#100
	//new analog_one and _two values
	analog_one[9] = 0;
	analog_one[8] = 0;
	analog_one[7] = 0;
	analog_one[6] = 0;
	analog_one[5] = 0;
	analog_one[4] = 0;
	analog_one[3] = 0;
	analog_one[2] = 0;
	analog_one[1] = 0;
	analog_one[0] = 0;
	analog_two[9] = 1;
	analog_two[8] = 1;
	analog_two[7] = 1;
	analog_two[6] = 1;
	analog_two[5] = 1;
	analog_two[4] = 1;
	analog_two[3] = 1;
	analog_two[2] = 1;
	analog_two[1] = 1;
	analog_two[0] = 1;
	#200
	//all correct values have been loaded into register_out
	//parallel load enable lets register_out bits into shift register
	peripheralClkEdge = 0;
	parallelLoad = 1;
	#20
	parallelLoad = 0;
	//no more parallel load so that serial data out is started with peripheralclkedge
	peripheralClkEdge = 1;
	#100
	//new analog_one and _two values
	analog_one[9] = 1;
	analog_one[8] = 0;
	analog_one[7] = 1;
	analog_one[6] = 0;
	analog_one[5] = 1;
	analog_one[4] = 0;
	analog_one[3] = 1;
	analog_one[2] = 0;
	analog_one[1] = 1;
	analog_one[0] = 0;
	analog_two[9] = 1;
	analog_two[8] = 0;
	analog_two[7] = 1;
	analog_two[6] = 0;
	analog_two[5] = 1;
	analog_two[4] = 0;
	analog_two[3] = 1;
	analog_two[2] = 0;
	analog_two[1] = 1;
	analog_two[0] = 0;
	#200
	parallelLoad = 1;
	peripheralClkEdge = 0;
	#20
	parallelLoad = 0;
	peripheralClkEdge = 1;
	#100

	//now channel two is selected and the same tests are run 
	//should give opposite results as analog_one and _two are always opposite
	channel = 1;   	
	analog_one[9] = 1;
	analog_one[8] = 1;
	analog_one[7] = 1;
	analog_one[6] = 1;
	analog_one[5] = 1;
	analog_one[4] = 1;
	analog_one[3] = 1;
	analog_one[2] = 1;
	analog_one[1] = 1;
	analog_one[0] = 1;
	analog_two[9] = 0;
	analog_two[8] = 0;
	analog_two[7] = 0;
	analog_two[6] = 0;
	analog_two[5] = 0;
	analog_two[4] = 0;
	analog_two[3] = 0;
	analog_two[2] = 0;
	analog_two[1] = 0;
	analog_two[0] = 0;
	#200
	parallelLoad = 1;
	#20
	parallelLoad = 0;
	#100
	analog_one[9] = 0;
	analog_one[8] = 0;
	analog_one[7] = 0;
	analog_one[6] = 0;
	analog_one[5] = 0;
	analog_one[4] = 0;
	analog_one[3] = 0;
	analog_one[2] = 0;
	analog_one[1] = 0;
	analog_one[0] = 0;
	analog_two[9] = 1;
	analog_two[8] = 1;
	analog_two[7] = 1;
	analog_two[6] = 1;
	analog_two[5] = 1;
	analog_two[4] = 1;
	analog_two[3] = 1;
	analog_two[2] = 1;
	analog_two[1] = 1;
	analog_two[0] = 1;
	#200
	parallelLoad = 1;
	peripheralClkEdge = 0;
	#20
	parallelLoad = 0;
	peripheralClkEdge = 1;
	#100
	analog_one[9] = 1;
	analog_one[8] = 0;
	analog_one[7] = 1;
	analog_one[6] = 0;
	analog_one[5] = 1;
	analog_one[4] = 0;
	analog_one[3] = 1;
	analog_one[2] = 0;
	analog_one[1] = 1;
	analog_one[0] = 0;
	analog_two[9] = 1;
	analog_two[8] = 0;
	analog_two[7] = 1;
	analog_two[6] = 0;
	analog_two[5] = 1;
	analog_two[4] = 0;
	analog_two[3] = 1;
	analog_two[2] = 0;
	analog_two[1] = 1;
	analog_two[0] = 0;
	#200
	parallelLoad = 1;
	peripheralClkEdge = 0;
	#20
	parallelLoad = 0;
	peripheralClkEdge = 1;
	#100
	endtest = 1;
    end
endmodule
