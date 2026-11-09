simSetSimulator "-vcssv" -exec "/home/aedu16/project_cpu_uvm/uvm/build/simv" \
           -args \
           "-cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1 +UVM_VERBOSITY=UVM_HIGH"
debImport "-abdir" "./build/simv.daidir" "-dbdir" \
          "/home/aedu16/project_cpu_uvm/uvm/build/simv.daidir"
debLoadSimResult /home/aedu16/project_cpu_uvm/uvm/wave.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
verdiWindowResize -win $_Verdi_1 "830" "370" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_cpu_uvm.DUT" -win $_nTrace1
srcSetScope "tb_cpu_uvm.DUT" -delim "." -win $_nTrace1
srcHBDrag -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvSetPosition -win $_nWave2 {("DUT" 0)}
wvRenameGroup -win $_nWave2 {G1} {DUT}
wvAddSignal -win $_nWave2 "/tb_cpu_uvm/DUT/clk" "/tb_cpu_uvm/DUT/rst_n"
wvSetPosition -win $_nWave2 {("DUT" 0)}
wvSetPosition -win $_nWave2 {("DUT" 2)}
wvSetPosition -win $_nWave2 {("DUT" 2)}
srcHBSelect "tb_cpu_uvm.DUT.U_DATA_MEM" -win $_nTrace1
srcHBSelect "tb_cpu_uvm" -win $_nTrace1
srcHBSelect "tb_cpu_uvm" -win $_nTrace1
srcSetScope "tb_cpu_uvm" -delim "." -win $_nTrace1
srcHBSelect "tb_cpu_uvm" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("DUT" 0)}
wvSetPosition -win $_nWave2 {("DUT" 1)}
wvSetPosition -win $_nWave2 {("DUT" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("tb_cpu_uvm" 0)}
wvRenameGroup -win $_nWave2 {G2} {tb_cpu_uvm}
wvSelectSignal -win $_nWave2 {( "DUT" 2 )} 
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {tb_cpu_uvm}
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("DUT" 2)}
wvSetPosition -win $_nWave2 {("DUT" 2)}
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_cpu_uvm.DUT.U_DATA_MEM" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("DUT" 0)}
wvSetPosition -win $_nWave2 {("DUT" 1)}
wvSetPosition -win $_nWave2 {("DUT" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvRenameGroup -win $_nWave2 {G2} {U_DATA_MEM}
wvAddSignal -win $_nWave2 "/tb_cpu_uvm/DUT/U_DATA_MEM/clk" \
           "/tb_cpu_uvm/DUT/U_DATA_MEM/daddr\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_DATA_MEM/dwdata\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_DATA_MEM/dwe" \
           "/tb_cpu_uvm/DUT/U_DATA_MEM/itype\[2:0\]" \
           "/tb_cpu_uvm/DUT/U_DATA_MEM/drdata\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 6)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 6)}
wvSelectGroup -win $_nWave2 {U_DATA_MEM}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
verdiSetActWin -win $_nWave2
srcHBSelect "tb_cpu_uvm.DUT.U_ROM" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("DUT" 1)}
wvSetPosition -win $_nWave2 {("DUT" 2)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
wvRenameGroup -win $_nWave2 {G3} {U_ROM}
wvAddSignal -win $_nWave2 "/tb_cpu_uvm/DUT/U_ROM/instr_addr\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_ROM/instr_code\[31:0\]"
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
wvSetPosition -win $_nWave2 {("U_ROM" 2)}
wvSetPosition -win $_nWave2 {("U_ROM" 2)}
wvSelectGroup -win $_nWave2 {U_ROM}
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
verdiSetActWin -win $_nWave2
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("DUT" 2)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("U_RV32I_CPU" 0)}
wvRenameGroup -win $_nWave2 {G4} {U_RV32I_CPU}
wvAddSignal -win $_nWave2 "/tb_cpu_uvm/DUT/U_RV32I_CPU/clk" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/rst_n" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/instr_code\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/drdata\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/instr_addr\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/daddr\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/dwdata\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/dwe" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/itype\[2:0\]"
wvSetPosition -win $_nWave2 {("U_RV32I_CPU" 0)}
wvSetPosition -win $_nWave2 {("U_RV32I_CPU" 9)}
wvSetPosition -win $_nWave2 {("U_RV32I_CPU" 9)}
wvSelectGroup -win $_nWave2 {U_RV32I_CPU}
wvSetPosition -win $_nWave2 {("U_RV32I_CPU" 0)}
verdiSetActWin -win $_nWave2
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU" -win $_nTrace1
srcSetScope "tb_cpu_uvm.DUT.U_RV32I_CPU" -delim "." -win $_nTrace1
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("DUT" 0)}
wvSetPosition -win $_nWave2 {("DUT" 1)}
wvSetPosition -win $_nWave2 {("DUT" 2)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
wvSetPosition -win $_nWave2 {("U_RV32I_CPU" 0)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvRenameGroup -win $_nWave2 {G5} {U_CONTROL_UNIT}
wvAddSignal -win $_nWave2 "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/clk" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/rst_n" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/instr_code\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/rf_we" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/alusrc_sel" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/dwe" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/branch" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/jal" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/jalr" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/pc_en" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/rfsrc_sel\[2:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/alu_control\[3:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/itype\[2:0\]"
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 13)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 13)}
verdiSetActWin -win $_nWave2
wvScrollUp -win $_nWave2 27
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.p_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("DUT" 1)}
wvSetPosition -win $_nWave2 {("DUT" 2)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
wvSetPosition -win $_nWave2 {("U_RV32I_CPU" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvRenameGroup -win $_nWave2 {G6} {U_DATAPATH}
wvAddSignal -win $_nWave2 "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/clk" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/rst_n" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/rf_we" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/rfsrc_sel\[2:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/alusrc_sel" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/alu_control\[3:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/instr_code\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/drdata\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/jal" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/jalr" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/branch" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/pc_en" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/instr_addr\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/daddr\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/dwdata\[31:0\]"
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 15)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 15)}
verdiSetActWin -win $_nWave2
wvScrollUp -win $_nWave2 40
wvSelectGroup -win $_nWave2 {U_DATAPATH}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSelectGroup -win $_nWave2 {U_DATA_MEM}
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
wvSelectGroup -win $_nWave2 {G7}
wvSelectGroup -win $_nWave2 {U_DATAPATH}
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcSetScope "tb_cpu_uvm.DUT.U_RV32I_CPU.U_CONTROL_UNIT" -delim "." -win $_nTrace1
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {8 14 1 1 1 1} -backward
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_CONTROL_UNIT" 1 )} 
srcDeselectAll -win $_nTrace1
srcSelect -signal "c_state" -line 19 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 4)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 4)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 3)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 2)}
wvAddSignal -win $_nWave2 \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/c_state\[3:0\]"
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 2)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 3)}
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
srcSetScope "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH" -delim "." -win $_nTrace1
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH.U_ALU" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("G7" 0)}
wvSetPosition -win $_nWave2 {("U_ALU" 0)}
wvRenameGroup -win $_nWave2 {G7} {U_ALU}
wvAddSignal -win $_nWave2 \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_ALU/rs1\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_ALU/rs2\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_ALU/alu_control\[3:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_ALU/alu_result\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_ALU/b_taken"
wvSetPosition -win $_nWave2 {("U_ALU" 0)}
wvSetPosition -win $_nWave2 {("U_ALU" 5)}
wvSetPosition -win $_nWave2 {("U_ALU" 5)}
wvSelectGroup -win $_nWave2 {U_ALU}
wvSetPosition -win $_nWave2 {("U_ALU" 0)}
verdiSetActWin -win $_nWave2
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH.U_IMM_EXTEND" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("DUT" 0)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("U_RV32I_CPU" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_ALU" 0)}
wvSetPosition -win $_nWave2 {("G8" 0)}
wvSetPosition -win $_nWave2 {("U_IMM_EXTEND" 0)}
wvRenameGroup -win $_nWave2 {G8} {U_IMM_EXTEND}
wvAddSignal -win $_nWave2 \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_IMM_EXTEND/instr_code\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_IMM_EXTEND/imm_extend\[31:0\]"
wvSetPosition -win $_nWave2 {("U_IMM_EXTEND" 0)}
wvSetPosition -win $_nWave2 {("U_IMM_EXTEND" 2)}
wvSetPosition -win $_nWave2 {("U_IMM_EXTEND" 2)}
wvSelectGroup -win $_nWave2 {U_IMM_EXTEND}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {U_IMM_EXTEND}
wvSetPosition -win $_nWave2 {("U_IMM_EXTEND" 0)}
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH.U_REG_FILE" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("DUT" 1)}
wvSetPosition -win $_nWave2 {("U_DATA_MEM" 0)}
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_IMM_EXTEND" 0)}
wvSetPosition -win $_nWave2 {("G9" 0)}
wvSetPosition -win $_nWave2 {("U_REG_FILE" 0)}
wvRenameGroup -win $_nWave2 {G9} {U_REG_FILE}
wvAddSignal -win $_nWave2 "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/clk" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/rst_n" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/ra1\[4:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/ra2\[4:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/wa\[4:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/wd\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/we" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/rs1\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_REG_FILE/rs2\[31:0\]"
wvSetPosition -win $_nWave2 {("U_REG_FILE" 0)}
wvSetPosition -win $_nWave2 {("U_REG_FILE" 9)}
wvSetPosition -win $_nWave2 {("U_REG_FILE" 9)}
wvSelectGroup -win $_nWave2 {U_REG_FILE}
wvSetPosition -win $_nWave2 {("U_REG_FILE" 0)}
verdiSetActWin -win $_nWave2
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH.U_PC" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("U_RV32I_CPU" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_ALU" 0)}
wvSetPosition -win $_nWave2 {("U_REG_FILE" 0)}
wvSetPosition -win $_nWave2 {("G10" 0)}
wvSetPosition -win $_nWave2 {("U_PC" 0)}
wvRenameGroup -win $_nWave2 {G10} {U_PC}
wvAddSignal -win $_nWave2 "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/clk" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/rst_n" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/pc_en" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/rs1\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/imm_value\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/b_branch" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/b_taken" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/jal" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/jalr" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/pc_imm_out\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/pc_out\[31:0\]" \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_DATAPATH/U_PC/pc\[31:0\]"
wvSetPosition -win $_nWave2 {("U_PC" 0)}
wvSetPosition -win $_nWave2 {("U_PC" 12)}
wvSetPosition -win $_nWave2 {("U_PC" 12)}
wvSelectGroup -win $_nWave2 {U_PC}
wvSetPosition -win $_nWave2 {("U_PC" 0)}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 7881930.856902 7983676.952301
wvSetCursor -win $_nWave2 7954815.248582 -snap {("U_CONTROL_UNIT" 3)}
wvSetCursor -win $_nWave2 7921486.852622 -snap {("U_ROM" 0)}
srcHBSelect "tb_cpu_uvm.DUT.U_ROM" -win $_nTrace1
srcSetScope "tb_cpu_uvm.DUT.U_ROM" -delim "." -win $_nTrace1
srcHBSelect "tb_cpu_uvm.DUT.U_ROM" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -win $_nWave2
wvSelectSignal -win $_nWave2 {( "U_CONTROL_UNIT" 4 )} 
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 37306.901646 132269.924019
wvSetCursor -win $_nWave2 82563.656504 -snap {("U_CONTROL_UNIT" 4)}
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 88179.949346 234016.019417
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 7895497.002955 7997243.098354
wvSetCursor -win $_nWave2 7954766.573089 -snap {("U_CONTROL_UNIT" 3)}
wvSelectGroup -win $_nWave2 {U_CONTROL_UNIT}
wvSelectGroup -win $_nWave2 {U_DATAPATH}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomAll -win $_nWave2
wvZoom -win $_nWave2 583344.280287 830926.445758
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
srcHBSelect "tb_cpu_uvm.DUT.U_DATA_MEM" -win $_nTrace1
srcSetScope "tb_cpu_uvm.DUT.U_DATA_MEM" -delim "." -win $_nTrace1
srcHBSelect "tb_cpu_uvm.DUT.U_DATA_MEM" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
srcSetScope "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH" -delim "." -win $_nTrace1
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_DATAPATH" -win $_nTrace1
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcSetScope "tb_cpu_uvm.DUT.U_RV32I_CPU.U_CONTROL_UNIT" -delim "." -win $_nTrace1
srcHBSelect "tb_cpu_uvm.DUT.U_RV32I_CPU.U_CONTROL_UNIT" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "opcode" -line 25 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvSetPosition -win $_nWave2 {("DUT" 1)}
wvSetPosition -win $_nWave2 {("U_ROM" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 3)}
wvSetPosition -win $_nWave2 {("U_REG_FILE" 0)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 5)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 4)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 3)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 2)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 1)}
wvSetPosition -win $_nWave2 {("U_DATAPATH" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvAddSignal -win $_nWave2 \
           "/tb_cpu_uvm/DUT/U_RV32I_CPU/U_CONTROL_UNIT/opcode\[6:0\]"
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 0)}
wvSetPosition -win $_nWave2 {("U_CONTROL_UNIT" 1)}
verdiSetActWin -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
verdiDockWidgetMaximize -dock windowDock_nWave_2
