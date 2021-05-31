package Server;

import Banco.BancoServer;
import Exceptions.ContaInvalida;
import Exceptions.SaldoInsuficiente;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class Worker implements Runnable{
    private Socket clSock;
    private BancoServer banco;

    public Worker(Socket clSock, BancoServer banco) {
        this.clSock = clSock;
        this.banco = banco;
    }

    @Override
    public void run(){
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(clSock.getInputStream()));
            PrintWriter out = new PrintWriter(clSock.getOutputStream());

            String r;
            while ((r = in.readLine()) != null && ! r.equals("quit")) {
                System.out.println(r);

                String [] args = r.toLowerCase().split(" ");
                try {
                    switch(args[0]) {
                        case "cr":
                                out.println(this.banco.criarConta(Integer.parseInt(args[1])));
                            break;
                        case "rip":
                            out.println(this.banco.fecharConta(Integer.parseInt(args[1])));
                            break;
                        case "c":
                            out.println(this.banco.consultar(Integer.parseInt(args[1])));
                            break;
                        case "ct":
                            int [] contas = new int[args.length - 1];
                            for (int i = 1; i < args.length ; i++)
                                contas[i - 1] = Integer.parseInt(args[i]);
                            out.println(this.banco.consultarTotal(contas));
                            break;
                        case "d":
                            this.banco.depositar(
                                    Integer.parseInt(args[1]),
                                    Integer.parseInt(args[2])
                            );
                            out.println(this.banco.consultar(Integer.parseInt(args[1])));
                            break;
                        case "l":
                            this.banco.levantar(
                                    Integer.parseInt(args[1]),
                                    Integer.parseInt(args[2])
                            );
                            out.println(this.banco.consultar(Integer.parseInt(args[1])));
                            break;
                        case "t":
                            this.banco.transferir(
                                    Integer.parseInt(args[1]),
                                    Integer.parseInt(args[2]),
                                    Double.parseDouble(args[3])
                            );
                        case "m":
                            out.println(this.banco.movimentos(Integer.parseInt(args[1])).toString());
                    }


                } catch (ContaInvalida | SaldoInsuficiente | NumberFormatException | ArrayIndexOutOfBoundsException ignored) {
                    out.println(-1);
                    System.out.println(ignored);
                }
                out.flush();
            }
            System.out.println("out we go");

            clSock.shutdownOutput();
            clSock.shutdownInput();
            clSock.close();
        } catch (IOException ignored){}

    }
}
