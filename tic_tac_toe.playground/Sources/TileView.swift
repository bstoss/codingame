import UIKit

class TileView : UIView {
    let label : UILabel

    var owned : Mark = .Empty {
        didSet {
            label.textColor = owned == .Player ? UIColor.green : UIColor.red
            label.text = "\(owned == .Player ? "x" : "o")"
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(position: CGPoint, size: CGFloat, owned o: Mark) {
        self.owned = o
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: size, height: size))
        self.label.textColor = owned == .Player ? UIColor.green : UIColor.red
        self.label.text = "\(owned == .Player ? "o" : "x")"
        self.label.font = UIFont.systemFont(ofSize: 64, weight: UIFont.Weight.heavy)
        self.label.textAlignment = NSTextAlignment.center
        
        super.init(frame: CGRect(x: position.x, y: position.y, width: size, height: size))
        
        self.addSubview(label)
        self.layer.cornerRadius = 5.0
    }
}
