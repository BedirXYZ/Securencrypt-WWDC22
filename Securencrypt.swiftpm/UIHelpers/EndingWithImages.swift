import UIKit
import SwiftUI
import Combine

struct ImageIterator: View {
    @State private var currentImageIndex = 0
    private let imageNames: [String]
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(imageNames: [String], iterationInterval: Double = 1.5) {
        self.imageNames = imageNames
        timer = Timer.publish(every: iterationInterval, on: .main, in: .common).autoconnect()
    }
    
    var body: some View {
        Image(uiImage: UIImage(imageLiteralResourceName: imageNames[currentImageIndex]))
            .resizable()
            .scaledToFit()
            .shadow(color: .white, radius: 15)
            .transition(.opacity)
            .id(currentImageIndex.description)
            .onReceive(timer) { _ in 
                if currentImageIndex < imageNames.endIndex - 1 {
                    withAnimation { currentImageIndex += 1 }
                } else {
                    withAnimation { currentImageIndex = 0 }
                }
            }
    }
}
