import SwiftUI

struct EverythingCanBeKey: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var userData: UserData
    let size = UIScreen.main.bounds.size
    @State private var secretText = "******"
    @State private var isTextEncrypted = false
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    
    var body: some View {
        GeometryReader { geoReader in
            HStack {
                Spacer()
                VStack {
                    ZStack {
                        CameraView(thumbsUpHandler: {
                            if isTextEncrypted == false {
                                isTextEncrypted.toggle()
                                showMessages()
                            }
                        })
                        .mask(RoundedRectangle(cornerRadius: 25))
                        
                        VStack {
                            Text("Thumbs Up")
                                .font(.system(size: 50, weight: .bold, design: .rounded))
                                .padding(.bottom)
                                .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                            DescriptionView(text: "In this section, you will decode ciphertext using your body! Because the password is a hand sign, thumbs up! We thank Apple's Vision framework developers for allowing us to do this.", isCenter: true)
                                .padding([.leading, .trailing])
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                            Text("↓")
                                .font(.system(size: 50, weight: .bold, design: .rounded))
                                .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                            Text(secretText)
                                .font(.system(size: 50, weight: .bold, design: .rounded))
                                .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                        }
                    }
                    Spacer()
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Text("← Previous Step")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                        Spacer()
                        NavigationLink(destination: Congratulations().environmentObject(userData)) {
                            Text("Next Step →")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                    }
                    .padding()
                    .frame(width: geoReader.size.width, alignment: .center)
                }
                .navigationBarBackButtonHidden(true)
                .frame(width: geoReader.size.width / 1.8, alignment: .center)
                //.alignmentGuide(HorizontalAlingment.center, computeValue: { d in d[HorizontalAlignment.center]})
                Spacer()
            }
        }
    }
    func showMessages() {
        for i in 0...360 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.02, execute: {
                withAnimation {
                    secretText = "\(alphabet.randomElement()!)" + "\(alphabet.randomElement()!)" + "\(alphabet.randomElement()!)" + "\(alphabet.randomElement()!)" + "\(numbers.randomElement()!)" + "\(numbers.randomElement()!)"
                }
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (360 * 0.02 + 0.5), execute: {
            withAnimation {
                secretText = "WWDC22"
            }
        })
    }
}
