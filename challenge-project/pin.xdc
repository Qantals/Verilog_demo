##clk PL 50MCLK
set_property PACKAGE_PIN U18 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
##RSTn PL Key1
set_property PACKAGE_PIN N15 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

##ioPin   J11bank
set_property PACKAGE_PIN F17 [get_ports tx]
set_property PACKAGE_PIN F16 [get_ports rx]
set_property PACKAGE_PIN M14 [get_ports full_n]
set_property PACKAGE_PIN M15 [get_ports empty_n]

set_property IOSTANDARD LVCMOS33 [get_ports tx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports full_n]
set_property IOSTANDARD LVCMOS33 [get_ports empty_n]
