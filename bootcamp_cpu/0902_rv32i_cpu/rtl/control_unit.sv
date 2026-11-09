module control_unit
    import rv32_pkg::*;
(
    input  logic        clk, rst_n,
    input  logic [31:0] instr_code,
    output logic        rf_we, alusrc_sel, dwe, branch, jal, jalr, pc_en,
    output logic [ 2:0] rfsrc_sel,
    output logic [ 3:0] alu_control,
    output logic [ 2:0] itype // instruction type : function 3
);

    logic [2:0] funct3;

    typedef enum logic [3:0] {
        FET, DEC, EXE_R, EXE_I, EXE_IL, EXE_S, EXE_B, 
        EXE_JL, EXE_JR, EXE_AU, EXE_LU, MEM_S, MEM_IL, WB_IL
    } state_t;

    state_t c_state, n_state;
    opcode_e opcode;
    instr_rtype_e instr_rtype;
    instr_btype_e instr_btype;
    
    assign opcode      = opcode_e'(instr_code[6:0]);
    assign instr_rtype = instr_rtype_e'(alu_control);
    assign instr_btype = instr_btype_e'(funct3);   
    assign funct3      = instr_code[14:12];

    always_ff @(posedge clk) begin
        if(!rst_n) c_state <= FET;
        else       c_state <= n_state;
    end

    always_comb begin
        n_state     = c_state;
        rf_we       = 1'b0;
        alusrc_sel  = 1'b0;
        rfsrc_sel   = 3'd0;
        alu_control = 4'd0;
        dwe         = 1'b0;
        itype       = 3'b010; // SW, LW
        branch      = 1'b0;
        jal         = 1'b0;
        jalr        = 1'b0;
        pc_en       = 1'b0;

        case(c_state)
            FET: begin 
                pc_en   = 1'b1;
                n_state = DEC;
            end
            
            DEC: begin
                case(opcode)
                    OP_RTYPE  : n_state = EXE_R;
                    OP_STYPE  : n_state = EXE_S;
                    OP_ITYPE  : n_state = EXE_I;
                    OP_ILTYPE : n_state = EXE_IL;
                    OP_BTYPE  : n_state = EXE_B;
                    OP_LUTYPE : n_state = EXE_LU;
                    OP_AUTYPE : n_state = EXE_AU;
                    OP_JLTYPE : n_state = EXE_JL;
                    OP_JRTYPE : n_state = EXE_JR;
                    default   : n_state = FET;
                endcase
            end
            
            EXE_R: begin
                rf_we       = 1'b1;
                alusrc_sel  = 1'b0;
                alu_control = {instr_code[30], funct3};
                rfsrc_sel   = 3'd0;
                n_state     = FET;
            end
            
            EXE_S: begin
                alusrc_sel  = 1'b1;
                alu_control = 4'd0;
                n_state     = MEM_S;
            end
            
            EXE_I: begin
                rf_we       = 1'b1;
                alusrc_sel  = 1'b1;
                if({instr_code[30], funct3} == 4'b1101) 
                    alu_control = {instr_code[30], funct3}; 
                else 
                    alu_control = {1'b0, funct3};
                rfsrc_sel   = 3'd0;
                n_state     = FET;
            end
            
            EXE_IL: begin
                alusrc_sel  = 1'b1;
                alu_control = 4'd0;
                n_state     = MEM_IL;
            end
            
            EXE_B: begin 
                alusrc_sel  = 1'b0; 
                alu_control = {1'b0, funct3}; 
                branch      = 1'b1;
                n_state     = FET;
            end
            
            EXE_LU: begin
                rf_we       = 1'b1;
                rfsrc_sel   = 3'd2;
                n_state     = FET;
            end
            
            EXE_AU: begin
                rf_we       = 1'b1;
                rfsrc_sel   = 3'd3;
                n_state     = FET;
            end
            
            EXE_JL: begin
                rf_we       = 1'b1;
                rfsrc_sel   = 3'd4;
                jal         = 1'b1;
                n_state     = FET;
            end
            
            EXE_JR: begin
                rf_we       = 1'b1;
                rfsrc_sel   = 3'd4;
                jalr        = 1'b1;
                n_state     = FET;
            end
            
            MEM_S: begin
                dwe         = 1'b1;
                itype       = funct3;
                n_state     = FET;
            end
            
            MEM_IL: begin
                itype       = funct3;
                n_state     = WB_IL;
            end
            
            WB_IL: begin 
               
                rf_we       = 1'b1; 
                rfsrc_sel   = 3'd1;
                n_state     = FET;
            end

            default: n_state = FET;
        endcase
    end
endmodule
