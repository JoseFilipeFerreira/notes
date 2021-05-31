/*
 * DISCLAIMER: Este código foi criado para discussão e edição durante as aulas 
 * práticas de DSS, representando uma solução em construção. Como tal, não deverá 
 * ser visto como uma solução canónica, ou mesmo acabada. É disponibilizado para 
 * auxiliar o processo de estudo. Os alunos são encorajados a testar adequadamente 
 * o código fornecido e a procurar soluções alternativas, à medida que forem 
 * adquirindo mais conhecimentos.
 */
package dss.calculator;

import javax.swing.SwingUtilities;

/**
 *
 * @author jfc
 */

public class CalcApp {
    
    private CalcApp() {
    }
    
    public static void main(String args[]) {
        SwingUtilities.invokeLater(new Runnable() {

            @Override
            public void run() {
                CalcModel model = new CalcModel();
                CalcController controller = new CalcController(model);
                CalcView view = new CalcView(controller);
                /** view registada como observador do controller para poder actualizar o écrandurante a construção do número no controller  */
                controller.addObserver(view);
                /** view registada como observador do model para poder actualizar o écran após operações no model */
                model.addObserver(view);
                /** controller registado como observador do model para poder actualizar o valor após operações no model */
                model.addObserver(controller);           
                view.run();
            }
        });
    }

}
