`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
// Engineer: Jack
/////////////////////////////////////////////////////////////////////////////

module rate_mod
    #(parameter WIDTH = 1,
      parameter LENGTH = 12)
(
    input logic clk,
    input logic rst,
    input logic [LENGTH-1:0] data_in [WIDTH],
    input logic [15:0] divider,
    output logic spikeP [WIDTH],
    output logic spikeN [WIDTH]  // unused
);

    // generate sample clock (same as delta_mod)
    logic sample_clk;
    logic [15:0] sample_cnt;
    
    always_ff @(posedge clk) begin
        sample_cnt <= sample_cnt + 1;
        if (sample_cnt >= divider) begin
            sample_cnt <= 0;
            sample_clk <= sample_clk ^ 1;
        end
        if (rst) begin
            sample_cnt <= 0;
            sample_clk <= 0;
        end
    end

    // rate encoding logic
    logic [LENGTH-1:0] rate_counter [WIDTH];
    logic [LENGTH-1:0] threshold [WIDTH];
    
    always_ff @(posedge sample_clk) begin
        if (rst) begin
            rate_counter <= '{default: 0};
            threshold <= '{default: 0};
            spikeP <= '{default: 0};
            spikeN <= '{default: 0};
        end else begin
            for (int i = 0; i < WIDTH; i++) begin
                // store current data as threshold
                threshold[i] <= data_in[i];
                
                // increment counter
                rate_counter[i] <= rate_counter[i] + 1;
                
                // fire spike when counter exceeds inverse of input
                // higher input = lower threshold = more frequent spikes
                if (rate_counter[i] >= ((2**LENGTH - 1) - data_in[i])) begin
                    spikeP[i] <= 1;
                    rate_counter[i] <= 0;
                end else begin
                    spikeP[i] <= 0;
                end
                
                spikeN[i] <= 0;  // not used in rate encoding
            end
        end
    end

    // clear spikes after 1CC
    always_ff @(posedge clk) begin
        for (int i = 0; i < WIDTH; i++) begin
            if (spikeN[i]) spikeN[i] <= 0;
            if (spikeP[i]) spikeP[i] <= 0;
        end
    end

endmodule