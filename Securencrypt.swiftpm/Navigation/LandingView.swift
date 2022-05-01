import SwiftUI

// This is the landing page of my app. Getting the security objects in the background to fall was the most enjoyable part.
struct Landing: View {
    @State private var isNavigationActive = false
    
    @State private var viewState = CGSize.zero
    @State private var sfSymbolName = "lock.fill"
    let animationImages = ["padlock", "key", "mobileapp"]
    
    var body: some View {
        ZStack {
            ShowerView(imageNames: animationImages, position: .constant(CGPoint(x: viewState.width, y: viewState.height)))
                .ignoresSafeArea()
            VStack {
                NavigationLink(destination: Encryption(), isActive: $isNavigationActive) { EmptyView() }
                Image(systemName: sfSymbolName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 50, maxHeight: 50)
                    .shadow(radius: 10)
                Text("Securencrypt")
                    .font(.system(size: 50, weight: .bold , design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .shadow(radius: 10)
                Button(action: unlockEffect) {
                    Label("Unlock ", systemImage: "key.fill")
                }
                .buttonStyle(AnimatedButtonStyle())
            }
        }
    }
    func unlockEffect() {
        withAnimation {
            sfSymbolName = "lock.open.fill"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isNavigationActive = true
        }
    }
}
