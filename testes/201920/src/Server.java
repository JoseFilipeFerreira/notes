import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    public static void main(String[] args) throws IOException {
        ServerSocket sv = new ServerSocket(12345);

        ControloTrafegoAereo ct = new ControloTrafego(10, 20);

        while(true){
            Socket s = sv.accept();
            new Thread(new Worker(s, ct)).start();
        }
    }
}
