public class E2Instancia implements Runnable{
    private Counter count;
    private int I;

    public void run(){
        for(int i = 0; i < I; i++)
            count.inc();
    }

    public E2Instancia(Counter nC, int nI){count = nC; I = nI;}

    public static void main(String [] args){
        int N = 1000;
        int I = 100;

        Counter c = new Counter(0);

        Thread[] threads = new Thread[N];

        for(int i = 0; i < N; i++){
            threads[i] = new Thread(new E2Instancia(c, I));
        }

        for(int i = 0; i < N; i++){
            threads[i].start();
        }

        for(int i = 0; i < N; i++){
            try {
                threads[i].join();
            } catch (InterruptedException ignored) {}
        }

        System.out.println(c.get());
    }
}
