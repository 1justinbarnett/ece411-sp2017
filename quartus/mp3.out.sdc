## Generated SDC file "mp3.out.sdc"

## Copyright (C) 1991-2014 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.1.4 Build 182 03/12/2014 SJ Full Version"

## DATE    "Sat Nov  5 21:40:15 2016"

##
## DEVICE  "EP3SE50F780C2"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {iClk} -period 10.000 -waveform { 0.000 5.000 } [get_ports {iClk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {iClk}] -rise_to [get_clocks {iClk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {iClk}] -fall_to [get_clocks {iClk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {iClk}] -rise_to [get_clocks {iClk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {iClk}] -fall_to [get_clocks {iClk}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iClk}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][0]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][1]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][2]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][3]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][4]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][5]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][6]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][7]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][8]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][9]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][10]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][11]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][12]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][13]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][14]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[0][15]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][0]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][1]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][2]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][3]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][4]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][5]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][6]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][7]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][8]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][9]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][10]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][11]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][12]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][13]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][14]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[1][15]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][0]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][1]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][2]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][3]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][4]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][5]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][6]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][7]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][8]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][9]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][10]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][11]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][12]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][13]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][14]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[2][15]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][0]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][1]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][2]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][3]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][4]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][5]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][6]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][7]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][8]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][9]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][10]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][11]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][12]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][13]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][14]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[3][15]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][0]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][1]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][2]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][3]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][4]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][5]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][6]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][7]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][8]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][9]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][10]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][11]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][12]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][13]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][14]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[4][15]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][0]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][1]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][2]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][3]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][4]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][5]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][6]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][7]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][8]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][9]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][10]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][11]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][12]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][13]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][14]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[5][15]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][0]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][1]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][2]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][3]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][4]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][5]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][6]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][7]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][8]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][9]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][10]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][11]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][12]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][13]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][14]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[6][15]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][0]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][1]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][2]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][3]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][4]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][5]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][6]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][7]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][8]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][9]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][10]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][11]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][12]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][13]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][14]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemRData[7][15]}]
set_input_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {iMemResp}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[0]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[1]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[2]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[3]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[4]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[5]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[6]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[7]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[8]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[9]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[10]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[11]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[12]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[13]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[14]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemAddr[15]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemRead}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][0]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][1]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][2]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][3]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][4]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][5]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][6]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][7]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][8]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][9]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][10]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][11]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][12]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][13]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][14]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[0][15]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][0]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][1]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][2]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][3]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][4]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][5]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][6]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][7]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][8]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][9]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][10]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][11]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][12]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][13]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][14]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[1][15]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][0]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][1]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][2]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][3]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][4]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][5]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][6]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][7]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][8]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][9]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][10]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][11]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][12]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][13]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][14]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[2][15]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][0]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][1]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][2]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][3]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][4]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][5]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][6]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][7]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][8]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][9]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][10]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][11]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][12]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][13]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][14]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[3][15]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][0]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][1]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][2]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][3]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][4]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][5]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][6]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][7]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][8]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][9]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][10]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][11]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][12]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][13]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][14]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[4][15]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][0]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][1]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][2]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][3]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][4]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][5]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][6]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][7]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][8]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][9]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][10]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][11]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][12]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][13]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][14]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[5][15]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][0]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][1]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][2]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][3]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][4]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][5]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][6]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][7]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][8]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][9]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][10]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][11]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][12]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][13]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][14]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[6][15]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][0]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][1]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][2]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][3]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][4]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][5]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][6]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][7]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][8]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][9]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][10]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][11]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][12]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][13]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][14]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWData[7][15]}]
set_output_delay -add_delay  -clock [get_clocks {iClk}]  0.000 [get_ports {oMemWrite}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

