simSetSimulator "-vcssv" -exec "/home/aedu16/0901_dedicated_cpu/build/simv" -args \
           "-cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1 +UVM_VERBOSITY=UVM_HIGH"
debImport "-abdir" "./build/simv.daidir" "-dbdir" \
          "/home/aedu16/0901_dedicated_cpu/build/simv.daidir"
debLoadSimResult /home/aedu16/0901_dedicated_cpu/wave.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "0" "0" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_dedicated_cpu.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvRenameGroup -win $_nWave2 {G1} {dut}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/clk" \
           "/tb_dedicated_cpu/dut/rst_n" "/tb_dedicated_cpu/dut/out\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvZoomAll -win $_nWave2
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 323451.452282 -snap {("dut" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "out" -line 11 -pos 2 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_dedicated_cpu.dut" -win $_nTrace1
srcSetScope "tb_dedicated_cpu.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_dedicated_cpu.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcGotoLine 66 -setActive -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "c_state" -line 53 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_CONTROL_UNIT/c_state\[2:0\]"
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetCursor -win $_nWave2 136077.593361 -snap {("dut" 4)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 324163.900415 -snap {("dut" 4)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 375269.709544 -snap {("dut" 2)}
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 376885.062241 -snap {("dut" 3)}
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcGotoLine 87 -setActive -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "rega_out" -line 105 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/rega_out\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetCursor -win $_nWave2 306352.697095 -snap {("dut" 4)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 377597.510373 -snap {("dut" 4)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "sum_in" -line 118 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSelect -win $_nTrace1 -range {118 122 5 4 4 7}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "alu_result" -line 132 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "alu_result" -line 132 -pos 2 -win $_nTrace1
srcSelect -win $_nTrace1 -range {132 136 5 6 6 1}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "alu_result" -line 132 -pos 2 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 3)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/alu_result\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetCursor -win $_nWave2 301365.560166 -snap {("dut" 4)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 71244.813278 -snap {("dut" 4)}
wvSetCursor -win $_nWave2 91905.809129 -snap {("dut" 4)}
wvSelectSignal -win $_nWave2 {( "dut" 4 5 )} 
wvSelectSignal -win $_nWave2 {( "dut" 4 5 )} 
wvSetRadix -win $_nWave2 -format UDec
wvSetCursor -win $_nWave2 342687.551867 -snap {("dut" 4)}
wvSetCursor -win $_nWave2 306352.697095 -snap {("dut" 4)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 314782.157676 -snap {("dut" 4)}
wvSetCursor -win $_nWave2 283039.419087 -snap {("dut" 4)}
wvSetCursor -win $_nWave2 314782.157676 -snap {("dut" 4)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomAll -win $_nWave2
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 304215.352697 331288.381743
wvZoom -win $_nWave2 313876.267626 316122.992028
wvZoom -win $_nWave2 314926.603515 315078.871144
wvZoomAll -win $_nWave2
wvSetCursor -win $_nWave2 324163.900415 -snap {("dut" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "lt10" -line 137 -pos 2 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "rega_out" -line 136 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "out" -line 91 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 3)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/out\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetCursor -win $_nWave2 366910.788382 -snap {("dut" 4)}
verdiSetActWin -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "dut" 3 )} 
wvSelectSignal -win $_nWave2 {( "dut" 3 )} 
wvSetRadix -win $_nWave2 -format UDec
wvSelectSignal -win $_nWave2 {( "dut" 4 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSelectGroup -win $_nWave2 {G2}
verdiDockWidgetMaximize -dock windowDock_nWave_2
wvSetCursor -win $_nWave2 313642.509442 -snap {("dut" 4)}
wvSetCursor -win $_nWave2 324234.158624 -snap {("dut" 3)}
wvSetCursor -win $_nWave2 325531.095258 -snap {("dut" 3)}
wvSetCursor -win $_nWave2 9943.180864 -snap {("dut" 2)}
wvSelectSignal -win $_nWave2 {( "dut" 6 )} 
verdiWindowResize -win $_Verdi_1 "456" "206" "900" "700"
verdiDockWidgetRestore -dock windowDock_nWave_2
wvSelectSignal -win $_nWave2 {( "dut" 3 )} 
wvSelectSignal -win $_nWave2 {( "dut" 4 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSelectSignal -win $_nWave2 {( "dut" 4 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSelectSignal -win $_nWave2 {( "dut" 4 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSelectGroup -win $_nWave2 {G2}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "rega_out" -line 105 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/rega_out\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "sum_out" -line 119 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/sum_out\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "dut" 5 )} 
wvSetRadix -win $_nWave2 -format UDec
srcDeselectAll -win $_nTrace1
srcSelect -signal "alu_result" -line 132 -pos 2 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/alu_result\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "lt10" -line 137 -pos 2 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/lt10"
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSetCursor -win $_nWave2 305647.341134 -snap {("dut" 7)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 3890.843098 -snap {("dut" 7)}
wvSetCursor -win $_nWave2 12537.161093 -snap {("dut" 7)}
wvSetCursor -win $_nWave2 304782.709335 -snap {("dut" 7)}
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiDockWidgetMaximize -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 364009.987603 -snap {("dut" 3)}
wvSetCursor -win $_nWave2 304566.551385 -snap {("dut" 7)}
wvSelectGroup -win $_nWave2 {G2}
wvSelectGroup -win $_nWave2 {G2}
wvZoom -win $_nWave2 174777.848912 182221.151751
wvZoomAll -win $_nWave2
verdiDockWidgetRestore -dock windowDock_nWave_2
wvSelectSignal -win $_nWave2 {( "dut" 6 )} 
wvSelectSignal -win $_nWave2 {( "dut" 7 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSelectSignal -win $_nWave2 {( "dut" 6 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSelectSignal -win $_nWave2 {( "dut" 5 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSelectSignal -win $_nWave2 {( "dut" 4 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -inst "U_ASRC_MUX" -line 93 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -signal "a_srcsel" -line 94 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/a_srcsel"
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "alu_result" -line 96 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/alu_result\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "asrc_in" -line 97 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/asrc_in\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSelectGroup -win $_nWave2 {G2}
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "a_load" -line 103 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/a_load"
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "a_load" -line 103 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "asrc_in" -line 104 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/asrc_in\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 7)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "rega_out" -line 105 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSetPosition -win $_nWave2 {("dut" 8)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 8)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/rega_out\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 8)}
wvSetPosition -win $_nWave2 {("dut" 9)}
wvSelectGroup -win $_nWave2 {G2}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 24892.496821 -snap {("dut" 5)}
srcHBSelect "tb_dedicated_cpu.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
schCreateWindow -delim "." -win $_nSchema1 -scope \
           "tb_dedicated_cpu.dut.U_DATAPATH"
verdiSetActWin -win $_nSchema_3
srcHBSelect "tb_dedicated_cpu" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
schCreateWindow -delim "." -win $_nSchema1 -scope \
           "tb_dedicated_cpu.dut.U_DATAPATH"
verdiSetActWin -win $_nSchema_4
srcHBSelect "tb_dedicated_cpu.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
schCreateWindow -delim "." -win $_nSchema1 -scope \
           "tb_dedicated_cpu.dut.U_DATAPATH"
verdiSetActWin -win $_nSchema_5
schCloseWindow -win $_nSchema4
schCloseWindow -win $_nSchema5
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiSetActWin -win $_nSchema_3
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_dedicated_cpu.dut.U_DATAPATH" -win $_nTrace1
srcSetScope "tb_dedicated_cpu.dut.U_DATAPATH" -delim "." -win $_nTrace1
srcHBSelect "tb_dedicated_cpu.dut.U_DATAPATH" -win $_nTrace1
srcHBSelect "tb_dedicated_cpu.dut.U_DATAPATH" -win $_nTrace1
srcHBSelect "tb_dedicated_cpu.dut" -win $_nTrace1
srcSetScope "tb_dedicated_cpu.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_dedicated_cpu.dut" -win $_nTrace1
schCreateWindow -delim "." -win $_nSchema1 -scope "tb_dedicated_cpu.dut"
verdiSetActWin -win $_nSchema_6
srcHBSelect "tb_dedicated_cpu.dut.U_CONTROL_UNIT" -win $_nTrace1
srcSetScope "tb_dedicated_cpu.dut.U_CONTROL_UNIT" -delim "." -win $_nTrace1
srcHBSelect "tb_dedicated_cpu.dut.U_CONTROL_UNIT" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
schCreateWindow -delim "." -win $_nSchema1 -scope \
           "tb_dedicated_cpu.dut.U_CONTROL_UNIT"
verdiSetActWin -win $_nSchema_7
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_nSchema_7
verdiDockWidgetSetCurTab -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSelectSignal -win $_nWave2 {( "dut" 9 )} 
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "dut" 4 5 6 7 8 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 4)}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcGotoLine 115 -setActive -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "sum_load" -line 117 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/sum_load"
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSelectSignal -win $_nWave2 {( "dut" 4 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 4)}
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "sum_in" -line 118 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/sum_in\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "sum_out" -line 119 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/sum_out\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "alu_srcsel" -line 123 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/alu_srcsel"
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 3)}
verdiSetActWin -win $_nWave2
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "sum_out" -line 125 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/sum_out\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSelectSignal -win $_nWave2 {( "dut" 7 )} 
verdiSetActWin -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSelectGroup -win $_nWave2 {G2}
wvSetCursor -win $_nWave2 35155.192878 -snap {("dut" 5)}
wvSetCursor -win $_nWave2 64196.439169 -snap {("dut" 5)}
wvSetCursor -win $_nWave2 94984.527342 -snap {("dut" 5)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "rega_out" -line 105 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvAddSignal -win $_nWave2 "/tb_dedicated_cpu/dut/U_DATAPATH/rega_out\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetCursor -win $_nWave2 56554.005935 -snap {("dut" 6)}
verdiSetActWin -win $_nWave2
wvZoomAll -win $_nWave2
wvSelectGroup -win $_nWave2 {G2}
wvZoomAll -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSelectSignal -win $_nWave2 {( "dut" 7 )} 
wvSetPosition -win $_nWave2 {("dut" 7)}
wvExpandBus -win $_nWave2
wvSelectSignal -win $_nWave2 {( "dut" 7 )} 
wvSetPosition -win $_nWave2 {("dut" 7)}
wvCollapseBus -win $_nWave2
wvSetPosition -win $_nWave2 {("dut" 7)}
wvZoomAll -win $_nWave2
debExit
