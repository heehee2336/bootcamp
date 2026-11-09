simSetSimulator "-vcssv" -exec \
           "/home/aedu16/bootcamp/bootcamp_cpu/0902_rv32i_cpu/build/simv" \
           -args
debImport "-abdir" "./build/simv.daidir" "-dbdir" \
          "/home/aedu16/bootcamp/bootcamp_cpu/0902_rv32i_cpu/build/simv.daidir"
debLoadSimResult /home/aedu16/bootcamp/bootcamp_cpu/0902_rv32i_cpu/wave.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
srcSetScope "tb_rv32i_cpu.dut" -delim "." -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvRenameGroup -win $_nWave2 {G1} {dut}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/clk" "/tb_rv32i_cpu/dut/rst_n"
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 2)}
srcHBSelect "tb_rv32i_cpu.dut.U_ROM" -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_DATA_MEM" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvRenameGroup -win $_nWave2 {G2} {U_DATA_MEM}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_DATA_MEM/clk" \
           "/tb_rv32i_cpu/dut/U_DATA_MEM/daddr\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_DATA_MEM/dwdata\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_DATA_MEM/dwe" \
           "/tb_rv32i_cpu/dut/U_DATA_MEM/itype\[2:0\]" \
           "/tb_rv32i_cpu/dut/U_DATA_MEM/drdata\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 6)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 6)}
wvZoomIn -win $_nWave2
verdiSetActWin -win $_nWave2
wvZoomAll -win $_nWave2
wvSelectGroup -win $_nWave2 {U_DATA_MEM}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
srcHBSelect "tb_rv32i_cpu.dut.U_ROM" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
wvRenameGroup -win $_nWave2 {G3} {U_ROM}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_ROM/instr_addr\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_ROM/instr_code\[31:0\]"
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
wvSetPosition -win $_nWave2 {("U_ROM" 2)}
wvSetPosition -win $_nWave2 {("U_ROM" 2)}
wvSelectGroup -win $_nWave2 {U_ROM}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {U_ROM}
wvZoom -win $_nWave2 242656.417489 649462.764457
wvSetCursor -win $_nWave2 375445.211244 -snap {("U_ROM" 2)}
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU" -win $_nTrace1
srcSetScope "tb_rv32i_cpu.dut.U_RV32I_CPU" -delim "." -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
wvSetPosition -win $_nWave2 {("U_ROM" 1)}
wvSetPosition -win $_nWave2 {("U_ROM" 2)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvRenameGroup -win $_nWave2 {G4} {U_CONTROL_UNIT}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/clk" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rst_n" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/pc_en" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rf_we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alusrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/dwe" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/itype\[2:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rfsrc_sel\[2:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/branch" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/jal" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/jalr"
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 13)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 13)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
verdiSetActWin -win $_nWave2
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvRenameGroup -win $_nWave2 {G5} {U_DATAPATH}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/clk" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/rst_n" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/rf_we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/rfsrc_sel\[2:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/alusrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/drdata\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/jal" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/jalr" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/branch" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/pc_en" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/instr_addr\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/daddr\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/dwdata\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 15)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 15)}
wvScrollUp -win $_nWave2 3
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "U_DATAPATH" 10 )} 
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 383885.176948 -snap {("U_DATAPATH" 9)}
wvSetCursor -win $_nWave2 416519.711007 -snap {("U_DATAPATH" 9)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcSetScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -delim "." -win \
           $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "c_state" -line 27 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("U_DATAPATH" 6)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 5)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 6)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 5)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 5)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 6)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 7)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 8)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 9)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 10)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 12)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 13)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 14)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 15)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 15)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 14)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 13)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 12)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 13)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 14)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 15)}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/c_state\[2:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 15)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 16)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSetCursor -win $_nWave2 374319.882483 -snap {("U_DATAPATH" 7)}
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 385010.505709 -snap {("U_DATAPATH" 9)}
wvSelectSignal -win $_nWave2 {( "U_DATAPATH" 12 )} 
wvSetCursor -win $_nWave2 336621.369002 -snap {("U_DATAPATH" 12)}
wvSetCursor -win $_nWave2 361378.601736 -snap {("U_DATAPATH" 12)}
wvSetCursor -win $_nWave2 394575.800174 -snap {("U_DATAPATH" 12)}
wvSetCursor -win $_nWave2 355189.293552 -snap {("U_DATAPATH" 11)}
wvSetCursor -win $_nWave2 375445.211244 -snap {("U_DATAPATH" 7)}
wvSetCursor -win $_nWave2 383885.176948 -snap {("U_DATAPATH" 16)}
wvSetCursor -win $_nWave2 392887.807033 -snap {("U_DATAPATH" 16)}
wvSetCursor -win $_nWave2 407517.080922 -snap {("U_DATAPATH" 16)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "U_DATAPATH" 4 )} 
verdiWindowResize -win $_Verdi_1 "252" "288" "994" "700"
debExit
