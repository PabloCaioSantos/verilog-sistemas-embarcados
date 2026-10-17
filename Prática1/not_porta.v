module not_porta (
    input  wire A,
    input  wire clk,
    output reg  Q
);

always @(posedge clk) begin
    Q <= ~A;
end

endmodule
