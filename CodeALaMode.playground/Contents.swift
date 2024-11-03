/// https://www.codingame.com/ide/puzzle/code-a-la-mode

import Foundation
import Darwin

var input = [
    "20",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-ICE_CREAM-BLUEBERRIES-CHOPPED_STRAWBERRIES 1050",
    "DISH-CHOPPED_STRAWBERRIES-BLUEBERRIES-ICE_CREAM 1050",
    "DISH-ICE_CREAM-BLUEBERRIES 650",
    "DISH-ICE_CREAM-BLUEBERRIES-CHOPPED_STRAWBERRIES 1050",
    "DISH-CHOPPED_STRAWBERRIES-ICE_CREAM-BLUEBERRIES 1050",
    "DISH-CHOPPED_STRAWBERRIES-BLUEBERRIES-ICE_CREAM 1050",
    "DISH-BLUEBERRIES-CHOPPED_STRAWBERRIES 850",
    "DISH-CHOPPED_STRAWBERRIES-BLUEBERRIES-ICE_CREAM 1050",
    "DISH-CHOPPED_STRAWBERRIES-ICE_CREAM-BLUEBERRIES 1050",
    "DISH-CHOPPED_STRAWBERRIES-ICE_CREAM-BLUEBERRIES 1050",
    "DISH-BLUEBERRIES-ICE_CREAM-CHOPPED_STRAWBERRIES 1050",
    "DISH-CHOPPED_STRAWBERRIES-BLUEBERRIES 850",
    "DISH-BLUEBERRIES-CHOPPED_STRAWBERRIES-ICE_CREAM 1050",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-BLUEBERRIES-ICE_CREAM-CHOPPED_STRAWBERRIES 1050",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-BLUEBERRIES-CHOPPED_STRAWBERRIES 850",
    "DISH-CHOPPED_STRAWBERRIES-ICE_CREAM-BLUEBERRIES 1050",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "I####D#####",
    "#.........#",
    "#1C###.##.#",
    "#.#0.#..#.#",
    "#.S#.####.B",
    "#.........#",
    "#####W#####",
    "199",
    "3 3 NONE",
    "1 2 NONE",
    "0",
    "NONE 0",
    "3",
    "DISH-BLUEBERRIES-ICE_CREAM 650",
    "DISH-ICE_CREAM-BLUEBERRIES-CHOPPED_STRAWBERRIES 1050",
    "DISH-CHOPPED_STRAWBERRIES-BLUEBERRIES-ICE_CREAM 1050"
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

/*
 .: walkable cell
 0: first player spawn location (also walkable)
 1: second player spawn location (also walkable)
 D: the dishwasher
 W: the window
 B: the blueberry crate
 I: the ice cream crate
 */
enum Entity: String {
    case emptyTable = "#"
    case walkable = "."
    case p1 = "0"
    case p2 = "1"
    case dishwasher = "D"
    case window = "W"
    case blueberry = "B"
    case iceCream = "I"
    case strawberries = "S"
    case choppingBoard = "C"
    
    var print: String {
        self.rawValue
    }
}

enum Item: String {
    case dish = "DISH"
    case blueberries = "BLUEBERRIES"
    case iceCream = "ICE_CREAM"
    case strawberries = "STRAWBERRIES"
    case choppedStrawberries = "CHOPPED_STRAWBERRIES"
    
    static func makeItems(withIngrediences ingrediences: String) -> Set<Item> {
        var uniqueItems = Set<Item>()
        let items = ingrediences.split(separator: "-").compactMap { itemChar in
            Item(rawValue: String(itemChar))
        }
        uniqueItems = Set(items)
        return uniqueItems
    }
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
    
    var p1: Cell!
    var p2: Cell!
    var d: Cell!
    var w: Cell!
    var b: Cell!
    var i: Cell!
    var s: Cell!
    var c: Cell!
    
    //var visitedCells: [Cell] = []
    
    //var exit: Cell?
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
            let type = Entity(rawValue: String(char))!
            let cell = Cell(position: (cellIndex, rowIndex), entity: type)
            row[cellIndex] = cell
            cells.append(cell)
            switch type {
            case .p1:
                p1 = cell
            case .p2:
                p2 = cell
            case .dishwasher:
                d = cell
            case .window:
                w = cell
            case .blueberry:
                b = cell
            case .iceCream:
                i = cell
            case .strawberries:
                s = cell
            case .choppingBoard:
                c = cell
            default: ()
            }
           
            cellIndex += 1
        }
        
        g[rowIndex] = row
    }
    
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

class Player {
    var position: Position
    var wearing: Dish?
    
    init(position: Position, item: String) {
        self.position = position
        self.wearing = Dish.make(fromItem: item)
    }
}

struct Dish: Equatable {
    var ingrediences: Set<Item>
    
    init(ingrediences: String) {
        self.ingrediences = Item.makeItems(withIngrediences: ingrediences)
    }
    
    static func make(fromItem item: String) -> Dish? {
        guard item != "NONE" else {
            return nil
        }
        return Dish(ingrediences: item)
    }
}

struct Order {
    var dish: Dish
    var award: Int
    
    init(item: String, award: Int) {
        dish = Dish.make(fromItem: item)!
        self.award = award
    }
}

var fullOrderList: [Order] = []
var currentOrderList: [Order] = []

