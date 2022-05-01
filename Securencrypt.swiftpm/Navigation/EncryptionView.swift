import SwiftUI

// On this page, you can learn basic information about encryption.
struct Encryption: View {
    var body: some View {
        GeometryReader { geoReader in
            HStack {
                Spacer()
                VStack{
                    Text("What is encryption?")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .padding()
                        .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                    DescriptionView(text: "Encryption is the method of encoding data. This method converts the original representation of the data into an alternative form known as ciphertext.", isCenter: true)
                    Text("Why is it needed?")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .padding()
                        .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                    DescriptionView(text: "Thanks to encryption, what is private to you stays private to you. As we live in the data age, protecting our data is an important issue.", isCenter: true)
                    Spacer()
                    NavigationLink(destination: CaesarCipherInfo()) {
                        Text("Next Step →")
                    }
                    .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                    .padding()
                }
                .navigationBarBackButtonHidden(true)
                .frame(width: geoReader.size.width / 1.8, alignment: .center)
                Spacer()
            }
        }
    }
}
