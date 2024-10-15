task init_nop;
    begin
        init_ras_r <= 1;
        init_cas_r <= 1;
        init_we_r  <= 1;
        init_adr_r  <= 13'h00;
    end
endtask

task init_load_mode_reg;
    input [12 : 0] op_code;
    begin
        init_ras_r <= 0;
        init_cas_r <= 0;
        init_we_r  <= 0;
        init_adr_r  <= op_code [12 :  0];
    end
endtask

task init_precharge_all_bank;
    begin
        init_ras_r <= 0;
        init_cas_r <= 1;
        init_we_r  <= 0;
        init_adr_r  <= 1024;            // A10 <= 1
    end
endtask

task init_auto_refresh;
    begin
        init_ras_r <= 0;
        init_cas_r <= 0;
        init_we_r  <= 1;
    end
endtask

task nop;
    begin
        adr_w <= 0;
        ras_w <= 1;
        cas_w <= 1;
        we_w  <= 1;
        cs_w  <= cs_w;
        ba_w <= ba_w;
        dq_wr_en <= 0;
        dqm_w   <= 2'b00;
    end
endtask

task precharge_all_bank;
    input cs;
    begin
        ras_w <= 0;
        cas_w <= 1;
        we_w  <= 0;
        cs_w  <= cs;
        adr_w <= 1024;            // A10 <= 1
    end
endtask

task auto_refresh;
    input cs;

    begin
        ras_w <= 0;
        cas_w <= 0;
        we_w  <= 1;
        cs_w  <= cs;
    end
endtask

task write;
    input          cs;
    input  [1 : 0] bank;
    input [12 : 0] column;
    input [15 : 0] dq_in;
    input  [1 : 0] dqm_in;
    begin
        cs_w  <= cs;
        ras_w <= 1;
        cas_w <= 0;
        we_w  <= 0;
        dqm_w   <= dqm_in;
        ba_w    <= bank;
        adr_w  <= column;
        dq_wr    <= dq_in;
        dq_wr_en <= 1;
    end
endtask

task read;
    input          cs;
    input  [1 : 0] bank; 
    input [12 : 0] column;
    begin
        cs_w  <= cs;
        ras_w <= 1;
        cas_w <= 0;
        we_w  <= 1;
        ba_w    <= bank;
        adr_w  <= column;
    end
endtask



task active;
    input          cs;
    input  [1 : 0] bank;
    input [12 : 0] column;
    begin
        cs_w <= cs;
        ras_w <= 0;
        cas_w <= 1;
        we_w  <= 1;
        ba_w    <= bank;
        adr_w  <= column;
    end 

endtask


task precharge;
    input          cs;
    input [1 : 0] bank;
    begin
        cs_w  <= cs;
        ras_w <= 0;
        cas_w <= 1;
        we_w  <= 0;
        ba_w    <= bank;
        adr_w  <= 0;
    end
endtask

