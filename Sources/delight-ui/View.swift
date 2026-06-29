import yoga

open class View {

    public let layout: LayoutNode = LayoutNode()
    public var style: ViewStyle = ViewStyle()
    public var onClick: (() -> Void)?

    public var children: [View] = []

    public var backgroundColor: UInt32 = 0xFFFF_FFFF
    public init() {}

    public func addSubview(_ child: View) {

        children.append(child)

        YGNodeInsertChild(
            layout.node,
            child.layout.node,
            children.count - 1
        )
    }

    open func render(
        into renderer: Renderer,
        offsetX: Float = 0,
        offsetY: Float = 0
    ) {

        let frame: Frame = layout.frame

        let absoluteX: Float = offsetX + frame.x
        let absoluteY: Float = offsetY + frame.y

        renderer.fillRect(
            x: Int(absoluteX),
            y: Int(absoluteY),
            width: Int(frame.width),
            height: Int(frame.height),
            color: backgroundColor,
            showBorder: true
        )

        for child: View in children {
            child.render(
                into: renderer,
                offsetX: absoluteX,
                offsetY: absoluteY
            )
        }

    }

    public func applyStyle() {

        switch style.flexDirection {
        case .row:
            YGNodeStyleSetFlexDirection(layout.node, YGFlexDirection.row)
        case .column:
            YGNodeStyleSetFlexDirection(layout.node, YGFlexDirection.column)
        }

        if let width = style.width {
            YGNodeStyleSetWidth(layout.node, width)
        }

        if let height = style.height {
            YGNodeStyleSetHeight(layout.node, height)
        }

        YGNodeStyleSetMargin(
            layout.node,
            YGEdge.all,
            style.margin
        )

        YGNodeStyleSetPadding(
            layout.node,
            YGEdge.all,
            style.padding
        )

        switch style.justifyContent {

        case .flexStart:
            YGNodeStyleSetJustifyContent(
                layout.node,
                YGJustify.flexStart
            )

        case .center:
            YGNodeStyleSetJustifyContent(
                layout.node,
                YGJustify.center
            )

        case .flexEnd:
            YGNodeStyleSetJustifyContent(
                layout.node,
                YGJustify.flexEnd
            )

        case .spaceBetween:
            YGNodeStyleSetJustifyContent(
                layout.node,
                YGJustify.spaceBetween
            )

        case .spaceAround:
            YGNodeStyleSetJustifyContent(
                layout.node,
                YGJustify.spaceAround
            )

        case .spaceEvenly:
            YGNodeStyleSetJustifyContent(
                layout.node,
                YGJustify.spaceEvenly
            )
        }

        switch style.alignItems {

        case .strech:
            YGNodeStyleSetAlignItems(layout.node, YGAlign.stretch)

        case .flexEnd:
            YGNodeStyleSetAlignItems(layout.node, YGAlign.flexEnd)
        case .flexStart:

            YGNodeStyleSetAlignItems(layout.node, YGAlign.flexStart)

        case .center:
            YGNodeStyleSetAlignItems(layout.node, YGAlign.center)

        case .baseLine:
            YGNodeStyleSetAlignItems(layout.node, YGAlign.baseline)

        }

    }

    public func absoluteFrame(
        offsetX: Float,
        offsetY: Float
    ) -> Frame {

        let frame = layout.frame

        return Frame(
            x: offsetX + frame.x,
            y: offsetY + frame.y,
            width: frame.width,
            height: frame.height
        )
    }

    public func hitTest(
        x: Float,
        y: Float,
        offsetX: Float = 0,
        offsetY: Float = 0
    ) -> View? {

        let frame = absoluteFrame(
            offsetX: offsetX,
            offsetY: offsetY
        )

        guard
            x >= frame.x,
            x <= frame.x + frame.width,
            y >= frame.y,
            y <= frame.y + frame.height
        else {
            return nil
        }

        for child in children.reversed() {

            if let hit = child.hitTest(
                x: x,
                y: y,
                offsetX: frame.x,
                offsetY: frame.y
            ) {
                return hit
            }
        }

        return self
    }

}
