import SwiftUI

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    let forWhat: [String:String] = ["Mehmet Bertan Tarakçıoğlu": "For educating me about the Swift.",
                                    "Mustafa Efe Üçer": "For educating me about the coordinate system.",
                                    "Oğuzhan Çetinkaya": "For supporting me about the coding.",
                                    "Vijay Verma": "For super-duper 3D icons."]
    
    var body: some View {
        Text("Thanks")
            .font(.system(size: 50, weight: .bold, design: .rounded))
            .padding()
            .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
        ForEach(forWhat.sorted(by: <), id: \.key) { key, value in
            Text(key)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(value)
                .font(.title)
                .padding(.bottom)
        }
        Button("Cancel") {
            withAnimation {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .font(.title)
        .padding(.bottom)
    }
}

struct Congratulations: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var userData: UserData
    @State private var viewState = CGSize.zero
    let animationImages = ["padlock", "key", "mobileapp"]
    @State private var showingThanks = false
    @State private var showingDeletedAlert = false
    
    private var congratsString: String {
        if userData.givenName.isEmpty {
            return "Congratulations!"
        }else {
            return "Congratulations, \(userData.givenName)!"
        }
    }
    
    var body: some View {
        GeometryReader { geoReader in
            ZStack{
                ShowerView(imageNames: animationImages, position: .constant(CGPoint(x: viewState.width, y: viewState.height)))
                    .ignoresSafeArea()
                HStack {
                    Spacer()
                    VStack {
                        VStack {
                            ImageIterator(imageNames: ["Memoji-1.png", "Memoji-2.png", "Memoji-3.png"])
                                .frame(height: UIScreen.main.bounds.height / 3)
                            Text(congratsString)
                                .font(.system(size: 50, weight: .bold, design: .rounded))
                                .padding(.bottom)
                                .gradientTitleText(colors: [.bedirPink, Color(UIColor.systemIndigo)])
                            DescriptionView(text: "The app is finished. Hopefully, you've understood what encryption is and how encryption works. Thanks for your interest!", isCenter: true)
                                .padding(.bottom)
                            HStack {
                                Button("Thanks") {
                                    withAnimation() {
                                        showingThanks.toggle()
                                    }
                                }
                                .buttonStyle(AnimatedButtonStyle())
                                .sheet(isPresented: $showingThanks) {
                                    SheetView()
                                }
                                Button(action: { showingDeletedAlert.toggle() }) {
                                    Label("Delete My Data", systemImage: "trash.circle.fill")
                                }
                                .buttonStyle(AnimatedButtonStyle())
                                .alert(isPresented: $showingDeletedAlert) {
                                    Alert(title: Text("Do you want to delete all your data?"),
                                          message: Text("All of your data on this app will be deleted and cannot be recovered. The app will stop running after your data is erased."),
                                          primaryButton: .destructive(Text("Delete My Data")) {
                                        userData.givenName = ""
                                    },
                                          secondaryButton: .cancel())
                                }
                            }
                        }
                        Spacer()
                    }
                    .navigationBarBackButtonHidden(true)
                    .frame(width: geoReader.size.width / 1.8, alignment: .center)
                    Spacer()
                }
            }
        }
    }
}
