package bigbird.systems
{
public class SystemPriority
{
    public static const DECODE_SYSTEM:int = 0;
    public static const DISPATCH_DECODED_SYSTEM:int = 1;
    public static const PROGRESS_SYSTEM:int = 10;

    public static const PROCESS:int = 0;
    public static const PROGRESS:int = 10;
    public static const END:int = 20;
    public static const IDLE_CHECK:int = 30;
}
}
