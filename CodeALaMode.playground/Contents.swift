/// https://www.codingame.com/ide/puzzle/code-a-la-mode

import Foundation
import Darwin

var input = [
    "20",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "#####D#####",
    "#........1#",
    "#.####.##.#",
    "#.#..I.0#.#",
    "#.##.####.#",
    "#.........#",
    "B####W#####"

]

func readLine() -> String? {
    return input.removeFirst()
}

var loops = 1

func loop() -> Bool {
    let ret = loops > 0
    loops -= 1
    return ret
}

func debug(_ mess: Any) {
    print("Debug: \(mess)")
}

// not copy from game
/*
 
 func debug(_ mess: Any) {
 print("Debug: \(mess)", to: &errStream)
 }
 
 func loop() -> Bool {
 return true
 }
 
*/

// REAL CODE here
func read() -> String {
    let line = readLine()!
    debug(line)
    return line
}



typealias Position = (x: Int, y: Int)

protocol Entity {
    var print: String { get }
}
/*
 .: walkable cell
 0: first player spawn location (also walkable)
 1: second player spawn location (also walkable)
 D: the dishwasher
 W: the window
 B: the blueberry crate
 I: the ice cream crate
 */
enum CellType: String, Entity {
    case emptyTable = "#"
    case walkable = "."
    case sp1 = "0"
    case sp2 = "1"
    case dishwasher = "D"
    case window = "W"
    case blueberry = "B"
    case iceCream = "I"
    
    var print: String {
        self.rawValue
    }
}

enum Tabables: String {
    case dish = "DISH"
    case blueberries = "BLUEBERRIES"
    case iceCream = "ICE_CREAM"
}

class Cell {
    let position: Position
    var entity: Entity // could be anything
    
    var print: String {
        return "\(position) - \(entity.print)"
    }
    
    init(position: Position, entity: Entity) {
        self.position = position
        self.entity = entity
    }
}

typealias Row = [Int: Cell]
typealias Grid = [Int: Row]

class Board {
    
    // need 2 dimensions because of faster access
    var g: Grid = [:]
    
    var cells: [Cell] = []
    var visitedCells: [Cell] = []
    
    var exit: Cell?
    // store fix positions?
    // dish, food, bell?
    
//    init(h: Int, w: Int) {
//        self.h = h
//        self.w = w
//        setup()
//    }
    
    func addRow(rowString: String) {
        var row: Row = [:]
        var rowIndex = g.count // actually new index
        var cellIndex = 0
        for char in rowString {
            let type = CellType(rawValue: String(char))!
            let cell = Cell(position: (cellIndex, rowIndex), entity: type)
            row[cellIndex] = cell
            cells.append(cell)
            cellIndex += 1
        }
        
        g[rowIndex] = row
    }
    
//    mutating func setup() {
//
//        for i in 0..<h {
//            var row: Row = [:]
//            for j in 0..<w {
//                let cell = Cell(position: (j,i), entity: Entity())
//                row[j] = cell
//                cells.append(cell)
////                if let ent = g[i]?[j], ent.type == .visited {
////                    row[j] = ent
////                } else {
////                    row[j] = Entity(position: (j, i))
////                }
//            }
//            g[i] = row
//        }
//    }
    
//    mutating func setEntity(forPosition position: Position, entity: Entity) {
//        g[position.y]?[position.x]?.entity = entity
//
//        if entity.type == .exit {
//            self.exit = g[position.y]![position.x]!
//        }
//        if entity.type == .hero {
//            visitedCells.append(g[position.y]![position.x]!)
//        }
//    }
    
//    mutating func setPath(for position: Position) {
//        for x in position.x-3...position.x+3 {
//            for y in position.y-3...position.y+3 {
//                guard let cell = g[y]?[x] else {
//                    continue
//                }
//                if visitedCells.contains(where: { $0 == cell }) {
//                    cell.entity.type = .visited
//                } else {
//                    cell.entity.type = .path
//                }
//            }
//        }
//    }
//
    func entity(for position: Position) -> Entity? {
        return cell(for: position)?.entity
    }
    
    func cell(for position: Position) -> Cell? {
        return g[position.y]?[position.x]
    }
    
    func printBoard() {
        
        for row in g.sorted(by: { $0.key < $1.key }) {
            var print = ""
            for cell in row.value.sorted(by: { $0.key < $1.key }) {
                print += "[\(cell.value.entity.print)]"
            }
            
            debug(print)
        }
    }
}



let numAllCustomers = Int(read())!
if numAllCustomers > 0 {
    for i in 0...(numAllCustomers-1) {
        let inputs = (read()).split(separator: " ").map(String.init)
        let customerItem = inputs[0] // the food the customer is waiting for
        let customerAward = Int(inputs[1])! // the number of points awarded for delivering the food
    }
}
var board = Board()

for _ in 0...6 {
    board.addRow(rowString: read())
}

board.printBoard()

// game loop
while loop() {
    let turnsRemaining = Int(read())!
    let inputs = (read()).split(separator: " ").map(String.init)
    let playerX = Int(inputs[0])!
    let playerY = Int(inputs[1])!
    let playerItem = inputs[2]
    let inputs2 = (read()).split(separator: " ").map(String.init)
    let partnerX = Int(inputs2[0])!
    let partnerY = Int(inputs2[1])!
    let partnerItem = inputs2[2]
    let numTablesWithItems = Int(read())! // the number of tables in the kitchen that currently hold an item
    if numTablesWithItems > 0 {
        for i in 0...(numTablesWithItems-1) {
            let inputs = (read()).split(separator: " ").map(String.init)
            let tableX = Int(inputs[0])!
            let tableY = Int(inputs[1])!
            let item = inputs[2]
        }
    }
    let inputs3 = (read()).split(separator: " ").map(String.init)
    let ovenContents = inputs3[0] // ignore until wood 1 league
    let ovenTimer = Int(inputs3[1])!
    let numCustomers = Int(read())! // the number of customers currently waiting for food
    if numCustomers > 0 {
        for i in 0...(numCustomers-1) {
            let inputs = (read()).split(separator: " ").map(String.init)
            let customerItem = inputs[0]
            let customerAward = Int(inputs[1])!
        }
    }

    // Write an action using print("message...")
    // To debug: print("Debug messages...", to: &errStream)


    // MOVE x y
    // USE x y
    // WAIT
   // print("WAIT")

    if playerItem == "NONE" {
        print("USE 5 0")
    } else if playerItem == "DISH" {
        print("USE 2 2")
    }else if playerItem == "DISH-ICE_CREAM" {
        print("USE 7 0")
    }else if playerItem == "DISH-ICE_CREAM-BLUEBERRIES" {
        print("USE 5 6")
    }
}

