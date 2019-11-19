package Ex3;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class Worker implements Runnable{
    Socket clSock;

    public Worker(Socket clSock) {
        this.clSock = clSock;
    }

    @Override
    public void run(){
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(clSock.getInputStream()));

            PrintWriter out = new PrintWriter(clSock.getOutputStream());
            String r;
            while ((r = in.readLine()) != null) {
                System.out.println(r);
                out.println(r);
                out.flush();
            }
            System.out.println("out we go");

            clSock.shutdownOutput();
            clSock.shutdownInput();
            clSock.close();
        } catch (IOException ignored){}

    }
}
