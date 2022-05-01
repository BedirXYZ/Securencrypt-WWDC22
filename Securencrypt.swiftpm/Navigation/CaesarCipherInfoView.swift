import SwiftUI

// To read the secret messages of Julius Caesar, you need to get information from this page!
struct CaesarCipherInfo: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var userData = UserData()
    @State private var shiftCountString = "5"
    @State private var resultName       = ""
    
    var body: some View {
        GeometryReader { geoReader in
            HStack {
                Spacer()
                VStack {
                    ScrollView(showsIndicators: false) {
                        Image(uiImage: UIImage(imageLiteralResourceName: "caesarCipherMachine"))
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 125)
                        Text("Caesar Cipher")
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                            .padding()
                            .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                        Text("The Caesar cipher is where each letter is replaced by another letter located a little further in the alphabet. For example, if we want to shift the word \"WWDC\" 1 time, the result will be \"XXED\" ciphertext.")
                            .font(.system(size: 22.5, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .opacity(0.2)
                            )
                        Text("Let's Try")
                            .font(.system(size: 40, weight: .semibold, design: .rounded))
                        CaesarCipher(input: $userData.givenName, inputPlaceholder: "Given Name", buttonText: "Let's Encrypt")
                    }
                    Spacer()
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Text("← Previous Step")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                        Spacer()
                        NavigationLink(destination: CaesarCipherGame().environmentObject(userData)) {
                            Text("Next Step →")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                    }
                    .padding()
                    .frame(width: geoReader.size.width, alignment: .center)
                }
                .navigationBarBackButtonHidden(true)
                .frame(width: geoReader.size.width / 1.8, alignment: .center)
                Spacer()
            }
        }
    }
}
