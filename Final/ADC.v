  module ADC
(
    input           	clk,           	// clock
    input		restart,		//when brought high the cycles restart
    input [9:0]		analog_one,
    input [9:0]		analog_two,
    input		channel,
    output reg [9:0] 	register_out    // 10 bits stored in register
);

reg [9:0] analog_in;
parameter counterwidth=10; // Counter size
reg[counterwidth-1:0] counter=0; //?? bit bus

always @(posedge clk) begin
	//input mux
	if (channel==0) begin
		analog_in = analog_one;
	end
	if (channel==1) begin
		analog_in = analog_two;
	end
	//restart option
	if (restart==1 )begin
		register_out[9] <= 1;
		register_out[8:0] <= 0;
		counter <= 9;
	end
	//Sucessive Approximation Register and Logic
	else begin
		if (counter==0 ) begin 
			counter <= 9;
			//comparator logic here
			if (register_out[counter] > analog_in[counter]) begin
				register_out[counter] <= 0; //loads appropriate bit to register
			end
			if (register_out[counter] < analog_in[counter]) begin
				register_out[counter] <= 1; //loads appropriate bit to register
			end
		end
		else begin
			counter <= counter-1;
			if (register_out[counter] > analog_in[counter]) begin
				register_out[counter] <= 0;
			end
			if (register_out[counter] < analog_in[counter]) begin
				register_out[counter] <= 1;
			end
		end
	end
end

endmodule 


