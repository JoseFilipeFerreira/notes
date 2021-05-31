public class Ponto {
    private double x;
    private double y;

    public Ponto(){
        this.x = 0;
        this.y = 0;
    }

    public Ponto( int cx, int cy){
        this.x = cx;
        this.y = cy;
    }

    public Ponto(Ponto umPonto){
        this.x =umPonto.getX();
        this.y = umPonto.getY();
    }

    public double getX(){
        return this.x;
    }

    public double getY(){
        return this.y;
    }

    public void  setX(double novoX){
        this.x = novoX;
    }

    public  void sety(double novoY){
        this.y = novoY;
    }

    public void deslocamento( double deltaX, double deltaY){
        this.x += deltaX;
        this.y += deltaY;
    }

    public void somaPonto(Ponto umPonto){
        this.x += umPonto.getX();
        this.y += umPonto.getY();
    }

    public void movePonto(double cx, double cy){
        this.x = cx;
        this.y = cy;
    }

    public boolean ePositivo() {
        return (this.x > 0 && this.y > 0);
    }

    public double distancia (Ponto umPonto){
        return Math.sqrt(Math.pow(this.x - umPonto.getX(), 2) + Math.pow(this.y - umPonto.getY(), 2));
    }

    public boolean iguais(Ponto umPonto){
        return( this.x == umPonto.getX() && this.y == umPonto.getY());
    }

    private boolean xIgualAy(){
        return (Math.abs(this.x) == Math.abs(this.y));
    }

    public String toString(){
        return "Cx = " + this.x + " - Cy = " + this.y;
    }

    public Ponto clone() {
        return new Ponto(this);
    }
}

