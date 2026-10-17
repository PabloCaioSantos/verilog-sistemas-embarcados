module torneira_fsm (
    input  wire clk,
    input  wire rst,
    input  wire sensor,
    input  wire timer_fim,
    output reg  valvula
);

localparam OFF        = 2'b00;
localparam DETECCAO   = 2'b01;
localparam LIGADA     = 2'b10;
localparam DESLIGANDO = 2'b11;

reg [1:0] estado_atual, proximo_estado;

// Registrador de estado
always @(posedge clk or posedge rst) begin
    if (rst)
        estado_atual <= OFF;
    else
        estado_atual <= proximo_estado;
end

// Lógica do próximo estado
always @(*) begin
    proximo_estado = estado_atual;

    case (estado_atual)
        OFF: begin
            if (sensor)
                proximo_estado = DETECCAO;
        end

        DETECCAO: begin
            if (sensor)
                proximo_estado = LIGADA;
            else
                proximo_estado = OFF;
        end

        LIGADA: begin
            if (!sensor || timer_fim)
                proximo_estado = DESLIGANDO;
        end

        DESLIGANDO: begin
            proximo_estado = OFF;
        end

        default: proximo_estado = OFF;
    endcase
end

// Saída
always @(*) begin
    valvula = (estado_atual == LIGADA);
end

endmodule