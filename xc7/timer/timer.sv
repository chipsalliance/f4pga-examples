`timescale 1ns / 1ps `default_nettype none

module timer (
    input wire logic clk,
    reset,
    run,
    output logic [3:0] digit0,
    digit1,
    digit2,
    digit3
);

  logic inc0, inc1, inc2, inc3, inc4;

  logic [23:0] timerCount;

  modify_count #(10) M0 (
      clk,
      reset,
      inc0,
      inc1,
      digit0
  );
  modify_count #(10) M1 (
      clk,
      reset,
      inc1,
      inc2,
      digit1
  );
  modify_count #(10) M2 (
      clk,
      reset,
      inc2,
      inc3,
      digit2
  );
  modify_count #(6) M3 (
      clk,
      reset,
      inc3,
      inc4,
      digit3
  );

  time_counter #(1000000) T0 (
      clk,
      reset,
      run,
      inc0,
      timerCount
  );
endmodule
