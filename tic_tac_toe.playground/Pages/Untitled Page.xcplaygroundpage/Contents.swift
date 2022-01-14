import PlaygroundSupport
import UIKit

let game = GameViewController()

game.preferredContentSize = game.view.frame.size
PlaygroundPage.current.liveView = game

//
//
//var grid = Grid()
//
//grid.turn = .Player
//grid.makeMove(tile: Tile(position: (1,1), mark: .Player))
////
////grid.turn = .Enemy
////grid.makeMove(tile: Tile(position: (0,1), mark: .Enemy))
//
//grid.turn = .Player
//grid.makeMove(tile: Tile(position: (1,0), mark: .Player))
//grid.turn = .Player
//
////grid.turn = .Enemy
////grid.makeMove(tile: Tile(position: (2,1), mark: .Enemy))
//
//grid.printBoard()
//
//let solver = Solver()
////let gameResult = solver.playRandom(grid: grid)
////solver.simulate(grid: grid)
//let result = solver.chooseBestMove(grid: grid)
//grid.printBoard()
//print(result)

//
//var grids: [Int: [Int: Grid]] = [:]
//
//for i in 0..<3 {
//    var cols: [Int: Grid] = [:]
//    for j in 0..<3 {
//
//        let grid = Grid()
//        cols[j*3] = grid
//    }
//    grids[i*3] = cols
//}
//
//let validRow = 1
//let validCol = 1
//
//let findGridRow = validRow < 3 ? 0: validRow < 6 ? 1 : 2
//let findGridCol = validCol < 3 ? 0: validCol < 6 ? 1 : 2
//
//var grid = grids[findGridRow]![findGridCol]!
//grid.turn = .Player
//grid.makeMove(tile: Tile(position: (1,1), mark: .Player))
//
//for gridRow in grids {
//    for gridCol in gridRow.value {
//        print("Grid: \(gridRow.key) \(gridCol.key)")
//        gridCol.value.printBoard()
//    }
//}

/*
 For the game
 
// RANK 12 Bronce
 var grid = Grid()
 let solver = Solver()
 //grid.printBoard()

 // game loop
 while true {

     let inputs = readLine()!.split(separator: " ")
     let opponentRow = Int(inputs[0])!
     let opponentCol = Int(inputs[1])!
     
     let validActionCount = Int(readLine()!)!
     debug("validActionCount: \(validActionCount)")
     debug("last opp action: \(opponentRow) \(opponentCol)")
     var validActionRow: Int = -1
     var validActionCol: Int = -1

     if validActionCount > 0 {
         
         for i in 0...(validActionCount-1) {
             let inputs = readLine()!.split(separator: " ")
             let row = Int(inputs[0])!
             let col = Int(inputs[1])!
             
             if validActionRow == -1 {
                 validActionRow = row
                 validActionCol = col
             }
             debug("valid action: \(row) \(col)")
         }
     }
     
     if opponentRow != -1 {
         let findGridRowOpp = opponentRow < 3 ? 0: opponentRow < 6 ? 3 : 6
         let findGridColOpp = opponentCol < 3 ? 0: opponentCol < 6 ? 3 : 6
         debug("Grid Opp: \(findGridRowOpp) \(findGridColOpp)")
         let gridOpp = grids[findGridRowOpp]![findGridColOpp]!
         
         gridOpp.turn = .Enemy
         gridOpp.makeMove(tile: Tile(position: (opponentRow-findGridRowOpp, opponentCol-findGridColOpp), mark: .Enemy))

         let findGridRow = validActionRow < 3 ? 0: validActionRow < 6 ? 3 : 6
         let findGridCol = validActionCol < 3 ? 0: validActionCol < 6 ? 3 : 6
         debug("Grid: \(findGridRow) \(findGridCol)")
         let grid = grids[findGridRow]![findGridCol]!

         if grid.turn == .Empty {
             grid.turn = .Player
             grid.makeMove(tile: Tile(position: (1, 1), mark: .Player))
             grid.printBoard()
             print("\(1+findGridRow) \(1+findGridCol)")
         } else {

             //grid.printBoard()
             let result = solver.chooseBestMove(grid: grid)

             // Write an action using print("message...")
             // To debug: print("Debug messages...", to: &errStream)
             let move = result.split(separator: " ")
             debug("make move: \(move)")
             let row = Int(move[0])!
             let col = Int(move[1])!
             grid.makeMove(tile: Tile(position: (row, col), mark: .Player))

             print("\(row+findGridRow) \(col+findGridCol)")
         }

     } else {
         let grid = grids[3]![3]!
         
         grid.turn = .Player
         grid.makeMove(tile: Tile(position: (1, 1), mark: .Player))
         grid.printBoard()
         print("4 4")
     }
 }
 */

