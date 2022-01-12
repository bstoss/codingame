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

class Grid {

    var grid: [Int: [Int: Tile]] = [:]
    var turn: Mark = .Empty

    init() {
        for i in 0..<3 {
            var cols: [Int: Tile] = [:]
            for j in 0..<3 {
                let tile = Tile(position: (i,j), mark: .Empty)
                cols[j] = tile
            }
            grid[i] = cols
        }
    }
    
    func copy() -> Grid {
        let newGrid = Grid()
        newGrid.turn = turn
        newGrid.grid = grid
        return newGrid
    }

    func validMoves() -> [Tile] {
        var tiles = [Tile]()

        for i in 0..<3 {
            for j in 0..<3 {
                if let tile = grid[j]?[i], tile.mark == .Empty {
                    tiles.append(tile)
                }
            }
        }

        return tiles
    }

    func gameStatus() -> GameStatus {
        
        let row0 = grid[0]!
        let row1 = grid[1]!
        let row2 = grid[2]!
        
        for i in 0..<3 {
            if grid[i]![0]!.mark != .Empty && grid[i]![0]!.mark == grid[i]![1]!.mark && grid[i]![1]!.mark == grid[i]![2]!.mark {
                return grid[i]![0]!.mark == .Enemy ? .enemyWin : .playerWin
            }
            
            if  row0[i]!.mark != .Empty && row0[i]!.mark == row1[i]!.mark && row1[i]!.mark == row2[i]!.mark {
                return row0[i]!.mark == .Enemy ? .enemyWin : .playerWin
            }
        }
        
        if row0[0]!.mark != .Empty && row0[0]!.mark == row1[1]!.mark && row1[1]!.mark == row2[2]!.mark {
            return row0[0]!.mark == .Enemy ? .enemyWin : .playerWin
        }
        
        if row0[2]!.mark != .Empty && row0[2]!.mark == row1[1]!.mark && row1[1]!.mark == row2[0]!.mark {
            return row0[2]!.mark == .Enemy ? .enemyWin : .playerWin
        }

        return validMoves().count > 0 ? .unfinished : .draw
    }

    func makeMove(tile: Tile) {
        grid[tile.position.0]![tile.position.1]!.mark = turn
        turn = turn == .Player ? .Enemy : .Player
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
        print(printedGrid)
    }
}
