import java.util.HashMap;
import java.util.List;
import java.util.Map;
q
public class FBFeedMap {
    private Map<String, List<FBFeed>> postLists;

    public FBFeedMap(){
        this.postLists = new HashMap<>();
    }

    public FBFeedMap(FBFeedMap postLists){
        this.postLists = new HashMap<>();
        for(FBFeed fb : postLists.keySet()){
            this.posts.add(fb.clone());
        }

    }
}
