import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.InputMismatchException;

public class Worker implements Runnable {

    private Socket s;
    private ControloTrafegoAereo ct;

    public Worker(Socket s, ControloTrafegoAereo ct) {
        this.s = s;
        this.ct = ct;
    }

    @Override
    public void run(){
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(this.s.getInputStream()));
            PrintWriter out = new PrintWriter(this.s.getOutputStream());

            String value;
            while ((value = in.readLine()) != null){
                String[] args = value.split(" ");
                try {
                    switch (args[0]){
                        case "pedirParaDescolar":
                            out.println(this.ct.pedirParaDescolar());
                            break;
                        case "pedirParaAterrar":
                            out.println(this.ct.pedirParaAterrar());
                            break;
                        case "descolou":
                            this.ct.descolou(Integer.parseInt(args[1]));
                            break;
                        case "aterrou":
                            this.ct.aterrou(Integer.parseInt(args[1]));
                            break;
                    }
                } catch (InputMismatchException e){
                    out.println("número de pista inválido");
                }
            }
        } catch (IOException | InterruptedException ignored ) {}
    }
}
