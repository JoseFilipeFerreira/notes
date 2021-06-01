public class ControloTrafego implements ControloTrafegoAereo {
    //limitações
    private int NUM;
    private int MAX;
    //pistas
    private boolean[] pistaOcupada;
    //Garantia II
    private int idAterrar;
    private int idDescolar;
    private int aterragens;
    private int descolagens;
    //Garantia III
    private int descolagensSeguidas;

    public ControloTrafego(int NUM, int MAX) {
        this.NUM = NUM;
        this.MAX = MAX;

        this.pistaOcupada = new boolean[NUM];
        for (int i = 0; i < NUM; i++)
            this.pistaOcupada[i] = false;

        this.idAterrar = 0;
        this.idDescolar = 0;
        this.aterragens = 0;
        this.descolagens = 0;

        this.descolagensSeguidas = 0;
    }

    private Integer pistaLivre(){
        for(int i = 0; i < this.NUM; i++) {
            if (!this.pistaOcupada[i]) {
                return i;
            }
        }
        return null;
    }

    @Override
    synchronized public int pedirParaDescolar() throws InterruptedException {
        Integer p;
        int id = idDescolar; idDescolar++;

        while ((p = this.pistaLivre()) == null
                || (this.descolagensSeguidas >= this.MAX && idAterrar < aterragens)
                || id != descolagens)
            this.wait();

        this.pistaOcupada[p] = true;
        return p;
    }

    @Override
    synchronized public int pedirParaAterrar() throws InterruptedException {
        Integer p;
        int id = idAterrar; idAterrar++;

        while ((p = this.pistaLivre()) == null || id != aterragens)
            this.wait();

        this.pistaOcupada[p] = true;
        return p;
    }

    @Override
    synchronized public void descolou(int pista) {
        this.pistaOcupada[pista] = false;
        this.descolagens++;
        this.descolagensSeguidas++;
        this.notifyAll();
    }

    @Override
    synchronized public void aterrou(int pista) {
        this.pistaOcupada[pista] = false;
        this.aterragens++;
        this.descolagensSeguidas = 0;
        this.notifyAll();
    }
}
