module timer_tb;
  wire pclk;
  wire preset_n;
  wire psel;
  wire penable;
  wire pwrite;
  wire [7:0] paddr, pwdata, prdata;
  wire TDR, TCR, TSR;
  wire pready, psvlerr;

  read_write_control dut(
    .pclk(pclk),
    .preset_n(preset_n),
    .psel(psel),
    .pwrite(pwrite),
    .penable(penable),
    .paddr(paddr),
    .pwdata(pwdata),

    .TDR(TDR),
    .TCR(TCR),
    .TSR(TSR),
    .prdata(prdata),
    .pready(pready),
    .pslverr(pslverr));

  CPU_model cpu(
    .cpu_pclk(pclk),
    .cpu_presetn(preset_n),
    .cpu_pready(pready),
    .cpu_pslverr(psvlerr),
    .cpu_prdata(prdata),

    .cpu_paddr(paddr),
    .cpu_pwdata(pwdata),
    .cpu_psel(psel),
    .cpu_penable(penable),
    .cpu_pwrite(pwrite));

  system_signal system(
    .sys_clk(pclk),
    .sys_resetn(preset_n));

  task get_results(input flag);
    begin
      if (flag) begin
        $display("===================================");
        $display("================FAIL===============");
        $display("===================================");
      end
      else begin
        $display("===================================");
        $display("================PASS===============");
        $display("===================================");
      end
    end
  endtask

endmodule
