import SwiftUI

struct AESEncryption: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        GeometryReader { geoReader in
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("AES Encryption")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .padding(.top)
                        .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                    Text("An Example for Symmetric Encryption")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .padding(.bottom)
                        .gradientTitleText(colors: [Color(UIColor.systemIndigo), .bedirPink])
                    Image(uiImage: UIImage(imageLiteralResourceName: "symmetric.png"))
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.bottom)
                    DescriptionView(text: "The Advanced Encryption Standard is a specification for the encryption of electronic data set by the U.S. National Institute of Standards and Technology in 2001. AES-256, which has a key length of 256 bits, supports the largest bit size and is basically unbreakable (984,665,640,564,039,457,584,007,913,129,639,936 combinations) by brute force based on existing computing ability, making it the strongest encryption standard.", isCenter: true)
                    Spacer()
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Text("← Previous Step")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                        Spacer()
                        NavigationLink(destination: SSLCertificate().environmentObject(userData)) {
                            Text("Next Step →")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                    }
                    .padding()
                    .frame(width: geoReader.size.width, alignment: .center)
                }
                .navigationBarBackButtonHidden(true)
                .frame(width: geoReader.size.width / 1.4, alignment: .center)
                Spacer()
            }
        }
    }
}
