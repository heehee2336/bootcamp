simSetSimulator "-vcssv" -exec \
           "/home/aedu16/0901_dedicated_counter_cpu/build/simv" -args \
           "-cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1 +UVM_VERBOSITY=UVM_HIGH"
debImport "-abdir" "./build/simv.daidir" "-dbdir" \
          "/home/aedu16/0901_dedicated_counter_cpu/build/simv.daidir"
debLoadSimResult /home/aedu16/0901_dedicated_counter_cpu/wave.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "0" "0" "900" "700"
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_dedicated_counter_cpu.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvRenameGroup -win $_nWave2 {G1} {dut}
wvAddSignal -win $_nWave2 "/tb_dedicated_counter_cpu/dut/clk" \
           "/tb_dedicated_counter_cpu/dut/rst_n" \
           "/tb_dedicated_counter_cpu/dut/out\[3:0\]"
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 3)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 51296.265560 -snap {("dut" 1)}
wvZoomAll -win $_nWave2
wvZoomAll -win $_nWave2
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_dedicated_counter_cpu" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_dedicated_counter_cpu.dut" -win $_nTrace1
srcHBSelect "tb_dedicated_counter_cpu.dut" -win $_nTrace1
srcSetScope "tb_dedicated_counter_cpu.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_dedicated_counter_cpu.dut" -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {47 47 5 6 1 1}
srcDeselectAll -win $_nTrace1
srcSelect -signal "lte10" -line 8 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/tb_dedicated_counter_cpu/dut/lte10"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "out_control" -line 8 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "asrcsel" -line 8 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "load" -line 8 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "out_control" -line 8 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "lte10" -line 8 -pos 1 -win $_nTrace1
wvSelectSignal -win $_nWave2 {( "dut" 3 )} 
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 128953.112033 -snap {("dut" 0)}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -win $_nWave2
wvZoom -win $_nWave2 27073.029046 465228.630705
wvSetCursor -win $_nWave2 375537.027599 -snap {("dut" 3)}
debExit
