// https://www.codingame.com/ide/puzzle/crystal-rush

import UIKit

// input from game not setup to work
var input = ["30 16"]

func readLine() -> String? {
    return input.removeFirst()
}

/*
 current state
 * board is build
 * each cell gets the enitities
 * an entitiy has an item
 
 - TODO
 * strategie for radar
 * strategie for moving arround
 --- if ore -> dig
 --- if enemy radar - dig
 * when to dig
 * mine found ore, how many?
 *
 
 */

/// Code begins here
///

public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}
public var errStream = StderrOutputStream()

func debug(_ message: String) {
    //debugPrint(message, to: &errStream)
    //print(message)
}

func random(from:Int, to:Int) -> Int {
    var rng = SystemRandomNumberGenerator()
    return Int.random(in: from..<to, using: &rng)
}

struct Point: Hashable {
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

extension Point: Equatable {}

class MapObject {
    let point: Point
    
    init(x: Int, y: Int) {
        self.point = Point(x: x, y: y)
    }
}

enum EntityType: Int {
    case playerRobot = 0
    case otherRobot = 1
    case radar = 2
    case trap = 3
    
    var print: String {
        switch self {
        case .playerRobot:
            return "p"
        case .otherRobot:
            return "e"
        case .radar:
            return "r"
        case .trap:
            return "t"
        }
    }
}

enum ItemType: Int {
    case radar = 2
    case trap = 3
    case ore = 4
    
    var print: String {
        switch self {
        case .radar:
            return "r"
        case .trap:
            return "t"
        case .ore:
            return "o"
        }
    }
}

struct Entity {
    let id: Int
    let type: EntityType
    let item: ItemType?
    
    var print: String {
        return "\(id)\(type.print)\(item?.print ?? "n")"
    }
}

class Cell: MapObject {
    
    let ores: Int?
    let hole: Bool
    var entities: [Entity] = []
    
    var isHome: Bool {
        point.x == 0
    }

    init(x: Int, y: Int, ores: String, hole: Bool) {
        self.ores = Int(ores)
        self.hole = hole
        super.init(x: x, y: y)
    }
    
    var print: String {
        var print = ""
        for entity in entities {
            print += "|\(entity.print)|"
        }
        return print + "[\(ores ?? 0)\(hole ? 1 : 0)]"
    }
    
    var printWithCoord: String {
        return "\(print)\(point.y)\(point.x)"
    }
    
