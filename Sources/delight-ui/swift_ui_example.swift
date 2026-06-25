// The Swift Programming Language
// https://docs.swift.org/swift-book

import CSDL

public func testYoga() {
    let root = View()

    root.layout.width = 800
    root.layout.height = 600

    let child = View()

    child.layout.width = 200
    child.layout.height = 100

    root.addSubview(child)

    root.layout.calculate(
        width: 800,
        height: 600
    )

    _ = Window(
        width: 800,
        height: 600,
        title: "Demo"
    )

}
