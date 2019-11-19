package Ex3;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class Server {

    public static void main(String[] args) throws IOException {
        int port = 12345;
        ServerSocket sSock = new ServerSocket(port);

        List<Thread> lT = new ArrayList<>();

        while (true){
            Socket clSock = sSock.accept();
            Thread t = new Thread(new Worker(clSock));
            t.start();
            lT.add(t);
        }
    }
}
