import SwiftUI

struct DescriptionView: View {
    
    let text: String
    let isCenter: Bool
    
    init(text: String, isCenter: Bool) {
        self.text = text
        self.isCenter = isCenter
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 22.5, weight: .medium, design: .rounded))
            .multilineTextAlignment(self.isCenter ? .center : .leading)
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .opacity(0.2)
            )
    }
}

