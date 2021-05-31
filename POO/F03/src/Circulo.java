public class Circulo{
    private double x;
    private double y;
    private double raio;

    public double getX(){
        return this.x;
    }

    public double getY(){
        return this.y;
    }

    public double getRaio(){
        return this.raio;
    }

    public void setX(double x){
        this.x = x;
    }

    public void setY(double y){
        this.y = y;
    }

    public void setRaio(double raio){
        this.raio = raio;
    }

    public void alteraCentro(double x, double y){
        this.x = x;
        this.y = y;
    }

    public double calculaArea(){
        return Math.PI * Math.pow(this.getRaio(),2);
    }

    public double calculaPerimetro(){
        return 2 * Math.PI * this.getRaio();
    }

    public boolean equals(Circulo c){
        return (this.x == c.getX() && this.y == c.getY() && this.raio == c.getRaio());
    }

    public String toString() {
        return "Cx = " + this.getX() + "- Cy = " + this.getY() + " - Craio = " + this.getRaio();
    }
}