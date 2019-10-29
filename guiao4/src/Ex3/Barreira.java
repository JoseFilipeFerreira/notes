package Ex3;

public class Barreira {
    private int total;
    private int locked;

    public Barreira(int total) {
        this.total = total;
    }

    void esperar(){
        while (this.total != this.locked){
            locked++;
            try{
                this.wait();
            } catch (InterruptedException ignored){}
        }
        this.notifyAll();
        locked = 0;
    }
}
