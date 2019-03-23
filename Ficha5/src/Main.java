public class Main {

    public static void main(String[] args) {
        StackString ss = new StackString();
        System.out.println(ss.empty());
        ss.push("Hello World!");
        ss.push("Hello There");
        ss.push("General Kenobi");
        System.out.println(ss.empty());
        System.out.println(ss.toString());

        System.out.println(ss.pop());
        System.out.println(ss.pop());
        System.out.println(ss.pop());
        System.out.println(ss.empty());

    }
}
