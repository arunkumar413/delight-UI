public enum FlexDirection {
    case row
    case column
}
public enum JustifyContent {
    case flexStart
    case center
    case flexEnd
    case spaceBetween
    case spaceAround
    case spaceEvenly
}

public enum AlignItems {
    case strech
    case flexStart
    case flexEnd
    case center
    case baseLine
}

public enum TextAlignment {
    case left
    case center
    case right
}

public struct ViewStyle {

    public var flexDirection: FlexDirection = .column
    public var justifyContent: JustifyContent = .flexStart
    public var alignItems: AlignItems = .strech

    public var width: Float? = nil
    public var height: Float? = nil

    public var padding: Float = 0
    public var margin: Float = 0

    public var backgroundColor: UInt32 = 0xFFFF_FFFF
    public var borderColor: UInt32 = 0xFF00_0000
    public var borderWidth: Float = 0

    // Text
    public var fontSize: Float = 16
    public var textColor: UInt32 = 0xFFFF_FFFF

    public var textAlignment: TextAlignment = .left

}
