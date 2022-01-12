import UIKit

class BoardView : UIView {
    var size: Int = 3
    var tileSize: CGFloat = 55.0
    var padding: CGFloat = 6.0
    var tiles: Dictionary<IndexPath, TileView>
    let animationDuration: TimeInterval = 0.08
    
    var addBlock: ((Position) -> Void) = { _ in }
        
    init(size s: Int, width: CGFloat) {
        size = s
        tiles = Dictionary()
        padding = size > 6 ? 4.0 : padding
        tileSize = (width - padding * CGFloat(size + 1)) / CGFloat(size)

        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        self.layer.cornerRadius = 8.0
        self.backgroundColor = .brown
        var xCursor = padding
        var yCursor: CGFloat
        for i in 0..<size {
            yCursor = padding
            for j in 0..<size {
                let backgroundButton = BackgroundButton(position: (j,i), frame: CGRect(x: xCursor, y: yCursor, width: tileSize, height: tileSize))
//                let background = UIView(frame: CGRect(x: xCursor, y: yCursor, width: tileSize, height: tileSize))
                backgroundButton.layer.cornerRadius = 5.0
                backgroundButton.backgroundColor = UIColor.init(white: 1.0, alpha: 0.2)
                addSubview(backgroundButton)
                backgroundButton.addTarget(self, action: #selector(self.tilePressed(_:)), for: .touchUpInside)
//                backgroundButton.setTitle( "\(j)-\(i)", for: .normal)
                yCursor += padding + tileSize
            }
            xCursor += padding + tileSize
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    
    @objc
    func tilePressed(_ sender: BackgroundButton) {
        insertTile(at: sender.position, owned: .Player)
        addBlock(sender.position)
    }
    
    func reset() {
        for (_, tile) in tiles {
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepingCapacity: true)
    }
    
    func insertTile(at pos: Position, owned: Mark) {
        let (i, j) = pos
        let y = padding + CGFloat(i)*(tileSize + padding)
        let x = padding + CGFloat(j)*(tileSize + padding)
        let tile = TileView(position: CGPoint(x: x, y: y), size: tileSize, owned: owned)
        tile.layer.setAffineTransform(CGAffineTransform(scaleX: 0, y: 0))
        
        addSubview(tile)
        bringSubviewToFront(tile)
        tiles[IndexPath(row: i, section: j)] = tile
        
        UIView.animate(withDuration: animationDuration * 3.0, delay: 0.0, options: .curveEaseOut,
                       animations: {
                        tile.layer.setAffineTransform(CGAffineTransform(scaleX: 1.0, y: 1.0))
        })

    }
}
