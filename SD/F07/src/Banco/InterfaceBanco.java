package Banco;

import Banco.Movimento;
import Exceptions.BancoRemotoException;
import Exceptions.ContaInvalida;
import Exceptions.SaldoInsuficiente;

import java.util.List;

public interface InterfaceBanco {

    int criarConta(double saldoInicial)
            throws BancoRemotoException;

    double fecharConta(int id)
            throws Exceptions.ContaInvalida, BancoRemotoException;

    double consultar(int conta)
            throws Exceptions.ContaInvalida, BancoRemotoException;

    double consultarTotal(int contas[])
            throws ContaInvalida, BancoRemotoException;

    void levantar(int conta, double valor)
            throws ContaInvalida, Exceptions.SaldoInsuficiente, BancoRemotoException;

    void depositar(int conta, double valor)
            throws ContaInvalida, BancoRemotoException;

    void transferir(int contaO, int contaD, double valor)
            throws ContaInvalida, SaldoInsuficiente, BancoRemotoException;

    List<Movimento> movimentos(int id)
            throws ContaInvalida, BancoRemotoException;
}
