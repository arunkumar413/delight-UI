public final class Text: View {

    public var text: String

    public init(_ text: String) {
        self.text = text
        // self.value = text
        super.init()
        updateLayout()

    }

    public override func render(
        into renderer: Renderer,
        offsetX: Float = 0,
        offsetY: Float = 0
    ) {

        // let frame = layout.frame

        let frame: Frame = absoluteFrame(
            offsetX: offsetX,
            offsetY: offsetY
        )

        renderer.drawText(
            text,
            x: Int(frame.x),
            y: Int(frame.y),
            fontSize: style.fontSize,
            color: style.textColor
        )
    }

    public func updateLayout() {

        let size = measureText(
            text,
            fontSize: style.fontSize
        )

        style.width = size.width
        style.height = size.height

        applyStyle()
    }
}
