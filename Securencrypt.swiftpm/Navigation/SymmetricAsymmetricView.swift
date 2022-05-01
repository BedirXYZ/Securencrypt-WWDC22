import SwiftUI

struct SymmetricAsymmetric: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var userData: UserData
    var body: some View {
        GeometryReader { geoReader in
            HStack {
                Spacer()
                VStack{
                    Text("Symmetric Encryption")
                        .font(.system(size: 42.5, weight: .bold, design: .rounded))
                        .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                    Image(uiImage: UIImage(imageLiteralResourceName: "symmetric.png"))
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 67.5)
                        .padding(.bottom)
                    DescriptionView(text: "Symmetric encryption is a type of encryption where only one secret key is used to both encrypt and decrypt information.", isCenter: true)
                    Text("Asymmetric Encryption")
                        .font(.system(size: 42.5, weight: .bold, design: .rounded))
                        .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                    Image(uiImage: UIImage(imageLiteralResourceName: "asymmetric.png"))
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 67.5)
                        .padding(.bottom)
                    DescriptionView(text: "Asymmetric encryption is a process that uses a pair of related keys, one  key and one private key, to encrypt and decrypt an information and protect it from unauthorized access or use.", isCenter: true)
                    Spacer()
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Text("← Previous Step")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                        Spacer()
                        NavigationLink(destination: AESEncryption().environmentObject(userData)) {
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
