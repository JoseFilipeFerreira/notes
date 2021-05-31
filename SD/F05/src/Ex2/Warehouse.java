package Ex2;

import java.util.HashMap;

public class Warehouse {
    private HashMap<String, Item> stock;

    public Warehouse(String[] items) {
        this.stock = new HashMap<>();
        for(String item: items)
            this.stock.put(item, new Item(1, 0));
    }

    public void supply(String item, int quantity){
        this.stock.get(item).supply(quantity);
        System.out.println("Item: " + item + "  Stock increased: " + quantity);
    }

    public void consume(String[] items) throws InterruptedException{
        for(String item : items) {
            if(!this.stock.containsKey(item))
                continue;
            this.stock.get(item).consume();
            System.out.println("Item: " + item + "  Stock decreased");
        }
    }

    public static void main(String[]atgs){
        String[] items = new String[]{"Item1", "Item2", "Item3"};

        Warehouse wh = new Warehouse(items);

        Consumidor c = new Consumidor(wh, 2, items);
        Produtor p = new Produtor(wh, 1, items);

        Thread t1 = new Thread(c);
        Thread t2 = new Thread(p);

        t1.start();
        t2.start();

        try {
            t1.join();
            t2.join();
        } catch (InterruptedException ignored) {}
    }

}
