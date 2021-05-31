public class CirculoPonto {
    private Ponto p;
    private double raio;

    public double getX(){
        return this.p.getX();
    }

    public double getY(){
        return this.p.getY();
    }

    public double getRaio(){
        return this.raio;
    }

    public void setX(double x){
        this.p.setX(x);
    }

    public void setY(double y){
        this.p.sety(y);
    }

    public void setRaio(double raio){
        this.raio = raio;
    }

    public void alteraCentro(double x, double y){
        this.p.movePonto(x, y);
    }

    public double calculaArea(){
        return Math.PI * Math.pow(this.getRaio(),2);
    }

    public double calculaPerimetro(){
        return 2 * Math.PI * this.getRaio();
    }

    public boolean equals(CirculoPonto c){
        return(this.p.getX() == c.p.getX() && this.p.getY() == c.p.getY() && this.raio == c.getRaio());
    }

    public String toString() {
        return "Cx = " + this.getX() + "- Cy = " + this.getY() + " - Craio = " + this.getRaio();
    }
}
