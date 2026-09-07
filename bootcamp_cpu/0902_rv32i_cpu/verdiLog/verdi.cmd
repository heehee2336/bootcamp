simSetSimulator "-vcssv" -exec \
           "/home/aedu16/bootcamp_cpu/0902_rv32i_cpu/build/simv" -args
debImport "-abdir" "./build/simv.daidir" "-dbdir" \
          "/home/aedu16/bootcamp_cpu/0902_rv32i_cpu/build/simv.daidir"
debLoadSimResult /home/aedu16/bootcamp_cpu/0902_rv32i_cpu/wave.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcTBInvokeSim
verdiSetActWin -win $_InteractiveConsole_3
verdiSetActWin -dock widgetDock_<Member>
verdiWindowResize -win $_Verdi_1 "1281" "31" "1278" "1360"
verdiDockWidgetHide -dock widgetDock_<Watch>
srcTBSetHiddenView -view WatchView
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
srcSetScope "tb_rv32i_cpu.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
srcSetScope "tb_rv32i_cpu.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU" -win $_nTrace1
srcSetScope "tb_rv32i_cpu.dut.U_RV32I_CPU" -delim "." -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU" -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcSetScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -delim "." -win \
           $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
srcSetScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH" -delim "." -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvDumpScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvRenameGroup -win $_nWave2 {G1} {U_DATAPATH}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/clk" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/rst_n" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/rf_we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/rfsrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/alusrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/drdata\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/instr_addr\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/daddr\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/dwdata\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 1)}
wvDumpScope "tb_rv32i_cpu.dut"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/dut" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {dut}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/clk" "/tb_rv32i_cpu/dut/rst_n"
wvSetPosition -win $_nWave2 {("U_DATAPATH/dut" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/dut" 2)}
wvSelectGroup -win $_nWave2 {U_DATAPATH}
verdiSetActWin -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH" 5)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 13)}
wvMoveSelected -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_DATAPATH" 1 )} {( "U_DATAPATH/dut" 1 2 )} {( \
           "U_DATAPATH" 5 6 7 8 9 10 11 12 13 14 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/dut" 0)}
