simSetSimulator "-vcssv" -exec "/home/aedu16/project_fifo_uvm/build/simv" -args \
           "-cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1 +UVM_VERBOSITY=UVM_HIGH"
debImport "-abdir" "./build/simv.daidir" "-dbdir" \
          "/home/aedu16/project_fifo_uvm/build/simv.daidir"
debLoadSimResult /home/aedu16/project_fifo_uvm/wave.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_fifo_uvm.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvRenameGroup -win $_nWave2 {G1} {dut}
wvAddSignal -win $_nWave2 "/tb_fifo_uvm/dut/clk" "/tb_fifo_uvm/dut/rst_n" \
           "/tb_fifo_uvm/dut/wdata\[7:0\]" "/tb_fifo_uvm/dut/push" \
           "/tb_fifo_uvm/dut/pop" "/tb_fifo_uvm/dut/full" \
           "/tb_fifo_uvm/dut/empty" "/tb_fifo_uvm/dut/rdata\[7:0\]"
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 8)}
wvSetPosition -win $_nWave2 {("dut" 8)}
wvZoomAll -win $_nWave2
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 73079765.352697 -snap {("dut" 3)}
wvSetCursor -win $_nWave2 29119906.500692 -snap {("dut" 5)}
wvScrollDown -win $_nWave2 0
srcHBSelect "tb_fifo_uvm.dut" -win $_nTrace1
srcSetScope "tb_fifo_uvm.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_fifo_uvm.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_fifo_uvm.f_if" -win $_nTrace1
srcSetScope "tb_fifo_uvm.f_if" -delim "." -win $_nTrace1
srcHBSelect "tb_fifo_uvm.f_if" -win $_nTrace1
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
verdiDockWidgetHide -dock widgetDock_<Watch>
srcTBSetHiddenView -view WatchView
srcTBRunSim
wvZoomAll -win $_nWave2
srcHBSelect "uvm_custom_install_recording" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "uvm_custom_install_recording" -win $_nTrace1
srcSetScope "uvm_custom_install_recording" -delim "." -win $_nTrace1
srcHBSelect "uvm_custom_install_recording" -win $_nTrace1
srcHBSelect "tb_fifo_uvm.f_if.mon_mb" -win $_nTrace1
srcSetScope "tb_fifo_uvm.f_if.mon_mb" -delim "." -win $_nTrace1
srcHBSelect "tb_fifo_uvm.f_if.mon_mb" -win $_nTrace1
srcHBSelect "tb_fifo_uvm.f_if.drv_mb" -win $_nTrace1
srcSetScope "tb_fifo_uvm.f_if.drv_mb" -delim "." -win $_nTrace1
srcHBSelect "tb_fifo_uvm.f_if.drv_mb" -win $_nTrace1
srcHBSelect "tb_fifo_uvm.f_if" -win $_nTrace1
srcSetScope "tb_fifo_uvm.f_if" -delim "." -win $_nTrace1
srcHBSelect "tb_fifo_uvm.f_if" -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSelect -win $_nTrace1 -range {330 330 1 6 1 1}
srcTBSetActiveScope -file "./tb/tb_fifo_uvm_ver2.sv" -line 329 -offset 0
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -word -line 329 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 7)}
wvAddSignal -win $_nWave2 \
           "\$object_root/uvm_pkg/uvm_root/uvm_root@1/fifo_reg/delete\(\);
"
wvDumpScope "fifo_test.fifo_env.fifo_cov.fifo_reg" "fifo_test.fifo_env.fifo_cov"
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSetPosition -win $_nWave2 {("dut/fifo_reg" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {fifo_reg}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -word -line 329 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "fifo_reg" -line 229 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut/fifo_reg" 0)}
wvSetPosition -win $_nWave2 {("dut" 9)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 9)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("dut" 9)}
wvSetPosition -win $_nWave2 {("dut/fifo_reg" 0)}
wvSetPosition -win $_nWave2 {("dut" 7)}
wvSetPosition -win $_nWave2 {("dut" 6)}
wvSetPosition -win $_nWave2 {("dut" 5)}
wvSetPosition -win $_nWave2 {("dut" 4)}
wvSetPosition -win $_nWave2 {("dut" 3)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvAddSignal -win $_nWave2 "\$object_root/uvm_pkg/uvm_root/uvm_root@1/fifo_reg"
wvDumpScope "fifo_test.fifo_env.fifo_cov.fifo_reg"
wvAddSignal -win $_nWave2 "fifo_test/fifo_env/fifo_cov/fifo_reg"
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut/fifo_reg#1" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {fifo_reg#1}
debExit
