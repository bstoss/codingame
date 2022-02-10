// https://www.codingame.com/ide/puzzle/reverse-minesweeper

import UIKit

// input from game 
var input = ["16",
             "9",
             "................",
             "................",
             "................",
             "................",
             "................",
             "....x...........",
             "................",
             "................",
             "................"]

func readLine() -> String? {
    return input.removeFirst()
}

/// Code begins here

typealias Position = (Int, Int)

struct Tile {
    // -1 bomb, 0 nothing, > 0 sorrounding bomb
    var value: Int = 0
    let position: Position

    var valueAsString: String {
        if value == 0 || value == -1 {
            return "."
        } else {
            return "\(value)"
        }
    }
}



var grid: [Int: [Int: Tile]] = [:]

let w = Int(readLine()!)!
let h = Int(readLine()!)!
if h > 0 {
    for i in 0...(h-1) {
        let line = readLine()!
        var j = 0
        var cols: [Int: Tile] = [:]
        for char in line {
            let value = char == "." ? 0 : char == "x" ? -1 : 0
            cols[j] = Tile(value: value, position: (i, j))
            j+=1
        }
        grid[i] = cols
    }
}

func updateTilesForBomb(_ positions: [Position]) {
    for pos in positions {
        guard let cols = grid[pos.0],
              var tile = cols[pos.1],
              tile.value != -1 else {
                  continue
              }
       // print(pos, to: &errStream)
        grid[pos.0]![pos.1]!.value += 1
    }
}

for (i, cols) in grid {
    for (j, tile) in cols {
        
        if tile.value == -1 {
            let posTopLeft = (i-1,j-1)
            let posTop = (i-1,j)
            let posTopRight = (i-1,j+1)

            let posLeft = (i, j-1)
            let posRight = (i, j+1)

            let posBottomLeft = (i+1,j-1)
            let posBottom = (i+1,j)
            let posBottomRight = (i+1,j+1)

            updateTilesForBomb(
                [posTopLeft, posTop, posTopRight,
                posLeft, posRight,
                posBottomLeft, posBottom, posBottomRight
                ])

        }
    }
}

// Write an answer using print("message...")
// To debug: print("Debug messages...", to: &errStream)

for i in 0...(h-1) {
    var printRow = ""
    for j in 0...(w-1) {
        printRow += grid[i]![j]!.valueAsString
    }
    print(printRow)
}


let a = 5
let b = 3
let c: Float = 5

print((a-b)/c)

