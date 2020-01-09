package Banco;

import InterfaceBanco;
import Exceptions.BancoRemotoException;
import Exceptions.ContaInvalida;
import Exceptions.SaldoInsuficiente;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class BancoCliente implements InterfaceBanco {

    private Socket socket;
    private BufferedReader inServer;
    private PrintWriter outServer;

    public BancoCliente(String host, int port)
            throws IOException {
        this.socket = new Socket(host, port);
        this.inServer = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        this.outServer = new PrintWriter(socket.getOutputStream());
    }

    public void close()
            throws IOException {
        socket.shutdownOutput();
        socket.shutdownInput();
        socket.close();
    }

    @Override
    public int criarConta(double saldoInicial)
            throws BancoRemotoException {
        outServer.println("cr");
        outServer.flush();
        try {
            return Integer.parseInt(inServer.readLine());
        }
        catch (IOException ignored) {
            throw new BancoRemotoException("Could not connect to server");
        }
        catch (NumberFormatException ignored){
            throw new BancoRemotoException("Response format mismatch");
        }
    }

    @Override
    public double fecharConta(int id)
            throws ContaInvalida, BancoRemotoException {
        outServer.println("rip");
        outServer.flush();
        try {
            return Double.parseDouble(inServer.readLine());
        }
        catch (IOException ignored) {
            throw new BancoRemotoException("Could not connect to server");
        }
        catch (NumberFormatException ignored){
            throw new BancoRemotoException("Response format mismatch");
        }
    }

    @Override
    public double consultar(int conta)
            throws ContaInvalida, BancoRemotoException {
        outServer.println("c " + conta);
        outServer.flush();
        try {
            return Double.parseDouble(inServer.readLine());
        }
        catch (IOException ignored) {
            throw new BancoRemotoException("Could not connect to server");
        }
        catch (NumberFormatException ignored){
            throw new BancoRemotoException("Response format mismatch");
        }
    }

    @Override
    public double consultarTotal(int[] contas)
            throws ContaInvalida, BancoRemotoException {
        outServer.println("c " +
                Stream.of(contas).map(String::valueOf).collect((Collectors.joining(" "))));
        outServer.flush();
        try {
            return Double.parseDouble(inServer.readLine());
        }
        catch (IOException ignored) {
            throw new BancoRemotoException("Could not connect to server");
        }
        catch (NumberFormatException ignored){
            throw new BancoRemotoException("Response format mismatch");
        }
    }

    @Override
    public void levantar(int conta, double valor)
            throws ContaInvalida, SaldoInsuficiente, BancoRemotoException {
        outServer.println();
        outServer.flush();
        try {
            return inServer.readLine();
        }
        catch (IOException ignored) {
            throw new BancoRemotoException("Could not connect to server");
        }
    }

    @Override
    public void depositar(int conta, double valor)
            throws ContaInvalida, BancoRemotoException {
        outServer.println();
        outServer.flush();
        try {
            return inServer.readLine();
        }
        catch (IOException ignored) {
            throw new BancoRemotoException("Could not connect to server");
        }
    }

    @Override
    public void transferir(int contaO, int contaD, double valor)
            throws ContaInvalida, SaldoInsuficiente, BancoRemotoException {
        outServer.println();
        outServer.flush();
        try {
            return inServer.readLine();
        }
        catch (IOException ignored) {
            throw new BancoRemotoException("Could not connect to server");
        }
    }

    @Override
    public List<Movimento> movimentos(int id)
            throws ContaInvalida, BancoRemotoException {
        outServer.println();
        try {
            return inServer.readLine();
        }
        catch (IOException ignored) {
            throw new BancoRemotoException("Could not connect to server");
        }
    }
}
