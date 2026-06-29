import yoga

public final class LayoutNode {

    let node: YGNodeRef

    public init() {
        node = YGNodeNew()
    }

    deinit {
        YGNodeFree(node)
    }

    public var width: Float {
        set {
            YGNodeStyleSetWidth(node, newValue)
        }
        get {
            YGNodeLayoutGetWidth(node)
        }
    }

    public var height: Float {
        set {
            YGNodeStyleSetHeight(node, newValue)
        }
        get {
            YGNodeLayoutGetHeight(node)
        }
    }

    public func calculate(
        width: Float,
        height: Float
    ) {
        YGNodeCalculateLayout(
            node,
            width,
            height,
            YGDirection.LTR
        )
    }

    public var frame: Frame {

        Frame(
            x: YGNodeLayoutGetLeft(node),
            y: YGNodeLayoutGetTop(node),
            width: YGNodeLayoutGetWidth(node),
            height: YGNodeLayoutGetHeight(node)
        )
    }

    public var flexDirection: FlexDirection {
        set {
            switch newValue {
            case .row:
                YGNodeStyleSetFlexDirection(node, YGFlexDirection.row)
            case .column:
                YGNodeStyleSetFlexDirection(node, YGFlexDirection.column)
            }
        }
        get {
            // optional for now
            return .row
        }
    }

}
