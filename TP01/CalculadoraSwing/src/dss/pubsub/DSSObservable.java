/*
 * DISCLAIMER: Este código foi criado para discussão e edição durante as aulas 
 * práticas de DSS, representando uma solução em construção. Como tal, não deverá 
 * ser visto como uma solução canónica, ou mesmo acabada. É disponibilizado para 
 * auxiliar o processo de estudo. Os alunos são encorajados a testar adequadamente 
 * o código fornecido e a procurar soluções alternativas, à medida que forem 
 * adquirindo mais conhecimentos.
 */
package dss.pubsub;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author jfc
 */
public class DSSObservable {
    private List<DSSObserver> observers;
    
    public DSSObservable() {
        this.observers = new ArrayList<>();
    }
    
    public void addObserver(DSSObserver o) {
        this.observers.add(o);
    }
    
    public void notifyObservers(Object value) {
        this.observers.forEach(o -> o.update(this, value));
    }
}
