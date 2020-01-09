package Client;

import Banco.BancoCliente;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Client {
    public static void main(String[] args) throws IOException {
        BancoCliente bc = new BancoCliente("127.0.0.1", 12345);

        BufferedReader inUser = new BufferedReader(new InputStreamReader(System.in));

        String r;

        bc.close();
    }
}