/*
 
 // RANK 4
 
 // game loop
 while true {

     let inputs = readLine()!.split(separator: " ")
     let opponentRow = Int(inputs[0])!
     let opponentCol = Int(inputs[1])!
     
     let validActionCount = Int(readLine()!)!
     debug("validActionCount: \(validActionCount)")
     debug("last opp action: \(opponentRow) \(opponentCol)")
     var validActionRow: Int = -1
     var validActionCol: Int = -1

     var possibleGrids: [Int: [Int: Grid]] = [:]
     if validActionCount > 0 {
         
         for i in 0...(validActionCount-1) {
             let inputs = readLine()!.split(separator: " ")
             let row = Int(inputs[0])!
             let col = Int(inputs[1])!
             
             let findGridRow = row < 3 ? 0: row < 6 ? 3 : 6
             let findGridCol = col < 3 ? 0: col < 6 ? 3 : 6

             // check if grid already loaded
             if validActionRow == -1 {
                 validActionRow = row
                 validActionCol = col
             }
             //debug("valid action: \(row) \(col)")
         }
     }
     
     if opponentRow != -1 {
         
         let findGridRowOpp = opponentRow < 3 ? 0: opponentRow < 6 ? 3 : 6
         let findGridColOpp = opponentCol < 3 ? 0: opponentCol < 6 ? 3 : 6
         debug("Grid Opp: \(findGridRowOpp) \(findGridColOpp)")
         let gridOpp = grids[findGridRowOpp]![findGridColOpp]!
         
         gridOpp.turn = .Enemy
         gridOpp.makeMove(tile: Tile(position: (opponentRow-findGridRowOpp, opponentCol-findGridColOpp), mark: .Enemy))
     }
     
         let findGridRow = validActionRow < 3 ? 0: validActionRow < 6 ? 3 : 6
         let findGridCol = validActionCol < 3 ? 0: validActionCol < 6 ? 3 : 6
         debug("Grid: \(findGridRow) \(findGridCol)")
         let grid = grids[findGridRow]![findGridCol]!

         /*
         if grid.turn == .Empty {
             grid.turn = .Player
             grid.makeMove(tile: Tile(position: (1, 1), mark: .Player))
             grid.printBoard()
             print("\(1+findGridRow) \(1+findGridCol)")
         } else {
             */
             grid.turn = .Player
             //grid.printBoard()
             let result = solver.chooseBestMove(grid: grid)

             // Write an action using print("message...")
             // To debug: print("Debug messages...", to: &errStream)
             //let move = result.split(separator: " ")
             debug("make move: \(result)")
             let row = result[0]
             let col = result[1]
             grid.makeMove(tile: Tile(position: (row, col), mark: .Player))

             print("\(row+findGridRow) \(col+findGridCol)")
        // }
     /*
     } else {
         let grid = grids[3]![3]!
         
         grid.turn = .Player
         grid.makeMove(tile: Tile(position: (1, 1), mark: .Player))
         grid.printBoard()
         print("4 4")
     }*/
 }
 */
