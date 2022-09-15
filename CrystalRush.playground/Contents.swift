// https://www.codingame.com/ide/puzzle/crystal-rush

import UIKit

// input from game not setup to work
var input = ["30 16"]

func readLine() -> String? {
    return input.removeFirst()
}



/// Code begins here
///

public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}
public var errStream = StderrOutputStream()

func debug(_ message: String) {
    debugPrint(message, to: &errStream)
    //print(message)
}

struct Point {
    let x: Int
    let y: Int

    var printableCoord: String {
        return "\(x) \(y)"
    }

    func distance(to point: Point) -> Int {
        let y = point.y - self.y
        let x = point.x - self.x
        let distance = abs(y) + abs(x)
        return distance
    }
}

class MapObject {
    let point: Point

    init(x: Int, y: Int) {
        self.point = Point(x: x, y: y)
    }
}

class Cell: MapObject {
    
    let ores: Int?
    let hole: Bool
    
    init(x: Int, y: Int, ores: String, hole: Bool) {
        self.ores = Int(ores)
        self.hole = hole
        super.init(x: x, y: y)
    }
}

func nearest<T: MapObject>(for units: [T], to obj: T) -> T? {

    let sortedUnits = units.sorted { (left, right) -> Bool in
        let ldistance = left.point.distance(to: obj.point)
        let rdistance = right.point.distance(to: obj.point)
        return ldistance < rdistance
    }

    return sortedUnits.first
}

func nearestList<T: MapObject>(for units: [T], to obj: T) -> [T] {

    let sortedUnits = units.sorted { (left, right) -> Bool in
        let ldistance = left.point.distance(to: obj.point)
        let rdistance = right.point.distance(to: obj.point)
        return ldistance < rdistance
    }

    return sortedUnits
}

typealias Row = [Int: MapObject]
typealias Grid = [Int: Row]

struct Board {
    let h: Int
    let w: Int

    // need 2 dimensions because of faster access
    var g: Grid

    init(h: Int, w: Int) {
        self.h = h
        self.w = w
        g = [:]
        for i in 0..<h {
            var row: Row = [:]
            for j in 0..<w {
                row[j] = MapObject(x: j, y: i)
            }
            g[i] = row
        }
    }
    
    func printBoard() {
        
        for i in 0..<h {
            var print = ""
            for j in 0..<w {
                if let cell = g[i]?[j] as? Cell {
                    print += "\(cell.ores ?? 0)\(cell.hole ? "o": "-")"
                } else {
                    print += "[]"
                }
            }
            debug(print)
        }
    }

//    func setNewValue(forTileAtPosition p: Position, value: String) {
//        let newCellValue = cellValue(forString: value)
//        let tile = g[p.1]![p.0]!
//        if tile.value != .bomb {
//            tile.value = newCellValue
//        }
//    }
    
}

/**
 * Deliver more ore to hq (left side of the map) than your opponent. Use radars to find ore but beware of traps!
 **/

let inputs = (readLine()!).split(separator: " ").map(String.init)
let width = Int(inputs[0])!
let height = Int(inputs[1])! // size of the map

var board = Board(h: height, w: width)
// game loop
while true {
    let inputs = (readLine()!).split(separator: " ").map(String.init)
    let _ = Int(inputs[0])! // Amount of ore delivered e.g. myScore
    let _ = Int(inputs[1])! // opponentsScore
    
    for i in 0...(height-1) {
        let inputs = (readLine()!).split(separator: " ").map(String.init)
        for j in 0...(width-1) {
            let ore = inputs[2*j] // amount of ore or "?" if unknown
            let hole = Int(inputs[2*j+1])! // 1 if cell has a hole
            
            board.g[i]![j] = Cell(x: j, y: i, ores: ore, hole: hole == 1)
        }
        
    }
    
    board.printBoard()
    
    let inputs2 = (readLine()!).split(separator: " ").map(String.init)
    let entityCount = Int(inputs2[0])! // number of entities visible to you
    let radarCooldown = Int(inputs2[1])! // turns left until a new radar can be requested
    let trapCooldown = Int(inputs2[2])! // turns left until a new trap can be requested
    if entityCount > 0 {
        for i in 0...(entityCount-1) {
            let inputs = (readLine()!).split(separator: " ").map(String.init)
            let entityId = Int(inputs[0])! // unique id of the entity
            let entityType = Int(inputs[1])! // 0 for your robot, 1 for other robot, 2 for radar, 3 for trap
            let x = Int(inputs[2])!
            let y = Int(inputs[3])! // position of the entity
            let item = Int(inputs[4])! // if this entity is a robot, the item it is carrying (-1 for NONE, 2 for RADAR, 3 for TRAP, 4 for ORE)

            // create MapObject Entity
            // add to grid
            // print more informations
        }
    }
    for i in 0...4 {

        // Write an action using print("message...")
        // To debug: print("Debug messages...", to: &errStream)

        print("WAIT")         // WAIT|MOVE x y|DIG x y|REQUEST item

    }
}
