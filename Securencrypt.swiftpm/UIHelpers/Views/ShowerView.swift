import SwiftUI 

struct ShowerView: UIViewRepresentable {
    @Binding var position: CGPoint
    var iconImageNames: [String]
    let droppingIconsLayer = CAEmitterLayer()
    
    init(imageNames: [String], position: Binding<CGPoint>) {
        self._position = position
        self.iconImageNames = imageNames
    }
    
    func makeUIView(context: Context) -> UIView {
        let size = UIScreen.main.bounds.size
        let host = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        
        droppingIconsLayer.frame = CGRect(x: 0.0, y: 0.0, width: size.width + size.width/2 , height: size.height)
        
        host.layer.addSublayer(droppingIconsLayer)
        host.layer.masksToBounds = true
        
        droppingIconsLayer.emitterShape = .circle
        droppingIconsLayer.emitterSize = size
        droppingIconsLayer.emitterPosition = CGPoint(x: size.width / 2 + 125, y: -800)
        droppingIconsLayer.emitterMode = .surface
        droppingIconsLayer.renderMode = .oldestLast
        
        var cells: [CAEmitterCell] = []
        
        for name in iconImageNames {
            let image = UIImage(named: "\(name)")?.cgImage
            
            let cell = CAEmitterCell()
            cell.contents = image
            cell.birthRate = 17.5
            cell.lifetime = 100.0
            cell.velocity = 0.0
            cell.velocityRange = 0.0
            cell.xAcceleration = 0.0
            cell.yAcceleration = 15.0
            cell.emissionRange = 180.0 * (.pi / 180.0)
            cell.spin = -28.6 * (.pi / 180.0)
            cell.spinRange = 57.2 * (.pi / 180.0)
            cell.scale = 0.06
            cell.scaleRange = 0.3
            
            cells.append(cell)
        }
        
        droppingIconsLayer.emitterCells = cells
        
        return host
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    typealias UIViewType = UIView
}

