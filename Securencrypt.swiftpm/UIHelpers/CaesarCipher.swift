import SwiftUI

final class UserData: ObservableObject {
    init() { }
    @AppStorage("givenName") var givenName: String = ""
}

struct CaesarCipher: View {
    @Binding private var input: String
    @State private var shiftCountString = "5"
    @State private var output = ""
    
    let inputPlaceholder: String
    let buttonText: String
    
    init(input: Binding<String>, inputPlaceholder: String, buttonText: String) {
        self._input = input
        self.inputPlaceholder = inputPlaceholder
        self.buttonText = buttonText
    }
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(UIColor.systemTeal))
                        .opacity(0.5)
                    TextField(inputPlaceholder, text: $input)
                        .disableAutocorrection(true)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .padding()
                }
                .frame(maxHeight: 15)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(UIColor.systemPink))
                        .opacity(0.5)
                    TextField("Shift", text: $shiftCountString)
                        .disableAutocorrection(true)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .padding()
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: 70, maxHeight: 15)
                Button(action: buttonAction) {
                    Label(buttonText, systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(AnimatedButtonStyle())
            }
            Text(output)
                .font(.system(size: 22.5, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
        }
    }
    
    func buttonAction() {
        if !input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !input.contains("⠀") {
            withAnimation{
                output = "\(caesarEncrypt(message: input, shift: Int(shiftCountString) ?? 0)) → The letters in your text have a shift of \(Int(shiftCountString) ?? 0) steps."
            }
        }
    }
    
    func caesarEncrypt(message: String, shift: Int) -> String {
        
        func shiftLetter(ucs: UnicodeScalar) -> UnicodeScalar {
            let firstLetter = Int(UnicodeScalar("A").value)
            let lastLetter = Int(UnicodeScalar("Z").value)
            let letterCount = lastLetter - firstLetter + 1
            
            let value = Int(ucs.value)
            switch value {
            case firstLetter...lastLetter:
                // Offset relative to first letter:
                var offset = value - firstLetter
                // Apply shift amount (can be positive or negative):
                offset += shift
                // Transform back to the range firstLetter...lastLetter:
                offset = (offset % letterCount + letterCount) % letterCount
                // Return corresponding character:
                return UnicodeScalar(firstLetter + offset)!
            default:
                // Not in the range A...Z, leave unchanged:
                return ucs
            }
        }
        
        let msg = message.uppercased()
        return String(String.UnicodeScalarView(msg.unicodeScalars.map(shiftLetter)))
    }
}

