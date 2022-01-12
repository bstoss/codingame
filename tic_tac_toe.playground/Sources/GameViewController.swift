import UIKit
import Foundation


public class GameViewController : UIViewController {
    
    var boardView: BoardView?
    var grid = Grid()
    var solver = Solver()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override public func viewDidLoad()  {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white
        
        let boardView = BoardView(size: 3, width: 300)
        boardView.addBlock = { position in
            self.grid.turn = .Player
            self.grid.makeMove(tile: Tile(position: position, mark: .Player))
            self.aiMove()
            self.grid.printBoard()
        }
        self.view.addSubview(boardView)
        self.boardView = boardView
        boardView.center = CGPoint(x: view.bounds.midX, y: 200)
        boardView.autoresizingMask = [.flexibleLeftMargin]
    }
    
    @objc func reset() {
        grid = Grid()
        grid.turn = .Player
        boardView!.reset()
    }
    
    func aiMove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        guard self.grid.gameStatus() == .unfinished else {
            return
        }
            self.grid.turn = .Enemy
            let result = self.solver.chooseBestMove(grid: self.grid)
            let position = (result[0], result[1])
            self.boardView?.insertTile(at: position, owned: .Enemy)
            self.grid.makeMove(tile: Tile(position: position, mark: .Enemy))
        }
    }
}
