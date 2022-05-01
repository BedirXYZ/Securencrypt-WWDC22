import SwiftUI

extension View {
    func gradientTitleText(colors: [Color]) -> some View {
        self
            .overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}
