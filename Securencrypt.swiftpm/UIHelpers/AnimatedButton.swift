import SwiftUI

struct AnimatedButtonStyle: ButtonStyle {
    private let color: Color
    
    init(color: Color = .bedirPink) {
        self.color = color
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.system(size: 15, weight: .bold , design: .rounded))
            .padding(.all)
            .background(color)
            .cornerRadius(16)
            .shadow(radius: configuration.isPressed ? 5 : 10)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.5, blendDuration: 1), value: configuration.isPressed)
    }
}
