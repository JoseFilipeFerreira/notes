public class E2Counter implements Runnable{

    private Counter count;

    public void run(){
        count.inc();
    }

    public E2Counter(Counter nC){count = nC;}

    public static void main(String [] args){
        int N = 1000;

        Counter c = new Counter(0);

        Thread[] threads = new Thread[N];

        for(int i = 0; i < N; i++){
            threads[i] = new Thread(new E2Counter(c));
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
