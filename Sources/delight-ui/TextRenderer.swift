public protocol TextRenderer {

    func drawText(
        _ text: String,
        x: Int,
        y: Int,
        fontSize: Float,
        color: UInt32,
        into renderer: Renderer

    )
}
