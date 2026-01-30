`timescale 1ns / 1ps


module multi_spike_mod
    #(parameter WIDTH = 1,
      parameter LENGTH = 12,
      parameter MAX_SPIKES = 16)  // Maximum spikes per sample period
(
    input logic clk,
    input logic rst,
    input logic [LENGTH-1:0] data_in [WIDTH],
    input logic [15:0] divider,
    output logic spikeP [WIDTH],
    output logic spikeN [WIDTH]  // unused in this encoding
);

    assign spikeN = '{default: 0};  // Not used in multi-spike encoding

    // Generate sample clock
    logic sample_clk;
    logic [15:0] sample_cnt;
    
    always_ff @(posedge clk) begin
        sample_cnt <= sample_cnt + 1;
        if (sample_cnt >= divider) begin
            sample_cnt <= 0;
            sample_clk <= ~sample_clk;
        end
        if (rst) begin
            sample_cnt <= 0;
            sample_clk <= 0;
        end
    end

    // Multi-spike encoding logic
    // Calculate number of spikes based on input magnitude
    logic [$clog2(MAX_SPIKES+1)-1:0] num_spikes [WIDTH];
    logic [$clog2(MAX_SPIKES+1)-1:0] spike_count [WIDTH];
    logic [15:0] spike_interval [WIDTH];  // Clocks between spikes
    logic [15:0] interval_counter [WIDTH];
    
    // Calculate spikes and interval at start of each sample period
    always_ff @(posedge sample_clk) begin
        if (rst) begin
            num_spikes <= '{default: 0};
            spike_count <= '{default: 0};
            spike_interval <= '{default: 0};
            interval_counter <= '{default: 0};
        end else begin
            for (int i = 0; i < WIDTH; i++) begin
                // Scale input to number of spikes (0 to MAX_SPIKES)
                // num_spikes = (data_in * MAX_SPIKES) / (2^LENGTH - 1)
                num_spikes[i] <= (data_in[i] * MAX_SPIKES) >> LENGTH;
                
                // Calculate interval between spikes
                // Distribute spikes evenly across sample period
                if (data_in[i] == 0) begin
                    spike_interval[i] <= '1;  // Max value, no spikes
                end else begin
                    // interval = (2*divider) / num_spikes
                    spike_interval[i] <= (divider << 1) / ((data_in[i] * MAX_SPIKES) >> LENGTH);
                end
                
                // Reset counters
                spike_count[i] <= 0;
                interval_counter[i] <= 0;
            end
        end
    end

    // Generate spike train at calculated intervals
    always_ff @(posedge clk) begin
        if (rst) begin
            spikeP <= '{default: 0};
        end else begin
            for (int i = 0; i < WIDTH; i++) begin
                // Increment interval counter
                interval_counter[i] <= interval_counter[i] + 1;
                
                // Check if it's time for next spike
                if (spike_count[i] < num_spikes[i] && 
                    interval_counter[i] >= spike_interval[i]) begin
                    spikeP[i] <= 1;
                    spike_count[i] <= spike_count[i] + 1;
                    interval_counter[i] <= 0;
                end else begin
                    spikeP[i] <= 0;
                end
            end
        end
    end

endmodule