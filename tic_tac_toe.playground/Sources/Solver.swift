import Foundation

struct PlayRandomResult {
    let gameStatus: GameStatus
    let moves: Int
}

struct SimResult {
    struct Result {
        var amount: Int = 0
        var averageMoves: Int = 0
    }
    
    var playerWon = Result()
    var enemyWon = Result()
    var draw = Result()
    
    var printedResult: String {
        return "PlayerWon: \(playerWon.amount) - Moves: \(playerWon.averageMoves)\nEnemyWon: \(enemyWon.amount) - Moves: \(enemyWon.averageMoves)\nDraw: \(draw.amount) - Moves: \(draw.averageMoves)\n"
    }
}

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

    
    func playRandom(grid: Grid) -> PlayRandomResult {
        var gameStatus = grid.gameStatus()

        guard gameStatus == .unfinished else {
            return PlayRandomResult(gameStatus: gameStatus, moves: 0)
        }
        var steps = 0
        while gameStatus == .unfinished {
            let moves = grid.validMoves()
            guard !moves.isEmpty else {
                return PlayRandomResult(gameStatus: gameStatus, moves: steps) // wtf ...
            }
            var move = randomItem(fromArray: moves)
            if moves.count <= 7 {
                if let winMove = grid.winMoveAvailable(for: grid.turn), moves.count <= 7 {
                    move = winMove
                }
            }
            
            //print(move)
            grid.makeMove(tile: move)
            steps += 1
            //grid.printBoard()
//            print(grid.turn)
//            print(grid.printBoard())
            gameStatus = grid.gameStatus()
        }
        
        let result = PlayRandomResult(gameStatus: gameStatus, moves: steps)

        return result
    }
    
    func simulate(grid: Grid) -> SimResult {
        
//        var count: [GameStatus: Int] = [.playerWin: 0,
//                                        .enemyWin: 0,
//                                        .draw: 0]
//
//        var moves: [GameStatus: Int] = [.playerWin: 0,
//                                        .enemyWin: 0,
//                                        .draw: 0]
//
        var simResult = SimResult()
        
//        print(grid.turn)
//        print(grid.printBoard())
        for _ in 0..<inteligence {
            let copyGrid = grid.copy()
//            print(copyGrid.turn)
//            print(copyGrid.printBoard())
            let randomGame = playRandom(grid: copyGrid)
            switch randomGame.gameStatus {
            case .playerWin:
                simResult.playerWon.amount += 1
                simResult.playerWon.averageMoves += randomGame.moves
            case .enemyWin:
                simResult.enemyWon.amount += 1
                simResult.enemyWon.averageMoves += randomGame.moves
            case .draw:
                simResult.draw.amount += 1
                simResult.draw.averageMoves += randomGame.moves
            case .unfinished:()
            }
//            count[randomGame.0]! += 1
//            moves[randomGame.0]! += randomGame.1
        }
//        moves[.playerWin]! /= inteligence
//        moves[.enemyWin]! /= inteligence
//        moves[.draw]! /= inteligence
        simResult.playerWon.averageMoves /= inteligence
        simResult.enemyWon.averageMoves /= inteligence
        simResult.draw.averageMoves /= inteligence
        
        return simResult
    }
    
    func evaluateMoves(grid: Grid) -> [String: SimResult] {
        let moves = grid.validMoves()
        var moveResult: [String: SimResult] = [:]
        
        for move in moves {
            let copyGrid = grid.copy()
//            print("MOVE: \(move)")
           
            // check if any move would finish the game
            
            copyGrid.makeMove(tile: move)
            moveResult[move.stringPos] = simulate(grid: copyGrid)
        }
        
        return moveResult
    }
    
    // TODO: add lose in logic - minimax
    
    func chooseBestMove(grid: Grid) -> [Int] {
        let forPlayer = grid.turn
        let result = evaluateMoves(grid: grid)
        
        let sortedResult = result.sorted { lhs, rhs in
            if forPlayer == .Player {
                return (rhs.value.playerWon.amount, lhs.value.playerWon.averageMoves) <
                    (lhs.value.playerWon.amount, rhs.value.playerWon.averageMoves)
                                
                
//                if lhs.value.playerWon.averageMoves == rhs.value.playerWon.averageMoves {
//                    return lhs.value.playerWon.amount > rhs.value.playerWon.amount
//                } else {
//                    return lhs.value.playerWon.averageMoves < rhs.value.playerWon.averageMoves
//                }
                
            } else {
                
                return (rhs.value.enemyWon.amount, lhs.value.enemyWon.averageMoves) <
                    (lhs.value.enemyWon.amount, rhs.value.enemyWon.averageMoves)
                
//                if lhs.value.enemyWon.averageMoves == rhs.value.enemyWon.averageMoves {
//                    return lhs.value.enemyWon.amount > rhs.value.enemyWon.amount
//                } else {
//                    return lhs.value.enemyWon.averageMoves < rhs.value.enemyWon.averageMoves
//                }
            }
        }
        
        for result in sortedResult {
//            print("move: \(result.key)\nResult: \(result.value.printedResult)\n\n")

            if result.value.enemyWon.amount == 100 && forPlayer == .Player {
                return result.key.split(separator: " ").map({ Int($0)! })
            }
            
            if result.value.playerWon.amount < 100 && forPlayer == .Enemy {
                return result.key.split(separator: " ").map({ Int($0)! })
            }
//            print("move: \(result.key) - won: \(result.value.0) - steps: \(result.value.1)")
        }
        
//
//        if let emergencyRes = result.first(where: { $0.value.enemyWon.amount == 100 }), forPlayer == .Player {
//            print("Emergency Player: move: \(emergencyRes.key)\nResult: \(emergencyRes.value.printedResult)\n\n")
//            return emergencyRes.key.split(separator: " ").map({ Int($0)! })
//        }
//
//        if let emergencyRes = result.first(where: { $0.value.playerWon.amount == 100 }), forPlayer == .Enemy {
//            print("Emergency Enemy: move: \(emergencyRes.key)\nResult: \(emergencyRes.value.printedResult)\n\n")
//            return emergencyRes.key.split(separator: " ").map({ Int($0)! })
//        }
////
        return sortedResult.first!.key.split(separator: " ").map({ Int($0)! })
    }

}
