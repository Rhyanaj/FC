//SlowClock.v
//Adapted from http://www.fpga4student.com/2017/09/seven-segment-led-display-controller-basys3-fpga.html
//Refreshes internal clock to create a frequency that powers the display

module SlowClock(
    input CLK,
    input reset,
    output [1:0]countout
);
reg [20:0] refresh_counter; 
// the first 19-bit for creating 190Hz refresh rate
// the other 2-bit for creating 4 LED-activating signals
// count        0    ->  1  ->  2  ->  3
// activates    LED1    LED2   LED3   LED4
// and repeat
always @(posedge CLK)
begin 
 if(reset==1)
  refresh_counter <= 0;
 else
  refresh_counter <= refresh_counter + 1;
end 
assign countout = refresh_counter[20:19];
endmodule