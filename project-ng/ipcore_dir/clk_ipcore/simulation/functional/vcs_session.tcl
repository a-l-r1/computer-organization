gui_open_window Wave
gui_sg_create clk_ipcore_group
gui_list_add_group -id Wave.1 {clk_ipcore_group}
gui_sg_addsignal -group clk_ipcore_group {clk_ipcore_tb.test_phase}
gui_set_radix -radix {ascii} -signals {clk_ipcore_tb.test_phase}
gui_sg_addsignal -group clk_ipcore_group {{Input_clocks}} -divider
gui_sg_addsignal -group clk_ipcore_group {clk_ipcore_tb.CLK_IN1}
gui_sg_addsignal -group clk_ipcore_group {{Output_clocks}} -divider
gui_sg_addsignal -group clk_ipcore_group {clk_ipcore_tb.dut.clk}
gui_list_expand -id Wave.1 clk_ipcore_tb.dut.clk
gui_sg_addsignal -group clk_ipcore_group {{Status_control}} -divider
gui_sg_addsignal -group clk_ipcore_group {clk_ipcore_tb.RESET}
gui_sg_addsignal -group clk_ipcore_group {{Counters}} -divider
gui_sg_addsignal -group clk_ipcore_group {clk_ipcore_tb.COUNT}
gui_sg_addsignal -group clk_ipcore_group {clk_ipcore_tb.dut.counter}
gui_list_expand -id Wave.1 clk_ipcore_tb.dut.counter
gui_zoom -window Wave.1 -full