    func entity(withId id: Int) -> Entity? {
        return entities.first(where: { $0.id == id })
    }
}

func nearest<T: Cell>(for units: [T], to obj: T, excluding: Set<Point>? = nil, minOre: Int? = nil) -> T? {
    
    let sortedUnits = units.sorted { (left, right) -> Bool in
        let ldistance = left.point.distance(to: obj.point)
        let rdistance = right.point.distance(to: obj.point)
        return ldistance < rdistance
    }
    
    guard let excl = excluding else {
        return sortedUnits.first
    }
    
    return sortedUnits.first(where: { cell in
        guard let excl = excluding, !excl.contains(cell.point) else {
            return false
        }
        if let minO = minOre {
            guard let cellO = cell.ores, cellO >= minO  else {
                return false
            }
            return true
        }
        return true
    })
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
    
    var cells: [Cell] = []
    
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
    
    mutating func setCell(_ cell: Cell) {
        g[cell.point.y]![cell.point.x] = cell
        
        cells.append(cell)
    }
    
    func setEntity(_ entity: Entity, toCellAtPoint p: Point) {
        guard p.x >= 0, p.y >= 0 else {
            return
        }
        (g[p.y]![p.x]! as! Cell).entities.append(entity)
    }
    
    func playerCells() -> [Cell] {
        let pCells = cells.filter({ cell in
            cell.entities.contains(where: { $0.type == .playerRobot})
        })
        
        return pCells
        /*
         return pCells.sorted { l, r in
         let lid = l.entities.first(where: { $0.type == .playerRobot })!.id
         let rid = r.entities.first(where: { $0.type == .playerRobot })!.id
         return lid < rid
         }*/
    }
    
    func oreCells() -> [Cell] {
        let oCells = cells.filter({ cell in
            if let ores = cell.ores {
                return ores > 0
            }
            return false
        })
        
        return oCells.sorted { l, r in
            l.point.x < r.point.x
        }
    }
    
    func radarCells() -> [Cell] {
        let rCells = cells.filter({ cell in
            cell.entities.contains(where: { $0.type == .radar})
        })
        
        return rCells
        
    }
    
    func printBoard() {
        
        for i in 0..<h {
            var print = ""
            for j in 0..<w {
                if let cell = g[i]?[j] as? Cell {
                    print += "\(cell.print)"
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

var radarPos: [Point] = [
    Point(x: 7, y: 7),
    Point(x: 15, y: 7),
    Point(x: 12, y: 3),
    Point(x: 12, y: 11),

    Point(x: 4, y: 3),
    Point(x: 4, y: 11),
    //Point(x: 12, y: 3),
    //Point(x: 12, y: 11),
    Point(x: 20, y: 3),
    Point(x: 20, y: 11),
    Point(x: 23, y: 7),
    Point(x: 27, y: 3),
    Point(x: 27, y: 11)
]

var trapList: Set<Point> = []

while(true) {
    board.cells = []
    let inputs = (readLine()!).split(separator: " ").map(String.init)
    let _ = Int(inputs[0])! // Amount of ore delivered e.g. myScore
    let _ = Int(inputs[1])! // opponentsScore
    
    for i in 0...(height-1) {
        let inputs = (readLine()!).split(separator: " ").map(String.init)
        for j in 0...(width-1) {
            let ore = inputs[2*j] // amount of ore or "?" if unknown
            let hole = Int(inputs[2*j+1])! // 1 if cell has a hole
            let cell =  Cell(x: j, y: i, ores: ore, hole: hole == 1)
            board.setCell(cell)
        }
        
    }
    
    let inputs2 = (readLine()!).split(separator: " ").map(String.init)
    let entityCount = Int(inputs2[0])! // number of entities visible to you
    let radarCooldown = Int(inputs2[1])! // turns left until a new radar can be requested
    let trapCooldown = Int(inputs2[2])! // turns left until a new trap can be requested
    
    var playerRobotIds: [Int] = []
    var wearingRadar = false
    var ammountOtherRobot = 0
    if entityCount > 0 {
         var newTrapList: Set<Point> = []

        for i in 0...(entityCount-1) {
            let inputs = (readLine()!).split(separator: " ").map(String.init)
            let entityId = Int(inputs[0])! // unique id of the entity
            let entityType = EntityType(rawValue: Int(inputs[1])!)! // 0 for your robot, 1 for other robot, 2 for radar, 3 for trap
            let x = Int(inputs[2])!
            let y = Int(inputs[3])! // position of the entity
            let item = ItemType(rawValue: Int(inputs[4])!) // if this entity is a robot, the item it is carrying (-1 for NONE, 2 for RADAR, 3 for TRAP, 4 for ORE)
            
            // create MapObject Entity
            // add to grid
            // print more informations
            
            let entity = Entity(id: entityId, type: entityType, item: item)
            board.setEntity(entity, toCellAtPoint: Point(x: x, y: y))
            
            if entityType == .playerRobot {
                playerRobotIds.append(entityId)
                if !wearingRadar, item == .trap {
                    wearingRadar = true
                }
            }

            if entityType == .otherRobot {
                ammountOtherRobot += 1
            }

            if entityType == .trap {
                debug("TRAP")
                newTrapList.insert(Point(x: x, y: y))
            }
        }
        trapList = newTrapList
    }
    
    board.printBoard()
    
    playerRobotIds.sort(by: <)
    let players = board.playerCells()
    var ores = board.oreCells()
    let radars = board.radarCells()
    
    var requestRadar = false
    var requestTrap = false
    var someoneMovingHome = players.contains(where: { cell in
        cell.entities.contains(where: { entity in
            entity.type == .playerRobot && entity.item == .ore
        })
    })
    for i in 0...4 {
        let playerId = playerRobotIds[i]
        guard let playerCell = players.first(where: { $0.entity(withId: playerId) != nil }) else {
            print("WAIT")
            continue
        }
        let player = playerCell.entity(withId: playerId)!
        if let item = player.item {
            var didPrint = false
            switch item {
            case .radar:
                // TODO: add logic wher to add radar
                // 5 in front. if not radar than more 5
//                print("DIG 5 12")
                for rpos in radarPos {
                    debug(rpos.printableCoord)
                    if !radars.contains(where: { $0.point == rpos }) {
                        print("DIG \(rpos.printableCoord)")
                        didPrint = true
                        break
                    }
                }
            case .ore:
                // go home
                print("MOVE 0 \(playerCell.point.y)")
                didPrint = true
             case .trap:
                // dont know
                // place it on nearest ore?
                if let ore = nearest(for: ores, to: playerCell, excluding: trapList, minOre: 2) {
                    ores.removeAll(where: { cell in
                        if let ores = cell.ores, ores <= 1, cell.point == ore.point  {
                            return true
                        }
                        return false
                    })
                    print("DIG \(ore.point.printableCoord)")
                    trapList.insert(ore.point)
                    didPrint = true
                }
            }
            if didPrint {
                continue
            }
        }
        
        if (!someoneMovingHome || playerCell.isHome), !wearingRadar, trapCooldown <= 1, !requestTrap, ores.count >= 5, ammountOtherRobot > 0 {
            // check if not already someone is moving home
            print("REQUEST trap")
            requestTrap = true
            continue
        }

        if let ore = nearest(for: ores, to: playerCell, excluding: trapList) {
            ores.removeAll(where: { cell in
                if let ores = cell.ores, ores <= 1, cell.point == ore.point  {
                    return true
                }
                return false
            })
            print("DIG \(ore.point.printableCoord)")
            continue
        }

        if (!someoneMovingHome || playerCell.isHome), radarCooldown <= 1, !requestRadar {
             // check if not already someone is moving home
            print("REQUEST radar")
            requestRadar = true
            continue
        }

        
        
        let digX1 = random(from: max(1, playerCell.point.x - 3), to: max(2, playerCell.point.x))
        //debug("\(digX1)")
        let digX2 = random(from: max(3, playerCell.point.x), to: min(width-1, playerCell.point.x + 4))
        //debug("\(digX2)")
        let digX = random(from: digX1, to: digX2)
        //debug("\(digX)")
        
        let digY1 = random(from: max(1, playerCell.point.y - 3), to: max(2, playerCell.point.y))
        let digY2 = random(from: max(3, playerCell.point.y), to: min(height-1, playerCell.point.y + 4))
        let digY = random(from: digY1, to: digY2)
        
        print("DIG \(digX) \(digY)")
        //print("WAIT")
        
        // WAIT|MOVE x y|DIG x y|REQUEST item
    }
}
