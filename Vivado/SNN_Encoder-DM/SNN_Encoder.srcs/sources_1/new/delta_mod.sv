`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Wyatt Tack
//
// Create Date: 01/18/2026 6:15:50 PM
// Module Name: delta_mod
// Target Devices: Basys3
// Description: delta modulation for spiked nueron encoder
//
// Revision:
// Revision 0.01 - File Created
/////////////////////////////////////////////////////////////////////////////

module delta_mod
      #(parameter WIDTH = 1,
        parameter LENGTH = 12,
        parameter JUMP = 5)
(
input clk, rst = 0,                        //hopefully at least 1.5MHz
input [LENGTH-1:0]data_in [WIDTH],   
input [15:0] divider = 2081,               //data frame size divider
output logic spikeP [WIDTH],
output logic spikeN [WIDTH]
    );
    
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
    
//-------------------delta modulation logic--------------------
//jump calculator
logic [LENGTH-1:0] previous [WIDTH] = '{default: 0};

//generate spike flags
always_ff @(posedge sample_clk) begin
    previous <= data_in;
    
    for(int i=0; i < WIDTH; i++)  begin
        if (($signed(previous[i]) - $signed(data_in[i])) > $signed(JUMP))
            spikeN[i] <= 1;
        if (($signed(data_in[i]) - $signed(previous[i])) > $signed(JUMP))
            spikeP[i] <= 1;
    end
end    


//clear spikes after 1CC
always_ff @ (posedge clk) begin
    for(int i=0; i < WIDTH; i++)  begin
        if (spikeN[i]) spikeN[i] <= 0;
        if (spikeP[i]) spikeP[i] <= 0;
        spikeP <= '{default: 0};
        spikeN <= '{default: 0};
    end
end     
    
    
endmodule