/*
 
 minesweeper event solver
 
 import Glibc
 import Foundation

 public struct StderrOutputStream: TextOutputStream {
     public mutating func write(_ string: String) { fputs(string, stderr) }
 }
 public var errStream = StderrOutputStream()

 /**
  * Auto-generated code below aims at helping you parse
  * the standard input according to the problem statement.
  **/

 typealias Position = (Int, Int)
 typealias Row = [Int: Tile]
 typealias Grid = [Int: Row]

 enum CellValue: Equatable {
     case unknown
     case empty
     case borderMine(Int)
     case bomb

      static func ==(lhs: CellValue, rhs: CellValue) -> Bool {
         switch (lhs, rhs) {
         case (let .unknown, let .unknown),
             (let .empty, let .empty),
             (let .bomb, let .bomb):
             return true
         case (let .borderMine(lhnum), let .borderMine(rhnum)):
             return lhnum == rhnum
         default:
             return false
         }
     }
 }

 class Tile {
     var position: Position
     var value: CellValue

     lazy var surroundingPos: [Position] = {
         let pos = position
         let posTopLeft = (pos.0-1,pos.1-1)
         let posTop = (pos.0-1,pos.1)
         let posTopRight = (pos.0-1,pos.1+1)

         let posLeft = (pos.0, pos.1-1)
         let posRight = (pos.0, pos.1+1)

         let posBottomLeft = (pos.0+1,pos.1-1)
         let posBottom = (pos.0+1,pos.1)
         let posBottomRight = (pos.0+1,pos.1+1)

         return [posTopLeft, posTop, posTopRight,
                 posLeft, posRight,
                 posBottomLeft, posBottom, posBottomRight]
     }()
    
     init(atPosition pos: Position) {
         self.position = pos
         self.value = .unknown
     }

     func setFlagsIfPossible(inGrid g: Grid) -> String? {
         var flags = ""
         if case CellValue.borderMine(let num) = value {

             let sTiles: [Tile] = surroundingPos.compactMap({ pos in
              guard let tile = grid[pos.1]?[pos.0],
              tile.value == .unknown ||
              tile.value == .bomb else {
                 return nil
             }
             return tile
          })

          let bombs = sTiles.filter({$0.value == .bomb})
          let unknows = sTiles.filter({$0.value != .bomb})

          if bombs.count == num {
              return nil
          }

         if unknows.count <= num-bombs.count {
             for tile in sTiles {
                 grid[tile.position.1]![tile.position.0]!.value = .bomb
             }

             flags = sTiles.flatMap({ "\($0.position.0) \($0.position.1)" }).joined(separator: " ")
         }

         }
         
         return flags.isEmpty ? nil : flags
     }

     func hasSaveMove(inGrid g: Grid) -> Position? {

         let sTiles: [Tile] = surroundingPos.compactMap({ pos in
              guard let tile = grid[pos.1]?[pos.0],
                 tile.value != .bomb,
                  tile.value != .empty,
                  tile.value != .unknown else {
                 return nil
             }
             return tile
          })

          for tile in sTiles {

             if case CellValue.borderMine(let num) = tile.value {
             let ssTiles: [Tile] = tile.surroundingPos.compactMap({ pos in
                 guard let tile = grid[pos.1]?[pos.0],
                 tile.value == .bomb else {
                     return nil
                 }
                 return tile
             })

             if ssTiles.count == num {
                 return position
             }
          }
         }

         return nil
     }
 }

 func printBoard(_ g: Grid) {
         var printedGrid = ""
         for i in 0...15 {
             var row = "|"
             for j in 0...29 {
                 switch g[i]![j]!.value {
                 case .bomb:
                     row += " x |"
                 case .borderMine(let num):
                     row += " \(num) |"
                 case .empty:
                     row += " . |"
                 case .unknown:
                     row += " ? |"
                 }
             }

             printedGrid += row + "\n"
         }
         print(printedGrid, to: &errStream)
     }

 func cellValue(forString s: String) -> CellValue {
     if s == "." {
         return .empty
     }

     if s == "?" {
         return .unknown
     }

     if let num = Int(s) {
         return .borderMine(num)
     }

     return .bomb
 }

 func randomItem<T>(fromArray a: Array<T>) -> T {
         var rng = SystemRandomNumberGenerator()
         let randomInt = Int.random(in: 0..<a.count, using: &rng)
         return a[randomInt]
         // does not work on server side swift
         // let index = Int(arc4random_uniform(UInt32(a.count)))
         // return a[index]
     }

 var grid: Grid = [:]

 for i in 0...15 {
     var row: Row = [:]
     for j in 0...29 {
         row[j] = Tile(atPosition: (j,i))
     }
     grid[i] = row
 }

 var firstMoveDone = false
 //printBoard(grid)
 // game loop
 while true {
     for i in 0...15 {
         var j = 0
         for cell in ((readLine()!).split(separator: " ").map(String.init)) {
             //print(cell, to: &errStream)
             var newCellValue = cellValue(forString: cell)
             if grid[i]![j]!.value != .bomb {
                 grid[i]![j]!.value = newCellValue
             }
             
             j += 1
         }
     }

     
     // func for set new value, to check if flags can be set
     var flags = ""
      for i in 0...15 {
         for j in 0...29 {
             guard let tile = grid[i]?[j],
                  tile.value != .bomb,
                  tile.value != .empty,
                  tile.value != .unknown else {
                 continue
             }

             if let newFlags = tile.setFlagsIfPossible(inGrid: grid) {
                 flags += " \(newFlags)"
             }
         }
      }
     //printBoard(grid)

     var output = "20 7"
     for i in 0...15 {
         for j in 0...29 {

             guard let tile = grid[i]?[j],
                 tile.value == .unknown else {
                 continue
             }

             if let move = tile.hasSaveMove(inGrid: grid) {
                 output = "\(move.0) \(move.1)"
                 //print(move, to: &errStream)
                 break
             }
         }
         if output != "20 7" {
             break
         }
     }

     // Write an action using print("message...")
     // To debug: print("Debug messages...", to: &errStream)
     if firstMoveDone && output == "20 7" {
         // optimise this to find a tile wich has the most les risk of finding
         // no bomb
         // eg. with most .unknown tiles - number on it
         var rng = SystemRandomNumberGenerator()

         while output == "20 7" {
             let randx = Int.random(in: 0...29, using: &rng)
             let randy = Int.random(in: 0...15, using: &rng)
             if grid[randy]?[randx]?.value == .unknown {
                 output = "\(randx) \(randy)"
             }
         }
         
     }
     
     print("\(output)\(flags)")
     firstMoveDone = true
 }


 */
