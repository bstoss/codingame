import UIKit

class BackgroundButton: UIButton {
    let position: Position
    
    required init(position: Position, frame: CGRect) {
        self.position = position

        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
