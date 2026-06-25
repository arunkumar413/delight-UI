public final class Renderer {

    public var textRenderer: TextRenderer

    let width: Int
    let height: Int

    var pixels: [UInt32]

    public init(
        width: Int,
        height: Int,
        textRenderer: TextRenderer

    ) {

        self.width = width
        self.height = height
        self.textRenderer = textRenderer

        self.pixels = Array(
            repeating: 0x0000_0000,
            count: width * height
        )

    }

    public func fillRect(
        x: Int,
        y: Int,
        width: Int,
        height: Int,
        color: UInt32,
        showBorder: Bool = false
    ) {

        let startX = max(0, x)
        let startY = max(0, y)

        let endX = min(self.width, x + width)
        let endY = min(self.height, y + height)

        guard startX < endX,
            startY < endY
        else {
            return
        }

        for row in startY..<endY {

            let rowOffset = row * self.width

            for col in startX..<endX {

                pixels[rowOffset + col] = color
            }
        }

        if showBorder {

            let borderColor: UInt32 = 0xFF00_0000

            // top
            if startY < self.height {
                let rowOffset = startY * self.width

                for col in startX..<endX {
                    pixels[rowOffset + col] = borderColor
                }
            }

            // bottom
            if endY > startY {
                let rowOffset = (endY - 1) * self.width

                for col in startX..<endX {
                    pixels[rowOffset + col] = borderColor
                }
            }

            // left
            if startX < self.width {
                for row in startY..<endY {
                    pixels[row * self.width + startX] = borderColor
                }
            }

            // right
            if endX > startX {
                for row in startY..<endY {
                    pixels[row * self.width + (endX - 1)] = borderColor
                }
            }
        }
    }

    public func clear(color: UInt32 = 0xFF00_0000) {
        pixels = Array(
            repeating: color,
            count: width * height
        )
    }

    public func drawText(
        _ text: String,
        x: Int,
        y: Int,
        fontSize: Float,
        color: UInt32
    ) {

        textRenderer.drawText(
            text,
            x: x,
            y: y,
            fontSize: fontSize,
            color: color,
            into: self

        )
    }

    public func setPixel(
        x: Int,
        y: Int,
        color: UInt32
    ) {

        guard x >= 0,
            y >= 0,
            x < width,
            y < height
        else {
            return
        }

        pixels[y * width + x] = color
    }
}
