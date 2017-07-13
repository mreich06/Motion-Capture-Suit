import java.nio.ByteBuffer;

/**
 * Created by C. Andrews on 6/2/17.
 */
public class MocapPose {

    public QuaternionSegment[] segments = new QuaternionSegment[23+4+1]; // maximum number of segments is 23 for full body + 4 props, 0 not used
    /**
     * Create a new pose by reading the position data out of a ByteBuffer.
     * Currently, this only support quaternion pose data.
     * @param buffer a ByteBuffer containing pose data
     */
    public MocapPose(ByteBuffer buffer, int numSegments){
        for (int i = 0; i < numSegments; i++) {
            QuaternionSegment qs = new QuaternionSegment(buffer);
            segments[qs.segmentId] = qs;
        }
    }

    public String toString(){
        StringBuilder builder = new StringBuilder();
        builder.append("Pose:\n");
        for (QuaternionSegment segment: segments){
            if (segment != null){
                builder.append("\t");
                builder.append(segment);
                builder.append("\n");
            }
        }
        return builder.toString();
    }

}