
/**
 * Created by C. Andrews on 6/2/17.
 */
public class MocapServerTest {

    public static void main(String argc[]) throws Exception{

       MocapServer server = new MocapServer(9763);
       new Thread(server).start();

       while (true){
           System.out.println(server.pose);
           Thread.sleep(1000);
       }
    }
}