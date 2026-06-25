public struct Size {

    public let width: Float
    public let height: Float

    public init(
        width: Float,
        height: Float
    ) {
        self.width = width
        self.height = height
    }
}

public func measureText(
    _ text: String,
    fontSize: Float
) -> Size {

    let scale = max(
        1,
        Int(fontSize / 7)
    )

    return Size(
        width: Float(text.count * 6 * scale),
        height: Float(7 * scale)
    )
}