wvSelectGroup -win $_nWave2 {U_DATAPATH}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
srcHBDrag -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvDumpScope "tb_rv32i_cpu.dut"
wvSetPosition -win $_nWave2 {("dut" 0)}
wvRenameGroup -win $_nWave2 {G2} {dut}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/clk" "/tb_rv32i_cpu/dut/rst_n"
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSelectGroup -win $_nWave2 {G2}
verdiSetActWin -win $_nWave2
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("G2" 0)}
wvDumpScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvRenameGroup -win $_nWave2 {G2} {U_DATAPATH}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/clk" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/rst_n" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/rf_we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/rfsrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/alusrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/drdata\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/instr_addr\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/daddr\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/dwdata\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("U_DATAPATH" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 7)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvDumpScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_CONTROL_UNIT}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rf_we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alusrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/dwe" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/itype\[2:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rfsrc_sel"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 7)}
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_ALU" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("U_DATAPATH" 9)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvDumpScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_ALU" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_ALUSRC_MUX" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_IMM_EXTEND" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_PC" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_REG_FILE" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_WB_MUX"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_ALU}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALU/rs1\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALU/rs2\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALU/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALU/alu_result\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALUSRC_MUX" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_ALUSRC_MUX}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALUSRC_MUX/sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALUSRC_MUX/in0\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALUSRC_MUX/in1\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALUSRC_MUX/mux_out\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALUSRC_MUX" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALUSRC_MUX" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALUSRC_MUX" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_IMM_EXTEND" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_IMM_EXTEND}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_IMM_EXTEND/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_IMM_EXTEND/imm_extend\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_IMM_EXTEND" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_IMM_EXTEND" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_IMM_EXTEND" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_PC" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_PC}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_PC/clk" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_PC/rst_n" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_PC/pc\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_PC" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_PC" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_PC" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_REG_FILE" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_REG_FILE}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/clk" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/rst_n" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/ra1\[4:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/ra2\[4:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/wa\[4:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/wd\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/rd1\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/rd2\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_REG_FILE" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_REG_FILE" 9)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_REG_FILE" 9)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_WB_MUX" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_WB_MUX}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_WB_MUX/sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_WB_MUX/in0\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_WB_MUX/in1\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_WB_MUX/mux_out\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_WB_MUX" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_WB_MUX" 4)}
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_WB_MUX" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 29)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_WB_MUX" 0)}
verdiSetActWin -win $_nWave2
srcHBDrag -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvScrollUp -win $_nWave2 21
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT/U_ALU}
wvSelectSignal -win $_nWave2 {( "U_DATAPATH/U_CONTROL_UNIT/U_ALU" 1 )} 
wvScrollDown -win $_nWave2 0
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT/U_ALU}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALUSRC_MUX" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 0)}
wvMoveSelected -win $_nWave2
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT/U_ALU}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALU" 0)}
wvMoveSelected -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALUSRC_MUX" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT}
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT/U_ALUSRC_MUX}
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_ALUSRC_MUX" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT/U_IMM_EXTEND" 1)}
wvMoveSelected -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvSelectGroup -win $_nWave2 {G3}
wvSelectGroup -win $_nWave2 {G3}
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvSetPosition -win $_nWave2 {("U_DATAPATH" 6)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvDumpScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_ALU" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_ALUSRC_MUX" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_IMM_EXTEND" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_PC" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_REG_FILE" \
           "tb_rv32i_cpu.dut.U_RV32I_CPU.U_DATAPATH.U_WB_MUX"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 11)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_ALU" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_ALU}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALU/rs1\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALU/rs2\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALU/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALU/alu_result\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_ALU" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_ALU" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_ALU" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_ALUSRC_MUX" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_ALUSRC_MUX}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALUSRC_MUX/sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALUSRC_MUX/in0\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALUSRC_MUX/in1\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_ALUSRC_MUX/mux_out\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_ALUSRC_MUX" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_ALUSRC_MUX" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_ALUSRC_MUX" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_IMM_EXTEND" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_IMM_EXTEND}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_IMM_EXTEND/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_IMM_EXTEND/imm_extend\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_IMM_EXTEND" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_IMM_EXTEND" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_IMM_EXTEND" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_PC" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_PC}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_PC/clk" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_PC/rst_n" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_PC/pc\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_PC" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_PC" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_PC" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_REG_FILE" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_REG_FILE}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/clk" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/rst_n" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/ra1\[4:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/ra2\[4:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/wa\[4:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/wd\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/rd1\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/rd2\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_REG_FILE" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_REG_FILE" 9)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_REG_FILE" 9)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_WB_MUX" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_WB_MUX}
wvAddSignal -win $_nWave2 "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_WB_MUX/sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_WB_MUX/in0\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_WB_MUX/in1\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_DATAPATH/U_WB_MUX/mux_out\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_WB_MUX" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_WB_MUX" 4)}
wvScrollDown -win $_nWave2 1
wvSelectGroup -win $_nWave2 {G3}
verdiSetActWin -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_WB_MUX" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_WB_MUX" 4)}
wvScrollUp -win $_nWave2 25
wvSelectSignal -win $_nWave2 {( "dut" 2 )} 
wvSelectGroup -win $_nWave2 {U_DATAPATH}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
srcHBSelect "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("dut" 0)}
wvSetPosition -win $_nWave2 {("dut" 1)}
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvDumpScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_CONTROL_UNIT}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rf_we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alusrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/dwe" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/itype\[2:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rfsrc_sel"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 7)}
wvSelectGroup -win $_nWave2 {G3}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {G3}
wvSelectGroup -win $_nWave2 {G3}
wvSelectGroup -win $_nWave2 {U_DATAPATH}
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT}
wvScrollDown -win $_nWave2 4
wvScrollUp -win $_nWave2 2
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT}
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 5)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvMoveSelected -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_DATAPATH/U_CONTROL_UNIT" 7 )} 
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 5)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 1)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 2)}
wvSelectSignal -win $_nWave2 {( "U_DATAPATH/U_CONTROL_UNIT" 7 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 2)}
wvSelectSignal -win $_nWave2 {( "U_DATAPATH/U_CONTROL_UNIT" 6 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 2)}
wvSelectSignal -win $_nWave2 {( "U_DATAPATH/U_CONTROL_UNIT" 4 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 2)}
wvSelectSignal -win $_nWave2 {( "U_DATAPATH/U_CONTROL_UNIT" 3 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 2)}
wvSelectSignal -win $_nWave2 {( "U_DATAPATH/U_CONTROL_UNIT" 2 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 1)}
wvSelectSignal -win $_nWave2 {( "U_DATAPATH/U_CONTROL_UNIT" 2 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 1)}
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "dut" 2 )} 
wvSelectGroup -win $_nWave2 {U_DATAPATH}
wvSelectGroup -win $_nWave2 {G3}
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvDumpScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvAddSubGroup -win $_nWave2 -holdpost {U_CONTROL_UNIT}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rf_we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alusrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/dwe" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/itype\[2:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rfsrc_sel"
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH/U_CONTROL_UNIT" 7)}
wvSelectSignal -win $_nWave2 {( "dut" 2 )} 
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {U_DATAPATH}
wvSelectGroup -win $_nWave2 {U_DATAPATH/U_CONTROL_UNIT}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("U_DATAPATH" 8)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSelectGroup -win $_nWave2 {U_DATAPATH}
wvSelectGroup -win $_nWave2 {G3}
srcHBDrag -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvSetPosition -win $_nWave2 {("dut" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvDumpScope "tb_rv32i_cpu.dut.U_RV32I_CPU.U_CONTROL_UNIT"
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvRenameGroup -win $_nWave2 {G3} {U_CONTROL_UNIT}
wvAddSignal -win $_nWave2 \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/instr_code\[31:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rf_we" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alusrc_sel" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/alu_control\[3:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/dwe" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/itype\[2:0\]" \
           "/tb_rv32i_cpu/dut/U_RV32I_CPU/U_CONTROL_UNIT/rfsrc_sel"
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 7)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 7)}
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {G4}
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
wvSelectGroup -win $_nWave2 {U_DATAPATH}
wvScrollDown -win $_nWave2 3
srcTBRunSim
wvZoomAll -win $_nWave2
wvScrollDown -win $_nWave2 1
wvSetCursor -win $_nWave2 22063.690476 -snap {("U_ALUSRC_MUX" 3)}
wvScrollUp -win $_nWave2 4
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_rv32i_cpu" -win $_nTrace1
schCreateWindow -delim "." -win $_nSchema1 -scope "tb_rv32i_cpu"
verdiSetActWin -win $_nSchema_4
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
schCreateWindow -delim "." -win $_nSchema1 -scope "tb_rv32i_cpu"
verdiSetActWin -win $_nSchema_5
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
srcSetScope "tb_rv32i_cpu.dut" -delim "." -win $_nTrace1
srcHBSelect "tb_rv32i_cpu.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
schCreateWindow -delim "." -win $_nSchema1 -scope "tb_rv32i_cpu.dut"
verdiSetActWin -win $_nSchema_6
srcHBSelect "tb_rv32i_cpu" -win $_nTrace1
srcSetScope "tb_rv32i_cpu" -delim "." -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_rv32i_cpu" -win $_nTrace1
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
