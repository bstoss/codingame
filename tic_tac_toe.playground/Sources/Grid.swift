import Foundation

enum Mark {
    case Empty
    case Player
    case Enemy
}

enum GameStatus {
    case unfinished
    case enemyWin
    case playerWin
    case draw
}

typealias Position = (Int, Int)

struct Tile {
    let position: Position
    var mark: Mark
    
    var stringPos: String {
        return "\(position.0) \(position.1)"
    }
}

class Grid: Equatable {
    static func == (lhs: Grid, rhs: Grid) -> Bool {
        return lhs.position == rhs.position
    }
    
    let position: Position
    var mark: Mark
    
    var grid: [Int: [Int: Tile]] = [:]
    var turn: Mark = .Empty

    init(position: Position, mark: Mark) {
        for i in 0..<3 {
            var cols: [Int: Tile] = [:]
            for j in 0..<3 {
                let tile = Tile(position: (i,j), mark: .Empty)
                cols[j] = tile
            }
            grid[i] = cols
        }
        self.position = position
        self.mark = mark
    }
    
    func copy() -> Grid {
        let newGrid = Grid(position: position, mark: mark)
        newGrid.turn = turn
        newGrid.grid = grid
        return newGrid
    }

    func validMoves() -> [Tile] {
        var tiles = [Tile]()

        for i in 0..<3 {
            for j in 0..<3 {
                if let tile = grid[i]?[j], tile.mark == .Empty {
                    tiles.append(tile)
                }
            }
        }

        return tiles
    }

    func gameStatus() -> GameStatus {
        
        guard mark == .Empty else {
            return mark == .Enemy ? .enemyWin : .playerWin
        }
        
        let row0 = grid[0]!
        let row1 = grid[1]!
        let row2 = grid[2]!
        
        var whoWon: GameStatus = .unfinished
        
        for i in 0..<3 {
            if grid[i]![0]!.mark != .Empty && grid[i]![0]!.mark == grid[i]![1]!.mark && grid[i]![1]!.mark == grid[i]![2]!.mark {
                whoWon = grid[i]![0]!.mark == .Enemy ? .enemyWin : .playerWin
            }
            
            if  row0[i]!.mark != .Empty && row0[i]!.mark == row1[i]!.mark && row1[i]!.mark == row2[i]!.mark {
                whoWon =  row0[i]!.mark == .Enemy ? .enemyWin : .playerWin
            }
        }
        
        if row0[0]!.mark != .Empty && row0[0]!.mark == row1[1]!.mark && row1[1]!.mark == row2[2]!.mark {
            whoWon =  row0[0]!.mark == .Enemy ? .enemyWin : .playerWin
        }
        
        if row0[2]!.mark != .Empty && row0[2]!.mark == row1[1]!.mark && row1[1]!.mark == row2[0]!.mark {
            whoWon =  row0[2]!.mark == .Enemy ? .enemyWin : .playerWin
        }

        switch whoWon {
        case .unfinished:
            return validMoves().count > 0 ? .unfinished : .draw
        case .enemyWin:
            mark = .Enemy
            return .enemyWin
        case .playerWin:
            mark = .Player
            return .playerWin
        case .draw:
            return .draw
        }
    }

    func makeMove(tile: Tile) {
        grid[tile.position.0]![tile.position.1]!.mark = turn
        turn = turn == .Player ? .Enemy : .Player
    }
    
    func undoMove(tile: Tile) {
        grid[tile.position.0]![tile.position.1]!.mark = .Empty
        turn = turn == .Player ? .Enemy : .Player
    }
    
    func winMoveAvailable(for player: Mark) -> Tile? {
        guard mark == .Empty else {
            return nil
        }
        let moves = validMoves()
        for move in moves {
            makeMove(tile: move)
            if gameStatus() == .unfinished {
                undoMove(tile: move)
            } else {
                undoMove(tile: move)
                return move
            }
        }
        
        return nil
    }

    func printBoard() {
        var printedGrid = ""
        for i in 0..<3 {
            var row = "|"
            for j in 0..<3 {
                switch grid[i]![j]!.mark {
                case .Empty:
                    row += " . |"
                case .Player:
                    row += " o |"
                case .Enemy:
                    row += " x |"
                }
            }

            printedGrid += row + "\n"
        }
        debug(printedGrid)
    }
}
