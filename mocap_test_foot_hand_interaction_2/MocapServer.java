import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;
import java.nio.ByteBuffer;


/**
 * Created by C. Andrews on 6/2/17.
 */
public class MocapServer implements Runnable{

    public MocapPose pose;

    private DatagramSocket server;


    private final char[] PACKET_ID = {'M','X','T','P'};
    private final short HEADER_LENGTH = 24;
    private final char POSE = '0';
    private final char EULER = '1';
    private final char QUATERNION = '2';
    private final char CHARACTER = '1';
    private final char SCALING = '3';



    public MocapServer(int port) throws SocketException{
        server = new DatagramSocket(port);
    }


    public void run(){
        byte[] data = new byte[4096];
        while (true) {
            DatagramPacket packet = new DatagramPacket(data, data.length);
            try {
                server.receive(packet);

                // read in the header data
                // the header should be 24 bytes long

                // we use a ByteBuffer to make access to the data easier
                // note that the position in the buffer advances with each get, so we still need to fetch the values we aren't using
                // (though we can get random access to the buffer as well)
                ByteBuffer headerBuffer = ByteBuffer.wrap(packet.getData(), 0, HEADER_LENGTH);

                // Packet starts with ID string MXTP##
                // start by checking that the "MXTP" is the start of the packet
                for (int i = 0; i < 4; i++) {
                    if ((char) headerBuffer.get() != PACKET_ID[i]) {
                        System.err.println("Bad packet received");
                    }
                }


                char msgType = (char) headerBuffer.get(); // '0' - pose data, '1' - character data, '2' - joint angle data
                char msgFormat = (char) headerBuffer.get();
                int sampleCounter = headerBuffer.getInt();
                byte datagramCounter = headerBuffer.get(); // equal to 0x80 if this datagram is independent
                byte numSegments = headerBuffer.get();
                int timeCode = headerBuffer.getInt();
                byte character = headerBuffer.get();


                ByteBuffer dataBuffer = ByteBuffer.wrap(packet.getData(), HEADER_LENGTH, packet.getLength() - HEADER_LENGTH);
                if (msgType == POSE && msgFormat == QUATERNION) { // Quaternion pose data
                    pose = new MocapPose(dataBuffer, numSegments);

                } else if (msgType == POSE && msgFormat == EULER) {
                    //System.out.println(String.format("type: %c %c", msgType, msgFormat));


                }else if (msgType == CHARACTER && msgFormat == SCALING) {
                    //System.out.println(String.format("type: %c %c", msgType, msgFormat));
                    //ScaleInfo scaleInfo = new ScaleInfo(dataBuffer);

                }else {
                    //System.out.println(String.format("type: %c %c", msgType, msgFormat));
                }
            } catch (IOException e) {
                System.err.println("Error reading new datagram");
                e.printStackTrace();
                return;
            }
        }
    }


    public void start(){
        new Thread(this).start();
    }
}