import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    var thumbsUpHandler: (() -> Void)
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let cvc = CameraViewController()
        cvc.thumbsUpHandler = thumbsUpHandler
        return cvc
    }
    
    func updateUIViewController(
        _ uiViewController: CameraViewController,
        context: Context
    ) {
    }
}
