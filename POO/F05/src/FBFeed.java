import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

public class FBFeed {
    private List<FBPost> posts;

    public FBFeed() {
        this.posts = new ArrayList<FBPost>();
    }

    public FBFeed(List<FBPost> listPosts){
        this.posts = new ArrayList<FBPost>();
        for(FBPost fb : listPosts){
            this.posts.add(fb.clone());
        }
    }

    /*4a*/
    public int nrPosts(String user){
        int r = 0;
        for(FBPost fb : this.posts){
            if(fb.getUsername().equals(user))
                    r++;
        }
        return r;
    }

    /*4b*/
    public List<FBPost>postsOf(String user){
        List<FBPost> rfb = new ArrayList<FBPost>();
        for(FBPost fb : this.posts){
            if(fb.getUsername().equals(user))
                rfb.add(fb);
        }
        return rfb;
    }

    /*4c*/
    public List<FBPost> postsOf(String user, LocalDateTime inicio, LocalDateTime fim){
        List<FBPost> rfb = new ArrayList<FBPost>();
        for(FBPost fb : this.posts){
            if(fb.getUsername().equals(user) && fb.getData().isAfter(inicio) && fb.getData().isBefore(fim))
                rfb.add(fb);
        }
        return rfb;
    }

    /*4d*/
    public FBPost getPost(int id){
        return this.posts.get(id);
    }

    /*4e*/
    public void comment(FBPost post, String comentario){
        int pos = this.posts.indexOf(post);
        this.getPost(pos).addComentario(comentario);

    }

    /*4f*/
    public void comment(int pos, String comentario){
        this.getPost(pos).addComentario(comentario);
    }

    /*4g*/
    public void like(FBPost post){
        int pos = this.posts.indexOf(post);
        this.getPost(pos).setLikes(this.getPost(pos).getLikes() + 1);
    }

    /*4h*/
    public void like(int pos){
        this.getPost(pos).setLikes(this.getPost(pos).getLikes() + 1);
    }

    /*4i*/
    public List<Integer> top5Comments(){
        TreeSet<FBPost> ordem = new TreeSet<FBPost>((p1,p2) -> p2.getLikes() > p1.getLikes());
        for(FBPost fb: this.posts)
            ordem.add(fb);
        return ordem.stream().mapToInt(FBPost::getId).collect(Col).limit(5);

    }










}
