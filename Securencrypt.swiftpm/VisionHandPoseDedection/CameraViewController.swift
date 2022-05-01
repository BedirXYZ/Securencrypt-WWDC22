import UIKit
import AVFoundation
import Vision

final class CameraViewController: UIViewController {
    private var cameraView: CameraPreview { view as! CameraPreview }
    private let videoDataOutputQueue = DispatchQueue(
        label: "CameraFeedOutput",
        qos: .userInteractive
    )
    private var cameraFeedSession: AVCaptureSession?
    private let handPoseRequest: VNDetectHumanHandPoseRequest = {
        let request = VNDetectHumanHandPoseRequest()
        request.maximumHandCount = 2
        return request
    }()
    
    var thumbsUpHandler: (() -> Void)?
    
    private var orientation: UIInterfaceOrientation {
        // Not using UIDevice for orientation as it can return incorrect values when the app is first launched.
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.interfaceOrientation ?? .portrait
    }
    
    override func loadView() {
        view = CameraPreview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        do {
            if cameraFeedSession == nil {
                try setupAVSession()
                cameraView.previewLayer.session = cameraFeedSession
                cameraView.previewLayer.videoGravity = .resizeAspectFill
            }
            cameraFeedSession?.startRunning()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cameraFeedSession?.stopRunning()
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fixDeviceOrientation()
        self.cameraView.previewLayer.frame = self.view.frame
    }
    
    private func fixDeviceOrientation() {
        if let connection = cameraView.previewLayer.connection {
            let previewLayerConnection: AVCaptureConnection = connection
            if previewLayerConnection.isVideoOrientationSupported {
                previewLayerConnection.videoOrientation = AVCaptureVideoOrientation(rawValue: orientation.rawValue) ?? .portrait
            }
            self.cameraView.previewLayer.frame = self.view.frame
        }
    }
    
    func setupAVSession() throws {
        guard let videoDevice = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front)
        else {
            throw VisionError.captureSessionSetup(
                reason: "Could not find a front facing camera."
            )
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(
            device: videoDevice
        ) else {
            throw VisionError.captureSessionSetup(
                reason: "Could not create video device input."
            )
        }
        
        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.high
        
        guard session.canAddInput(deviceInput) else {
            throw VisionError.captureSessionSetup(
                reason: "Could not add video device input to the session"
            )
        }
        session.addInput(deviceInput)
        
        let dataOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
            dataOutput.alwaysDiscardsLateVideoFrames = true
            dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            throw VisionError.captureSessionSetup(
                reason: "Could not add video data output to the session"
            )
        }
        session.commitConfiguration()
        cameraFeedSession = session
    }
}



extension
CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        
        var fingerTips: [CGPoint] = []
        print(fingerTips)
        
        let handler = VNImageRequestHandler(
            cmSampleBuffer: sampleBuffer,
            orientation: .up,
            options: [:]
        )
        do {
            
            try handler.perform([handPoseRequest])
            
            guard
                let results = handPoseRequest.results?.prefix(2),
                !results.isEmpty
            else {
                return
            }
            
            let recognizedPoints: [VNRecognizedPoint] = []
            
            try results.forEach { observation in
                let fingers = try observation.recognizedPoints(.all)
                if let little = fingers[.littleMCP], let ring = fingers[.ringMCP], let middle = fingers[.middleMCP], let index = fingers[.indexMCP], let thumbTip = fingers[.thumbTip] {
                    var littleY = little.location.y
                    let ringY = ring.location.y
                    var middleY = middle.location.y
                    let indexY = index.location.y
                    var thumpTipY = thumbTip.location.y
                    
                    print(littleY, ringY, middleY, indexY, thumpTipY)
                    
                    if orientation == .landscapeRight {
                        littleY *= -1
                        middleY *= -1
                        thumpTipY *= -1
                    }
                    
                    if littleY < middleY, middleY < thumpTipY {
                        thumbsUpHandler!()
                    }
                }
            }
            
            fingerTips = recognizedPoints.filter {
                $0.confidence > 0.9
            }
            .map {
                CGPoint(x: $0.location.x, y: 1 - $0.location.y)
            }
        } catch {
            cameraFeedSession?.stopRunning()
            print(error.localizedDescription)
        }
    }
}
