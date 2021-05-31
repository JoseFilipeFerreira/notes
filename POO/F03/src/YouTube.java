import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class YouTube<main> {
    private String nome;
    private byte[] conteudo;
    private LocalDateTime data;
    private int resolucao;
    private long duracao;
    private String [] comentarios;
    private int numComentarios;
    private  int likes;
    private int dislikes;

    public YouTube (){
        this.nome ="";
        this.conteudo = new byte[512];
        this.data = LocalDateTime.now();
        this.resolucao = 0;
        this.duracao = 0;
        this.comentarios = new String[10];
        this.numComentarios = 0;
        this.likes = 0;
        this.dislikes = 0;
    }

    public String getNome(){
        return this.nome;
    }

    public byte[] getConteudo(){
        return  this.conteudo;
    }

    public LocalDateTime getData(){
        return this.data;
    }

    public int getResolucao(){
        return this.resolucao;
    }

    public long getDuracao(){
        return this.duracao;
    }

    public String[] getComentarios(){
        return this.comentarios;
    }

    public int getNumComentarios(){
        return this.numComentarios;
    }

    public int getLikes(){
        return this.likes;
    }

    public int getDislikes(){
        return this.dislikes;
    }
    public void setNome(String nome){
        this.nome = nome;
    }

    public void setConteudo(byte[] conteudo){
        this.conteudo = conteudo;
    }

    public void setData(LocalDateTime data){
        this.data = data;
    }

    public void setResolucao(int res){
        this.resolucao = res;
    }

    public void setDuracao(long duracao){
        this.duracao = duracao;
    }

    public void setComentarios(String[] comentarios){
        this.comentarios = comentarios;
    }

    public void setNumComentarios(int numComentarios){
        this.numComentarios = numComentarios;
    }

    public void setLikes(int likes){
        this.likes = likes;
    }

    public void setDislikes(int dislikes){
        this.dislikes = dislikes;
    }

    public void insereComentario(String comentario){
        this.comentarios[this.numComentarios] = comentario;
        this.numComentarios ++;
    }

    public long qtsDiasDepois(){
        return this.data.until(LocalDateTime.now(), ChronoUnit.DAYS);
    }

    public void thumbsUp(){
        this.likes ++;
    }

    public String processa(){
        return String.valueOf(this.conteudo);
    }


}