public class HelloRunnable3 implements Runnable{
    int n;

    public void run(){
        System.out.println(n);
        this.set(111);
    }

    public HelloRunnable3(int a){n = a;}

    public void set(int b){n=b;}

    public static void main(String [] args){
        HelloRunnable3 r = new HelloRunnable3(222);
        Thread t1 = new Thread(r);
        Thread t2 = new Thread(r);
        System.out.println("Antes:");
        t1.start();
        t2.start();
        System.out.println("Depois:");
        try{
            t2.join();
            t1.join();
        }
        catch (InterruptedException ignored){}
        System.out.println("Fim");
    }
}
