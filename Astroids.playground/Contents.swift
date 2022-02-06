// https://www.codingame.com/ide/puzzle/asteroids

import UIKit
import Darwin

// input from game
var inputEasy = ["5 5 1 2 3",
                 "A.... .A...",
                 "..... .....",
                 "..... .....",
                 "..... .....",
                 "..... ....."]
var expectedEasy = ["..A..",
                    ".....",
                    ".....",
                    ".....",
                    "....."]

var inputHard = ["20 20 25 75 100",
                    ".................O.. G...................",
                    ".....N...........U.. ...............W....",
                    ".............L.R.... ...................C",
                    ".................... ...E................",
                    "..........Z..V.H.... ..............K.....",
                    "................X... ...........T........",
                    ".............P...... ............A.......",
                    ".............A...... .....P...FLI......N.",
                    ".Q.............T.... ....................",
                    "..................F. ........D...........",
                    ".................... ......S..Y.........M",
                    "......K............W .........B....Z.....",
                    "...............Y.... ....................",
                    "..............S..... ....V.............J.",
                    "...........JE......D .........O..........",
                    "...M................ ..X...........U.....",
                    "......B..G...C....I. ....................",
                    ".................... ....................",
                    ".................... ..Q................R",
                    ".................... .......H............"]

var expectedHard = ["..................K.",
                        "....................",
                        ".......I............",
                        ".........T..........",
                        "....................",
                        "...........A........",
                        "..D.F...............",
                        ".P..................",
                        "..S.......B.........",
                        "......Y.L...........",
                        "....................",
                        "....................",
                        "....................",
                        "....................",
                        "................Z...",
                        "....................",
                        "....................",
                        "....................",
                        "....................",
                        "...................."]

func readLine() -> String? {
    return inputHard.removeFirst()
}

func expected() -> String {
    return expectedHard.removeFirst()
}


// code starts here

typealias Position = (Int, Int)

struct Tile {
   var value: String
   let position: Position
   var isNewlySet: Bool = false

   func diff(toPosition targetPos: Position) -> Position {
//       print("DIFF", to: &errStream)
//       print("My: \(position)", to: &errStream)
//       print("Theres: \(targetPos)", to: &errStream)


       return (position.0-targetPos.0, position.1-targetPos.1)
   }
}

var gridT1: [Int: [Int: Tile]] = [:]
var gridT2: [Int: [Int: Tile]] = [:]
var gridT3: [Int: [Int: Tile]] = [:]


let inputs = (readLine()!).split(separator: " ").map(String.init)
let W = Int(inputs[0])!
let H = Int(inputs[1])!
let T1 = Int(inputs[2])!
let T2 = Int(inputs[3])!
let T3 = Int(inputs[4])!
if H > 0 {
   for i in 0...(H-1) {
       let inputs = (readLine()!).split(separator: " ").map(String.init)
       let firstPictureRow = inputs[0]
       let secondPictureRow = inputs[1]

       // Build grids for T1 and T2
       var rowT1: [Int: Tile] = [:]
       var rowT2: [Int: Tile] = [:]
        var j = 0
       for char in firstPictureRow {
           rowT1[j] = Tile(value: String(char), position: (i,j))
           j+=1
       }

       j = 0
       for char in secondPictureRow {
           rowT2[j] = Tile(value: String(char), position: (i,j))
           j+=1
       }
       gridT1[i] = rowT1
       gridT2[i] = rowT2

   }
}
// print builded T1 and T2 grid
for i in 0...(H-1) {
   var printRow = ""
   for j in 0...(W-1) {
       printRow += gridT1[i]![j]!.value
   }
   printRow += " "
   for j in 0...(W-1) {
       printRow += gridT2[i]![j]!.value
   }
   //print(printRow, to: &errStream)
}

// generate empty T3 Grid
for i in 0...(H-1) {
   var row: [Int: Tile] = [:]

   for j in 0...(W-1) {
       row[j] = Tile(value: ".", position: (i,j))
   }
   gridT3[i] = row
}

for i in 0...(H-1) {
   for j in 0...(W-1) {
      
       let tileT2 = gridT2[i]![j]!
       // if there is no asteroid on this tile got to next
       guard tileT2.value != "." else {
           continue
       }

       // get astroid pos on T1 with comparing T2
       var tileT1 = gridT1[i]![j]!
       for row in gridT1 {
           for col in row.value {
               if col.value.value == tileT2.value {
                   tileT1 = col.value
               }
           }
       }

       // diff from astroid T1 to T2
       let diff = tileT2.diff(toPosition: tileT1.position)
     //  print(diff, to: &errStream)

       let time1to2 = Double(T2 - T1)
       let time2to3 = Double(T3 - T2)
       // movement as for 1 time passed
       let oneTimeRow = Double(diff.0)/time1to2
       let oneTimeCol = Double(diff.1)/time1to2

       // movement as for time passed from T2 to T3
       let calcRow = i + Int(exactly: floor(oneTimeRow*time2to3))!
       let calcCol = j + Int(exactly: floor(oneTimeCol*time2to3))!
      // print("calc new pos \((calcRow,calcCol))", to: &errStream)
       // set new astroid value if closed or not already set
       if let row = gridT3[calcRow],
           let col = row[calcCol],
           (!col.isNewlySet || tileT2.value <= col.value) {

          // print("set \(tileT2.value) to \((calcRow,calcCol))", to: &errStream)
           gridT3[calcRow]![calcCol]! = Tile(value: tileT2.value, position: (calcRow,calcCol), isNewlySet: true)
       }
   }
}

// print grid T3
for i in 0...(H-1) {
   var printRow = ""
   for j in 0...(W-1) {
       printRow += gridT3[i]![j]!.value
   }
   print(printRow)
}

/// code end here

for i in 0...(H-1) {
   var printRow = ""
   for j in 0...(W-1) {
       printRow += gridT3[i]![j]!.value
   }
   print(printRow == expected())
}
