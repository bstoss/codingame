import Foundation

struct Solver {
    
    var inteligence = 100
    
    func randomItem<T>(fromArray a: Array<T>) -> T {
        var rng = SystemRandomNumberGenerator()
        let randomInt = Int.random(in: 0..<a.count, using: &rng)
        return a[randomInt]
        // does not work on server side swift
        // let index = Int(arc4random_uniform(UInt32(a.count)))
        // return a[index]
    }

    
    func playRandom(grid: Grid) -> (GameStatus, Int) {
        var gameStatus = grid.gameStatus()

        guard gameStatus == .unfinished else {
            return (gameStatus, 0)
        }
        var steps = 0
        while gameStatus == .unfinished {
            let moves = grid.validMoves()
            guard !moves.isEmpty else {
                return (gameStatus, steps) // wtf ...
            }
            let move = randomItem(fromArray: moves)
            //print(move)
            grid.makeMove(tile: move)
            steps += 1
            //grid.printBoard()
//            print(grid.turn)
//            print(grid.printBoard())
            gameStatus = grid.gameStatus()
        }

        return (gameStatus, steps)
    }
    
    func simulate(grid: Grid) -> ([GameStatus: Int], [GameStatus: Int]) {
        
        // TODO: Add amount of moves
        var count: [GameStatus: Int] = [.playerWin: 0,
                                        .enemyWin: 0,
                                        .draw: 0]
        
        var moves: [GameStatus: Int] = [.playerWin: 0,
                                        .enemyWin: 0,
                                        .draw: 0]
        
//        print(grid.turn)
//        print(grid.printBoard())
        for _ in 0..<inteligence {
            let copyGrid = grid.copy()
//            print(copyGrid.turn)
//            print(copyGrid.printBoard())
            let randomGame = playRandom(grid: copyGrid)
            count[randomGame.0]! += 1
            moves[randomGame.0]! += randomGame.1
        }
        moves[.playerWin]! /= inteligence
        moves[.enemyWin]! /= inteligence
        moves[.draw]! /= inteligence
        
        
        return (count, moves)
    }
    
    func evaluateMoves(grid: Grid) -> [String: ([GameStatus: Int], [GameStatus: Int])] {
        let moves = grid.validMoves()
        var moveResult: [String: ([GameStatus: Int], [GameStatus: Int])] = [:]
        
        for move in moves {
            let copyGrid = grid.copy()
//            print("MOVE: \(move)")
           
            copyGrid.makeMove(tile: move)
            moveResult[move.stringPos] = simulate(grid: copyGrid)
        }
        
        return moveResult
    }
    
    func chooseBestMove(grid: Grid) -> [Int] {
        let forPlayer = grid.turn
        let result = evaluateMoves(grid: grid)
        
        let sortedResult = result.sorted { lhs, rhs in
            if forPlayer == .Player {
                if lhs.value.1[.playerWin]! == rhs.value.1[.playerWin]! {
                    return lhs.value.0[.playerWin]! > rhs.value.0[.playerWin]!
                } else {
                    return lhs.value.1[.playerWin]! < rhs.value.1[.playerWin]!
                }
                
            } else {
                if lhs.value.1[.enemyWin]! == rhs.value.1[.enemyWin]! {
                    return lhs.value.0[.enemyWin]! > rhs.value.0[.enemyWin]!
                } else {
                    return lhs.value.1[.enemyWin]! < rhs.value.1[.enemyWin]!
                }
            }
        }
        
        for result in sortedResult {
            //print("move: \(result.key) - won: \(result.value.0) - steps: \(result.value.1)")
        }
//
        return sortedResult.first!.key.split(separator: " ").map({ Int($0)! })
    }

}
