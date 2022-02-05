import UIKit
import Foundation


public class GameViewController : UIViewController {
    
    var boardView: BoardView?
    var grid = Grid(position: (0,0), mark: .Empty)
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
            self.grid.printBoard()
            self.aiMove()
            
        }
        self.view.addSubview(boardView)
        self.boardView = boardView
        boardView.center = CGPoint(x: view.bounds.midX, y: 200)
        boardView.autoresizingMask = [.flexibleLeftMargin]
        
        let resAction = UIAction(title: "Reset") { _ in
            self.reset()
        }
        let reset = UIButton(type: .system, primaryAction: resAction)
        reset.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(reset)
        reset.centerXAnchor.constraint(equalTo: boardView.centerXAnchor).isActive = true
        reset.topAnchor.constraint(equalTo: boardView.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func reset() {
        grid = Grid(position: (0,0), mark: .Empty)
        grid.turn = .Player
        boardView!.reset()
    }
    
    func aiMove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
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
