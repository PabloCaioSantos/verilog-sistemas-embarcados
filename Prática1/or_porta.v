module or_porta (
    input  wire A,
    input  wire B,
    input  wire clk,
    output reg  Q
);

always @(posedge clk) begin
    Q <= A | B;
end

endmodule