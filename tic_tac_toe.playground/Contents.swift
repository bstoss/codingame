import UIKit

func randomItem<T>(fromArray a: Array<T>) -> T {
    var rng = SystemRandomNumberGenerator()
    let randomInt = Int.random(in: 0..<a.count, using: &rng)
    return a[randomInt]
    // does not work on server side swift
//    let index = Int(arc4random_uniform(UInt32(a.count)))
//    return a[index]
}

enum Mark {
    case Empty
    case Player
    case Enemy
}

enum GameStatus {
    case unfinished
    case win
    case lose
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
                return grid[i]![0]!.mark == .Enemy ? .lose : .win
            }
            
            if  row0[i]!.mark != .Empty && row0[i]!.mark == row1[i]!.mark && row1[i]!.mark == row2[i]!.mark {
                return row0[i]!.mark == .Enemy ? .lose : .win
            }
            
        }
        
        
        if row0[0]!.mark != .Empty && row0[0]!.mark == row1[1]!.mark && row1[1]!.mark == row2[2]!.mark {
            return row0[0]!.mark == .Enemy ? .lose : .win
        }
        
        if row0[2]!.mark != .Empty && row0[2]!.mark == row1[1]!.mark && row1[1]!.mark == row2[0]!.mark {
            return row0[2]!.mark == .Enemy ? .lose : .win
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

struct Solver {

    func playRandom(grid: Grid) -> GameStatus {
        var gameStatus = grid.gameStatus()

        guard gameStatus == .unfinished else {
            return gameStatus
        }

        while gameStatus == .unfinished {
            let moves = grid.validMoves()
            guard !moves.isEmpty else {
                return gameStatus // wtf ...
            }
            let move = randomItem(fromArray: moves)
            //print(move)
            grid.makeMove(tile: move)

            //grid.printBoard()
            gameStatus = grid.gameStatus()
        }

        return gameStatus
    }
    
    func simulate(grid: Grid, repeatSim: Int = 100) -> [GameStatus: Int] {
        
        var count: [GameStatus: Int] = [.win: 0,
                                        .lose:0,
                                        .draw:0]
        for _ in 0..<repeatSim {
            let copyGrid = grid.copy()
            count[playRandom(grid: copyGrid)]! += 1
        }
        
        return count
    }
    
    func evaluateMoves(grid: Grid) -> [String: [GameStatus: Int]] {
        let moves = grid.validMoves()
        var moveResult: [String: [GameStatus: Int]] = [:]
        
        for move in moves {
            let copyGrid = grid.copy()
            copyGrid.makeMove(tile: move)
            moveResult[move.stringPos] = simulate(grid: copyGrid)
        }
        
        return moveResult
    }
    
    func chooseBestMove(grid: Grid) -> String {
        let result = solver.evaluateMoves(grid: grid)
        let sortedResult = result.sorted { lhs, rhs in
            lhs.value[GameStatus.win]! > rhs.value[GameStatus.win]!
        }
        
        return sortedResult.first!.key
    }

}

var grid = Grid()

grid.turn = .Player
grid.makeMove(tile: Tile(position: (1,1), mark: .Player))

grid.turn = .Enemy
grid.makeMove(tile: Tile(position: (0,1), mark: .Enemy))

grid.turn = .Player
grid.makeMove(tile: Tile(position: (0,0), mark: .Player))

grid.turn = .Enemy
grid.makeMove(tile: Tile(position: (2,1), mark: .Enemy))

grid.printBoard()

let solver = Solver()
//let gameResult = solver.playRandom(grid: grid)
//solver.simulate(grid: grid)
let result = solver.chooseBestMove(grid: grid)
grid.printBoard()
print(result)
//print(gameResult)

/*
 For the game
 

 var grid = Grid()
 let solver = Solver()
 //grid.printBoard()

 // game loop
 while true {

     let inputs = readLine()!.split(separator: " ")
     let opponentRow = Int(inputs[0])!
     let opponentCol = Int(inputs[1])!
     
    
     
     let validActionCount = Int(readLine()!)!
    // debug("validActionCount: \(validActionCount)")
    // debug("last opp action: \(opponentRow) \(opponentCol)")

     if validActionCount > 0 {
         for i in 0...(validActionCount-1) {
             let inputs = readLine()!.split(separator: " ")
             let row = Int(inputs[0])!
             let col = Int(inputs[1])!
             
             //debug("valid action: \(row) \(col)")
         }
     }
     
     if opponentRow != -1 {
         grid.turn = .Enemy
         grid.makeMove(tile: Tile(position: (opponentRow, opponentCol), mark: .Enemy))
         //grid.printBoard()
         let result = solver.chooseBestMove(grid: grid)

         // Write an action using print("message...")
         // To debug: print("Debug messages...", to: &errStream)
         let move = result.split(separator: " ")
         grid.makeMove(tile: Tile(position: (Int(move[0])!, Int(move[1])!), mark: .Player))

         print(result)

     } else {
         grid.turn = .Player
         grid.makeMove(tile: Tile(position: (1, 1), mark: .Player))
         grid.printBoard()
         print("1 1")
     }
 }
 */
