`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Ryken Thompson
//
// Create Date: 01/28/2026 10:30:00 PM
// Module Name: temporal_mod
// Target Devices: Basys3
// Description: temporal modulation for spiked nueron encoder
//
// Revision:
// Revision 0.01 - File Created
/////////////////////////////////////////////////////////////////////////////

module temporal_mod
      #(parameter WIDTH = 1,
        parameter LENGTH = 12)
(
    input clk, rst = 0,                        //hopefully at least 1.5MHz
    input [LENGTH-1:0]data_in [WIDTH],   
    input [15:0] divider = 2081,               //data frame size divider
    output logic spikeP [WIDTH],
    output logic spikeN [WIDTH]             
);

assign spikeN = '{default: 0}; //unused in temporal modulation

logic sample_clk = 0;
//logic for reference frame
//sample_clk (Hz) = clk (Hz)/(2+2*divider)
logic [15:0] sample_cnt = 0;
always_ff @(posedge clk) begin
    sample_cnt <= sample_cnt + 1;
    if (sample_cnt >= divider) begin
        sample_cnt <= 0;
        sample_clk <= sample_clk ^ 1;
    end
    if (rst) begin
        sample_cnt <=0;
        sample_clk <=0;
    end
end    
    
//-------------------temporal modulation logic--------------------

//Spike location calculator
//location = (data_in/datainmax)*4096, 0-4095 clks in each sampleframe
logic [11:0] spike_location [WIDTH];

//Generate logic in case of LENGTH != clkfreq/divider
generate
  for (genvar i = 0; i < WIDTH; i++) begin : g_loc
    if (LENGTH == 12)
      assign spike_location[i] = data_in[i];
    else if (LENGTH < 12)
      assign spike_location[i] = data_in[i] << (12 - LENGTH);
    else
      assign spike_location[i] = data_in[i] >> (LENGTH - 12);
  end
endgenerate


//Reset the spike counter at the beginning of each sample frame
logic [12:0] spike_counter [WIDTH];
always_ff @(posedge sample_clk) begin
    for(int i=0; i < WIDTH; i++)  begin
        spike_counter[i] <= 0; //Reset counter at beginning of sample frame
    end
end 

//Count clocks until spike location is reached; assert spikeP for 1 cycle on match
always_ff @(posedge clk) begin
    for (int i = 0; i < WIDTH; i++) begin
        spike_counter[i] <= spike_counter[i] + 1;
        spikeP[i] <= (spike_counter[i] == spike_location[i]);  // 1-cycle pulse when match
    end
end     
    
    
endmodule