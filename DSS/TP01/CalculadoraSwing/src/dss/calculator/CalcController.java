/*
 * DISCLAIMER: Este código foi criado para discussão e edição durante as aulas 
 * práticas de DSS, representando uma solução em construção. Como tal, não deverá 
 * ser visto como uma solução canónica, ou mesmo acabada. É disponibilizado para 
 * auxiliar o processo de estudo. Os alunos são encorajados a testar adequadamente 
 * o código fornecido e a procurar soluções alternativas, à medida que forem 
 * adquirindo mais conhecimentos.
 */
package dss.calculator;

/**
 *
 * @author  jfc (v. 9/2019)
 */

import dss.pubsub.DSSObservable;
import dss.pubsub.DSSObserver;

public class CalcController extends DSSObservable implements DSSObserver {
    
    private double screen_value;          // o valor que está a ser lido
    private char lastkey;                 // indica que se vai começar a "ler" um novo número
    private char opr;                     // memória com a operação a aplicar
    private CalcModel model; 
    
    /** Creates a new instance of Calculadora */
    public CalcController(CalcModel model) {
        this.screen_value = 0;
        this.lastkey = ' ';
        this.opr = '=';
        this.model = model;
        /** o notifyObservers serve para comunicar o novo valor da calculadora */
        this.notifyObservers(this.screen_value);
    }
    
    public void processa(int d) {
        if (this.lastkey != 'd') {
            this.screen_value = d;
            this.lastkey = 'd';
        } else {
            this.screen_value = this.screen_value*10+d;
        }
        /** o notifyObservers serve para comunicar o novo valor da calculadora */
        this.notifyObservers(this.screen_value);
    }
    
    public void processa(char opr) {
        switch (this.opr) {
            case '=': model.setValue(this.screen_value);
                      break;
            case '+': model.add(this.screen_value);
                      break;
            case '-': model.subtract(this.screen_value);
                      break;
            case '*': model.multiply(this.screen_value);
                      break;
            case '/': model.divide(this.screen_value); // Exercício: Acrescente tratamento da divisão por zero!
                      break;
        };
        this.opr = opr;
        this.lastkey = opr;
    }
    
    public void clear() {
        model.reset();
        this.lastkey = ' ';
    }    

    @Override
    public void update(DSSObservable source, Object value) {
        this.screen_value = Double.parseDouble(value.toString());
    }
    
}
