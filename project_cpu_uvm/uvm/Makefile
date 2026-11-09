# vcs Make file
RTL_DIR	=	./rtl
TB_DIR	=	./tb
BUILD_DIR	=	./build
PKG_DIR = ./rtl/pkg
INC_DIR	= +incdir+$(RTL_DIR)
SIMV_DIR	=	./build/simv
SIMV_OPTS	:=	-cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb	-cm_name	sim1
SIMV_OPTS += +UVM_VERBOSITY=UVM_HIGH
VCS_OPT =	-full64 -sverilog -debug_access+all -kdb -lca \
					-timescale=1ns/1ps \
					-ntb_opts uvm-1.2 \
 					-o	$(SIMV_DIR)
run :
	mkdir -p 	$(BUILD_DIR)
	vcs				$(VCS_OPT)	$(PKG_DIR)/rv32i_pkg.sv	$(RTL_DIR)/cpu_uvm.sv	$(RTL_DIR)/datapath.sv	$(RTL_DIR)/data_memory.sv	$(RTL_DIR)/control_unit.sv	$(RTL_DIR)/instruction_rom.sv	$(TB_DIR)/tb_cpu_uvm.sv	

simv:
	$(SIMV_DIR)	$(SIMV_OPTS)

verdi:
	verdi -abdir $(BUILD_DIR)/simv.daidir -ssf wave.fsdb &

clean:
	rm -rf $(BUILD_DIR) csrc novas* ucli.key verdilog files.f inter.fsdb .inter.tbsim sys*

.PHONY: all vcs simv verdi clean
