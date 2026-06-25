import Testing

@testable import swift_ui_example

@Test
func createWindow() {

    let window = Window(
        width: 800,
        height: 600,
        title: "My UI"
    )

    #expect(window != nil)
}
