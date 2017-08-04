import java.nio.ByteBuffer;

/**
 * Created by C. Andrews on 6/5/17.
 */
public class ScaleInfo {



    public ScaleInfo(ByteBuffer buffer){
        int bufferSize = buffer.limit();
        int numSegments = buffer.getInt();
        System.out.println(numSegments);
        System.out.println(buffer.limit());

        for (int i = 0; i < numSegments; i++) {
            String name = readString(buffer);
            float x = buffer.getFloat();
            float y = buffer.getFloat();
            float z = buffer.getFloat();
            System.out.println(String.format("\t%s (%f, %f, %f)", name, x, y, z));
        }

        int numPoints = buffer.getInt();

        for (int i = 0; i < numPoints; i++){
            short segId = buffer.getShort();
            short pointId = buffer.getShort();
            String name = readString(buffer);
            int characteristics = buffer.getInt();
            float x = buffer.getFloat();
            float y = buffer.getFloat();
            float z = buffer.getFloat();

            System.out.println(String.format("\t%d %d %s %02X (%f, %f, %f)", segId, pointId, name, characteristics, x, y, z));

        }

    }


    private String readString(ByteBuffer buffer){
        StringBuffer stringBuffer = new StringBuffer();
        char c;
        int stringLength = buffer.getInt();

        for (int i = 0; i < stringLength; i++){
            stringBuffer.append((char)buffer.get());
        }

        return stringBuffer.toString();
    }
}