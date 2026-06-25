import delight_ui

// Your app/CLI code here
// print("Hello from executable using the library!")

let window = Window(
    width: 1024,
    height: 768,
    title: "My UI"
)

let renderer: Renderer = Renderer(
    width: 1024,
    height: 768,
    textRenderer: BitmapTextRenderer()
)

let root = View()

root.layout.width = 1024
root.layout.height = 768

let child1: View = View()
let child2: View = View()
let text: Text = Text("Hello World!")

text.style.textColor = Color.black
text.style.fontSize = 16

let button: Button = Button("Click Me")
button.style.height = 100
button.style.width = 200
button.style.fontSize = 100
button.style.justifyContent = .center
button.style.alignItems = .center

child1.backgroundColor = Color.green

child1.style.width = 200
child1.style.height = 100
child1.style.margin = 20
child1.style.alignItems = .center
child1.style.justifyContent = .center
child1.addSubview(text)

child2.backgroundColor = Color.blue
child2.style.width = 200
child2.style.height = 100
child2.style.margin = 20

root.addSubview(child1)
root.addSubview(child2)
// root.addSubview(text)
root.addSubview(button)

root.style.flexDirection = .row
root.style.justifyContent = .center
root.style.alignItems = .center

button.onClick = {
    print("Button clicked")
}

text.applyStyle()
text.updateLayout()

func applyTreeStyle(_ view: View) {
    view.applyStyle()
    for child in view.children {
        applyTreeStyle(child)
    }
}

applyTreeStyle(root)

root.layout.calculate(
    width: 1024,
    height: 768
)

renderer.clear()

window.run(root: root, renderer: renderer)