let numAllCustomers = Int(read())!
if numAllCustomers > 0 {
    for i in 0...(numAllCustomers-1) {
        let inputs = (read()).split(separator: " ").map(String.init)
        let customerItem = inputs[0] // the food the customer is waiting for
        let customerAward = Int(inputs[1])! // the number of points awarded for delivering the food
        fullOrderList.append(Order(item: customerItem, award: customerAward))
    }
}
var board = Board()

for _ in 0...6 {
    board.addRow(rowString: read())
}
var player1 = Player(position: board.p1.position, item: "NONE")
var player2 = Player(position: board.p2.position, item: "NONE")

board.printBoard()



// game loop
while loop() {
    let turnsRemaining = Int(read())!
    
    // p1
    let inputs = (read()).split(separator: " ").map(String.init)
    let playerX = Int(inputs[0])!
    let playerY = Int(inputs[1])!
    let playerItem = inputs[2]
    player1.position = (playerX, playerY)
    player1.wearing = Dish.make(fromItem: playerItem)
    
    // p2
    let inputs2 = (read()).split(separator: " ").map(String.init)
    let partnerX = Int(inputs2[0])!
    let partnerY = Int(inputs2[1])!
    let partnerItem = inputs2[2]
    player2.position = (partnerX, partnerY)
    player2.wearing = Dish.make(fromItem: partnerItem)
    
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
    
    currentOrderList = []
    let numCustomers = Int(read())! // the number of customers currently waiting for food
    if numCustomers > 0 {
        for _ in 0...(numCustomers-1) {
            let inputs = (read()).split(separator: " ").map(String.init)
            let customerItem = inputs[0]
            let customerAward = Int(inputs[1])!
            currentOrderList.append(Order(item: customerItem, award: customerAward))
        }
    }

    // Write an action using print("message...")
    // To debug: print("Debug messages...", to: &errStream)


    // MOVE x y
    // USE x y
    // WAIT
   // print("WAIT")
    let printOut = decideAction()
    
    print(printOut)
    
    
}

enum Command {
    case move(Position)
    case use(Position)
    case wait
    
    var print: String {
        switch self {
        case .move(let p):
            return "MOVE \(p.x) \(p.y)"
        case .use(let p):
            return "USE \(p.x) \(p.y)"
        case .wait:
            return "WAIT"
        }
    }
}

var current: Dish?

// MOVE x y
// USE x y
// WAIT
func decideAction() -> String {
    
    let dish: Dish
    if let c = current {
        if currentOrderList.contains(where: { $0.dish == current }) {
            dish = c
        } else if let wearing = player1.wearing {
            // dish is already fullfiled
            // check if dish with already wearing ingrediences is wished
            if let newDish = currentOrderList.first(where: { order in
                wearing.ingrediences.isSubset(of: order.dish.ingrediences)
            }) {
                dish = newDish.dish
            } else if fullOrderList.contains(where: { order in
                wearing.ingrediences.isSubset(of: order.dish.ingrediences)
            }) {
                return Command.use(board.w.position).print // trash at first. Store om empty table later ...
            }
            // check if ingredeience on dish is needed in whole orderlist
            // otherwise trash it
            return Command.use(board.w.position).print
        } else {
            current = nil
            dish = currentOrderList.first!.dish
        }
        
    } else {
        dish = currentOrderList.first!.dish
    }
    
    current = dish
    
    // check what player2 trys to serve
    // think about concept for working on receipe
    // receipe will define order of actions
    //
    
    guard let wearing = player1.wearing else {
        if dish.ingrediences.contains(.choppedStrawberries) {
            // get strawberies
            return Command.use(board.s.position).print
        } else {
            // get dish
            return Command.use(board.d.position).print
        }
    }
    
    if dish.ingrediences.contains(.choppedStrawberries) {
        
        if wearing.ingrediences.contains(.strawberries) {
            return Command.use(board.c.position).print
        }
        
        if !wearing.ingrediences.contains(.dish) {
            return Command.use(board.d.position).print
        }
        
        
    }
    
    if dish.ingrediences.contains(.blueberries) && dish.ingrediences.contains(.iceCream) {
        // make this more smart
        let distanceB = distance(from: player1.position, to: board.b.position)
        let distanceI = distance(from: player1.position, to: board.i.position)
        
        if distanceB < distanceI {
            guard wearing.ingrediences.contains(.blueberries) else {
                return Command.use(board.b.position).print
            }
            guard wearing.ingrediences.contains(.iceCream) else {
                return Command.use(board.i.position).print
            }
            
        } else {
            guard wearing.ingrediences.contains(.iceCream) else {
                return Command.use(board.i.position).print
            }
            
            guard wearing.ingrediences.contains(.blueberries) else {
                return Command.use(board.b.position).print
            }
        }
    } else {
        
        if dish.ingrediences.contains(.blueberries) {
            guard wearing.ingrediences.contains(.blueberries) else {
                return Command.use(board.b.position).print
            }
        }
        
        if dish.ingrediences.contains(.iceCream) {
            guard wearing.ingrediences.contains(.iceCream) else {
                return Command.use(board.i.position).print
            }
        }
        
    }
    
    return Command.use(board.w.position).print
}

func distance(from fromPosition: Position, to toPosition: Position) -> Int {
    let y = toPosition.y - fromPosition.y
    let x = toPosition.x - fromPosition.x
    let distance = abs(y) + abs(x)
    return distance
}
