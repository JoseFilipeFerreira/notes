/*
 * DISCLAIMER: Este código foi criado para discussão e edição durante as aulas 
 * práticas de DSS, representando uma solução em construção. Como tal, não deverá 
 * ser visto como uma solução canónica, ou mesmo acabada. É disponibilizado para 
 * auxiliar o processo de estudo. Os alunos são encorajados a testar adequadamente 
 * o código fornecido e a procurar soluções alternativas, à medida que forem 
 * adquirindo mais conhecimentos.
 */
package dss.calculator;

import dss.pubsub.DSSObservable;

/**
 *
 * @author jfc
 */
public class CalcModel extends DSSObservable {
    private double value;
    
    public CalcModel() {
        this.value = 0;
    }
    
    public void add(double v) {
        this.value += v;
        this.notifyObservers(""+value);
    }
    
    public void subtract(double v) {
        this.value -= v;
        this.notifyObservers(""+value);
    }
    
    public void multiply(double v) {
        this.value *= v;
        this.notifyObservers(""+value);
    }
    
    public void divide(double v) {
        this.value /= v;
        this.notifyObservers(""+value);
    }
    
    public double getValue() {
        return this.value;
    }
    
    public void setValue(double v) {
        this.value = v;
    }
    
    public void reset() {
        this.value = 0;
        this.notifyObservers(""+value);
    }
}
