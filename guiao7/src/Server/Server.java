package Server;

import Banco.BancoServer;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class Server {

    public static void main(String[] args) throws IOException {
        int port = 12345;
        ServerSocket sSock = new ServerSocket(port);

        BancoServer banco = new BancoServer(10);

        List<Thread> lT = new ArrayList<>();

        while (true){
            Socket clSock = sSock.accept();
            Thread t = new Thread(new Worker(clSock, banco));
            t.start();
            lT.add(t);
        }
    }
}
