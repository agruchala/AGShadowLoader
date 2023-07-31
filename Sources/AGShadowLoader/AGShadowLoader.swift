import SwiftUI

public struct AGShadowLoader: View {

    public struct AGShadowLoaderConfig {
        var backgroundColor = Color.black
        var gradientColors = [
            Color.clear,
            Color.white.opacity(0.7),
            Color.clear
        ]
        var animationTime: Double = 2
        var cornerRadius: CGFloat = 10
        var shadowWidth: CGFloat = 80
        
        public init(
            backgroundColor: SwiftUI.Color = Color.black,
            gradientColors: [SwiftUI.Color] = [
                Color.clear,
                Color.white.opacity(0.7),
                Color.clear
            ],
            animationTime: Double = 2,
            cornerRadius: CGFloat = 10,
            shadowWidth: CGFloat = 80
        ) {
            self.backgroundColor = backgroundColor
            self.gradientColors = gradientColors
            self.animationTime = animationTime
            self.cornerRadius = cornerRadius
            self.shadowWidth = shadowWidth
        }
    }
    
    var config = AGShadowLoaderConfig()
    
    @State private var animate = false
    
    public init(config: AGShadowLoaderConfig = AGShadowLoaderConfig()) {
        self.config = config
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                roundedRectangle()
                    .foregroundColor(config.backgroundColor)
                roundedRectangle()
                    .fill(
                        gradient()
                    )
                    .frame(width: config.shadowWidth)
                    .offset(
                        x: animationOffset(with: geometry),
                        y: 0
                    )
                    .animation(
                        animation()
                    )
            }
            .clipShape(roundedRectangle())
            .onAppear() {
                self.animate = true
            }
        }
    }
    
    @ViewBuilder
    private func gradient() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: config.gradientColors),
            startPoint: .leading,
            endPoint: .trailing)
    }
    
    @ViewBuilder
    private func roundedRectangle() -> RoundedRectangle {
        RoundedRectangle(cornerRadius: config.cornerRadius)
    }
    
    private func animation() -> Animation {
        Animation.easeInOut(duration: config.animationTime)
            .repeatForever(autoreverses: false)
    }
    
    private func animationOffset(with geometry: GeometryProxy) -> CGFloat {
        animate ?
        geometry.size.width / 2.0 + config.shadowWidth
        : -geometry.size.width / 2.0 - config.shadowWidth
    }
}

struct AGShadowLoader_Previews: PreviewProvider {
    static var previews: some View {
        AGShadowLoader()
            .frame(height: 20)
        AGShadowLoader(config: .myAwesomeConfig)
            .frame(height: 30)
    }
}

extension AGShadowLoader.AGShadowLoaderConfig {
    static var myAwesomeConfig: AGShadowLoader.AGShadowLoaderConfig {
        AGShadowLoader.AGShadowLoaderConfig(
            backgroundColor: .blue,
            gradientColors: [.yellow, .green, .yellow], animationTime: 3,
            cornerRadius: 5,
            shadowWidth: 120
        )
    }
}
