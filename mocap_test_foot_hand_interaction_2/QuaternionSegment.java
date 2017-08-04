import java.nio.ByteBuffer;

/**
 * Created by C. Andrews on 6/2/17.
 */
public class QuaternionSegment {

    public int segmentId;
    public float x;
    public float y;
    public float z;
    public float q1;
    public float q2;
    public float q3;
    public float q4;

    /**
     * Create a new segment by reading the appropriate data out of the passed in ByteBuffer.
     *
     * @param buffer a ByteBuffer containing pose data
     */
    public QuaternionSegment(ByteBuffer buffer){
        segmentId = buffer.getInt();
        x = buffer.getFloat();
        z = buffer.getFloat();
        y = buffer.getFloat();
        q1 = buffer.getFloat();
        q2 = buffer.getFloat();
        q3 = buffer.getFloat();
        q4 = buffer.getFloat();
    }

    public String toString(){
        return String.format("%d (%f, %f, %f)",segmentId, x,y,z);
    }
}