import java.nio.ByteBuffer;

/**
 * Created by C. Andrews on 6/2/17.
 */
public class EulerSegment {

    public int segmentId;
    public float x;
    public float y;
    public float z;
    public float rx;
    public float ry;
    public float rz;


    /**
     * Create a new segment by reading the appropriate data out of the passed in ByteBuffer.
     *
     * @param buffer a ByteBuffer containing pose data
     */
    public EulerSegment(ByteBuffer buffer){
        segmentId = buffer.getInt();
        x = buffer.getFloat();
        y = buffer.getFloat();
        z = buffer.getFloat();
        rx = buffer.getFloat();
        ry = buffer.getFloat();
        rz = buffer.getFloat();
    }

    public String toString(){
        return String.format("%d (%f, %f, %f)",segmentId, x,y,z);
    }
}