import com.sun.org.apache.xpath.internal.operations.Bool;

import java.util.HashMap;
import java.util.Set;
import java.util.Map;

public class Parque {
    private String nome;
    private Map<String, Lugar> lugares;

    public Parque(){
        this.lugares = new HashMap<>();
        this.nome = new String();
    }

    public Parque(String nome, Map<String, Lugar> lugs){
        this.nome = nome;
        this.lugares = new HashMap<>();
        for(Lugar l : lugs.values())
            this.lugares.put(l.getMatricula(), l.clone());
    }

    public Parque(Parque parque) {
        this.nome = parque.nome;
        this.lugares = new HashMap<>();
        for(Lugar l : parque.lugares.values())
            this.lugares.put(l.getMatricula(), l.clone());
    }


    public Set <String> getLugaresOcupados(){
        return this.lugares.keySet();
    }

    public void addLugar(Lugar l){
        this.lugares.put(l.getMatricula(), l);
    }

    public void removeLugar(Lugar l){
        this.lugares.remove(l.getMatricula());
    }

    public void editTime(String matricula, int tempo){
        this.lugares.get(matricula).setMinutos(tempo);
    }

    public int totalMinExt(){
        int t = 0;
        for(Lugar l : this.lugares.values())
            t += l.getMinutos();
        return t;
    }

    public boolean equals(Parque p){
        if (this == p)
            return true;

        if((p == null) || (this.getClass() != p.getClass()))
            return false;

        return p.nome.equals(this.nome) && p.lugares.equals(this.lugares);
    }

    public Parque clone(){
        return new Parque(this);
    }


}
