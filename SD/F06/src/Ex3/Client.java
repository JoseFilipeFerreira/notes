package Ex3;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class Client {
    public static void main(String[] args) throws IOException {
        Socket socket = new Socket("127.0.0.1", 12345);

        BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        PrintWriter out = new PrintWriter(socket.getOutputStream());

        BufferedReader inUser = new BufferedReader(new InputStreamReader(System.in));

        String r;
        while (((r = inUser.readLine()) != null) && ! r.equals("quit")){
            out.println(r);
            out.flush();
            System.out.println(in.readLine());
        }

        socket.shutdownOutput();
        socket.shutdownInput();
        socket.close();
    }
}
