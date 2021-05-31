package Banco;

public class Movimento {
    private int id_operacao;
    private String descritivo;
    private double valor;
    private double saldo_resultante;

    public Movimento(int id_operacao, String descritivo, double valor, double saldo_resultante) {
        this.id_operacao = id_operacao;
        this.descritivo = descritivo;
        this.valor = valor;
        this.saldo_resultante = saldo_resultante;
    }

}
