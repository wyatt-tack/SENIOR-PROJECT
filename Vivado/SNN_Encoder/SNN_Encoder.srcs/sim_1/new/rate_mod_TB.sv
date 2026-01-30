`timescale 1ns / 1ps

module rate_mod_TB
      #(parameter WIDTH = 2,
        parameter LENGTH = 12);
logic clk = 0;                      //hopefully at least 1.5MHz
logic [15:0] divider = 2081;        //data frame size divider                   
logic [LENGTH-1:0] data_in [WIDTH];   
logic spikeP [WIDTH];
logic spikeN [WIDTH];

rate_mod #(WIDTH, LENGTH) UUT(.clk(clk), .rst(1'b0), .divider(divider), 
                            .data_in(data_in), .spikeP(spikeP), .spikeN(spikeN));

//1.5MHz clk
always begin
#333
clk = clk ^ 1;
end

always begin
#2777778    //360Hz
data_in = {0,0};
#2777778    //360Hz
data_in = {2,4};
#2777778    //360Hz
data_in = {10,0};
#2777778    //360Hz
data_in = {11,6};
#2777778    //360Hz
data_in = {3,7};
#2777778    //360Hz
data_in = {2,1};
#2777778    //360Hz
data_in = {7,12};
end
endmodule