import CSDL

public final class Window {

    private var window: OpaquePointer?
    private var renderer: OpaquePointer?
    private let width: Int
    private let height: Int
    private var texture: UnsafeMutablePointer<SDL_Texture>?

    public init(
        width: Int32,
        height: Int32,
        title: String
    ) {
        self.width = Int(width)
        self.height = Int(height)

        SDL_Init(SDL_InitFlags(SDL_INIT_VIDEO))

        title.withCString { cTitle in

            window = SDL_CreateWindow(
                cTitle,
                width,
                height,
                0
            )

            renderer = SDL_CreateRenderer(
                window,
                nil
            )
            texture = SDL_CreateTexture(
                renderer,
                SDL_PIXELFORMAT_ARGB8888,
                SDL_TEXTUREACCESS_STREAMING,
                width,
                height
            )
        }
    }

    deinit {

        if let window {
            SDL_DestroyWindow(window)
        }

        SDL_Quit()
    }

    public func run(root: View, renderer: Renderer) {

        var event = SDL_Event()
        var running = true

        while running {

                while SDL_PollEvent(&event) {
                if event.type == UInt32(SDL_EVENT_QUIT.rawValue) {
                    running = false
                }

                if event.type == UInt32(SDL_EVENT_MOUSE_BUTTON_DOWN.rawValue) {

                    let mouseX: Float = Float(event.button.x)
                    let mouseY: Float = Float(event.button.y)

                    if let view = root.hitTest(
                        x: mouseX,
                        y: mouseY
                    ) {
                        view.onClick?()
                        if let button = view as? Button {
                            button.isPressed = true
                        }
                    }
                }

                if event.type == UInt32(SDL_EVENT_MOUSE_BUTTON_UP.rawValue) {

                    let x = Float(event.button.x)
                    let y = Float(event.button.y)

                    if let view = root.hitTest(
                        x: x,
                        y: y
                    ) {

                        if let button = view as? Button {

                            button.isPressed = false
                            button.onClick?()
                        }
                    }
                }
            }

            // 🧠 FRAME START
            renderer.clear()

            root.layout.calculate(
                width: Float(renderer.width),
                height: Float(renderer.height))

            root.render(into: renderer)

            self.present(renderer)

            SDL_Delay(16)  // ~60 FPS

        }
    }

    public func clear() {

        guard let renderer else {
            return
        }

        SDL_SetRenderDrawColor(
            renderer,
            30,
            30,
            30,
            255
        )

        SDL_RenderClear(renderer)

        SDL_RenderPresent(renderer)
    }

    public func present(
        _ softwareRenderer: Renderer
    ) {

        guard let renderer,
            let texture
        else {
            return
        }

        _ = softwareRenderer.pixels.withUnsafeBytes { buffer in

            SDL_UpdateTexture(
                texture,
                nil,
                buffer.baseAddress,
                Int32(
                    softwareRenderer.width * MemoryLayout<UInt32>.size
                )
            )
        }

        SDL_RenderClear(renderer)

        SDL_RenderTexture(
            renderer,
            texture,
            nil,
            nil
        )

        SDL_RenderPresent(renderer)
    }
}
