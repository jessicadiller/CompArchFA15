vlog -reportprogress 300 -work work adder.v
vsim -voptargs="+acc" testAdder

add wave -position insertpoint  \
sim:/testAdder/a \
sim:/testAdder/b \
sim:/testAdder/carryin \
sim:/testAdder/carryout \
sim:/testAdder/sum 
run -all
wave zoom full