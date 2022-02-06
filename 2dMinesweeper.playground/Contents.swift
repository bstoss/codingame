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
