import SwiftUI

struct CaesarCipherGame: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var userData: UserData
    @State private var input = ""
    
    var body: some View {
        GeometryReader { geoReader in
            HStack {
                Spacer()
                VStack {
                    ScrollView(showsIndicators: false) {
                        Image(uiImage: UIImage(imageLiteralResourceName: "ancientRomanHelmet.png"))
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        Text("What did Caesar say here?")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                            .padding()
                        Text("D xvhz, D nvr, D xjilpzmzy.")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                        Text("Julius Caesar")
                            .font(.system(size: 25, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.center)
                        CaesarCipher(input: $input, inputPlaceholder: "Text", buttonText: "Let's Decrypt")
                            .padding()
                    }
                    Spacer()
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Text("← Previous Step")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                        Spacer()
                        NavigationLink(destination: SymmetricAsymmetric().environmentObject(userData)) {
                            Text("Next Step →")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                    }
                    .padding()
                    .frame(width: geoReader.size.width, alignment: .center)
                }
                .navigationBarBackButtonHidden(true)
                .frame(maxWidth: geoReader.size.width / 1.8)
                Spacer()
            }
        }
    }
}
