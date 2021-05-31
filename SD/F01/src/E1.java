public class E1 implements Runnable{

    private int n;

    public void run(){
        for(int i = 0; i < n; i++) {
            System.out.println(i);
        }
    }

    public E1(int a){n = a;}

    public static void main(String [] args){
        int N = 1000;
        int l = 100;
        Thread[] threads = new Thread[N];

        for(int i = 0; i < N; i++){
            threads[i] = new Thread(new E1(l));
            threads[i].start();
        }

        for(int i = 0; i < N; i++){
            try {
                threads[i].join();
            } catch (InterruptedException ignored) {}
        }
    }
}
