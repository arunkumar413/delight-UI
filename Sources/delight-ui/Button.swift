public final class Button: View {

    public var isPressed: Bool = false
    public let label: Text

    public init(
        _ title: String
    ) {

        label = Text(title)

        super.init()

        addSubview(label)

        style.padding = 10
        style.backgroundColor = 0xFFCC_CCCC

        applyStyle()
    }

    public override func render(
        into renderer: Renderer,
        offsetX: Float = 0,
        offsetY: Float = 0
    ) {

        let color: UInt32

        if isPressed {
            color = 0xFF1D_4ED8
        } else {
            color = 0xFF3B_82F6
        }

        let frame: Frame = layout.frame

        let absoluteX: Float = offsetX + frame.x
        let absoluteY: Float = offsetY + frame.y

        renderer.fillRect(
            x: Int(absoluteX),
            y: Int(absoluteY),
            width: Int(frame.width),
            height: Int(frame.height),
            color: color,
            showBorder: true
        )

        for child in children {
            child.render(
                into: renderer,
                offsetX: absoluteX,
                offsetY: absoluteY
            )
        }
    }
}
