import SwiftUI

struct SSLCertificate: View {
    @State private var messageIndex: Int = 0
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var userData: UserData
    var body: some View {
        GeometryReader { geoReader in
            HStack {
                Spacer()
                VStack {
                    Text("SSL Certificate")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .padding(.top)
                        .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                    Text("An Example for Asymmetric Encryption")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .gradientTitleText(colors: [Color(UIColor.systemIndigo), .bedirPink])
                    Text("SSL keeps internet connections secure and prevents criminals from reading or modifying information transferred between two systems.")
                        .font(.system(size: 22.5, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .opacity(0.2)
                        )
                    VStack {
                        HStack {
                            Image(systemName: "lock.fill")
                                .padding()
                            Text("ilovecoding.hooray")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 15, weight: .bold , design: .rounded))
                            Button("Go to the Website"){
                                showMessages()
                            }
                            .padding()
                            .font(.system(size: 15, weight: .bold , design: .rounded))
                            .background(Color.bedirMint)
                            .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(25)
                        .padding([.leading, .top, .trailing])
                        VStack {
                            Spacer()
                            if messageIndex > 0 {
                                Image(uiImage: UIImage(imageLiteralResourceName: "1.png"))
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .transition(.move(edge: .trailing))
                            }
                            if messageIndex > 1 {
                                Image(uiImage: UIImage(imageLiteralResourceName: "2.png"))
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .transition(.move(edge: .leading))
                            }
                            if messageIndex > 2 {
                                Image(uiImage: UIImage(imageLiteralResourceName: "3.png"))
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .transition(.move(edge: .trailing))
                            }
                            if messageIndex > 3 {
                                Image(uiImage: UIImage(imageLiteralResourceName: "4.png"))
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .transition(.move(edge: .trailing))
                            }
                            if messageIndex > 4 {
                                Image(uiImage: UIImage(imageLiteralResourceName: "5.png"))
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .transition(.move(edge: .trailing))
                            }
                            if messageIndex > 5 {
                                Image(uiImage: UIImage(imageLiteralResourceName: "6.png"))
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .transition(.move(edge: .leading))
                            }
                            if messageIndex > 6 {
                                Image(uiImage: UIImage(imageLiteralResourceName: "7.png"))
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .transition(.move(edge: .leading))
                            }
                            if messageIndex > 7 {
                                Image(uiImage: UIImage(imageLiteralResourceName: "8.png"))
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .transition(.move(edge: .trailing))
                            }
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .background(Color.bedirOrange)
                    .cornerRadius(25)
                    Spacer()
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Text("← Previous Step")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                        Spacer()
                        NavigationLink(destination: EverythingCanBeKey().environmentObject(userData)) {
                            Text("Next Step →")
                        }
                        .buttonStyle(AnimatedButtonStyle(color: .bedirMint))
                    }
                    .padding()
                    .frame(width: geoReader.size.width, alignment: .center)
                }
                .navigationBarBackButtonHidden(true)
                .frame(width: geoReader.size.width / 1.4, alignment: .center)
                .ignoresSafeArea(edges: [.top])
                Spacer()
            }
        }
    }
    func showMessages() {
        for i in 0...9 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 2, execute: {
                withAnimation {
                    messageIndex += 1
                }
            })
        }
    }
}
