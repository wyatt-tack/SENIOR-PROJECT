`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Wyatt Tack
//
// Create Date: 01/18/2026 6:15:50 PM
// Module Name: delta_mod_TB
// Target Devices: Basys3
// Description: delta modulation for spiked nueron encoder - Test Bench
//
// Revision:
// Revision 0.01 - File Created
/////////////////////////////////////////////////////////////////////////////


module delta_mod_TB();
logic clk = 0;
delta_mod UUT(.clk(clk), .divider(16'h0004));

always begin
#10
clk = clk ^ 1;


end

endmodule
