vlog -reportprogress 300 -work work SampleHold.t.v ADC.v shiftregister.v
vsim -voptargs="+acc" testSampleHold

add wave -position insertpoint \
sim:/testSampleHold/clk \
sim:/testSampleHold/analog_one \
sim:/testSampleHold/analog_two \
sim:/testSampleHold/channel \
sim:/testSampleHold/register_out \
sim:/testSampleHold/serialDataOut \
sim:/testSampleHold/serialDataIn \
sim:/testSampleHold/parallelLoad \
sim:/testSampleHold/peripheralClkEdge \
sim:/testSampleHold/restart \
sim:/testSampleHold/begintest \
sim:/testSampleHold/endtest 
run 2000

wave zoom full