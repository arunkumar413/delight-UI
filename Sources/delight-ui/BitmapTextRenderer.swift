public final class BitmapTextRenderer:
    TextRenderer
{

    public init() {

    }

    private let font: [Character: [UInt8]] = [
        "H": [
            0b10001,
            0b10001,
            0b10001,
            0b11111,
            0b10001,
            0b10001,
            0b10001,
        ]
    ]

    public func drawText(
        _ text: String,
        x: Int,
        y: Int,
        fontSize: Float,
        color: UInt32,
        into renderer: Renderer
    ) {

        // var currentX: Int = x

        let scale = max(1, Int(fontSize / 7))

        var currentX: Int = x

        for character: Character in text {

            drawCharacter(
                character,
                x: currentX,
                y: y,
                color: color,
                fontSize: UInt32(fontSize),
                renderer: renderer
            )

            // currentX += 6
            currentX += 6 * scale

            // let scale = max(1, Int(fontSize / 7))

        }
    }

    private func drawCharacter(
        _ character: Character,
        x: Int,
        y: Int,
        color: UInt32,
        fontSize: UInt32,
        renderer: Renderer
    ) {

        let upper = Character(
            String(character).uppercased()
        )

        let glyph =
            BitmapFont.glyphs[upper]
            ?? BitmapFont.missingGlyph

        let scale = max(1, Int(fontSize / 7))

        for row in 0..<7 {
            for col in 0..<5 {

                let bit =
                    (glyph[row] >> (4 - col)) & 1

                if bit == 1 {
                    // renderer.setPixel(
                    //     x: x + col,
                    //     y: y + row,
                    //     color: color
                    // )

                    renderer.fillRect(
                        x: x + col * scale,
                        y: y + row * scale,
                        width: scale,
                        height: scale,
                        color: color
                    )
                }
            }
        }
    }
}
