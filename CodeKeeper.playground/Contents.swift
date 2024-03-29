// https://www.codingame.com/ide/puzzle/code-keeper---the-hero
import UIKit

// seed with #1 player
// seed=-2031791945071446300

var input = [
    "14 0 19 71 4 0 0",
    "17",
    "13 0 1 -1",
    "13 3 1 -1",
    "12 0 1 -1",
    "12 1 1 -1",
    "11 1 1 -1",
    "11 2 1 -1",
    "15 1 1 -1",
    "15 2 1 -1",
    "15 3 2 100",
    "14 2 1 -1",
    "14 3 1 -1",
    "15 0 14 -1",
    "14 1 14 -1",
    "11 0 14 -1",
    "13 1 14 -1",
    "13 2 14 -1",
    "12 2 14 -1"
]

var isDebug = true

func readLine() -> String? {
    return input.removeFirst()
}

func debug(_ mess: Any) {
    print("Debug: \(mess)")
}

func setLoop() {
    loop = false
}

/// Code begins here
///



public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}
public var errStream = StderrOutputStream()

//func debug(_ mess: Any) {
//    print("Debug: \(mess)", to: &errStream)
//}

//func setLoop() {
//    loop = false
//}


func read() -> String? {
    let line = readLine()
    debug(line!)
    return line
}


/**
 * Make the hero reach the exit of the maze alive.
 **/

typealias Position = (x: Int, y: Int)

enum EntityType: Int {
    case exit
    case obstacle
    case treasure
    case potion
    case chargeHammer
    case chargeScythe
    case chargeBow
    case box
    case skeleton
    case gargoyle
    case orc
    case vampire
    case hero
    case path
    case visited // 14
    case unknown
    
    var printId: String {
        switch self {
        case .exit: return "ex"
        case .obstacle: return "ob"
        case .treasure: return "tr"
        case .potion: return "po"
        case .chargeHammer: return "ch"
        case .chargeScythe: return "cs"
        case .chargeBow: return "cb"
        case .box: return "bo"
        case .skeleton: return "sk"
        case .gargoyle: return "ga"
        case .orc: return "or"
        case .vampire: return "va"
        case .hero: return "he"
        case .path: return "++"
        case .visited: return "--"
        case .unknown: return ".."
        }
    }
    
    var name: String {
        switch self {
        case .exit: return "Exit"
        case .obstacle: return "Obstacke"
        case .treasure: return "Treasure"
        case .potion: return "Potion"
        case .chargeHammer: return "Hammer"
        case .chargeScythe: return "Scythe"
        case .chargeBow: return "Bow"
        case .box: return "Box"
        case .skeleton: return "Bone"
        case .gargoyle: return "Bird"
        case .orc: return "Big Boy"
        case .vampire: return "Bloodsucker"
        case .hero: return "... (k)nowhere"
        case .path: return "new horizons"
        case .visited: return "... wait ... deja vu"
        case .unknown: return ".."
        }
    }
    
    var isAttackable: Bool {
        switch self {
        case .box, .skeleton, .gargoyle,
                .orc, .vampire:
            return true
        default:
            return false
        }
    }
    
    var isMonster: Bool {
        switch self {
        case .skeleton, .gargoyle,
                .orc, .vampire:
            return true
        default:
            return false
        }
    }
    
    var isChasingMonster: Bool {
        switch self {
        case .gargoyle, .vampire:
            return true
        default:
            return false
        }
    }
    
    var isItem: Bool {
        switch self {
        case .treasure, .chargeHammer,
                .chargeScythe, .chargeBow,
                .potion:
            return true
        default:
            return false
        }
    }
    
    var isPassable: Bool {
        self != .obstacle
    }
    
    var isPassableHorseMove: Bool {
        switch self {
        case .obstacle, .skeleton, .box:
            return false
        default:
            return true
        }
    }
}

func ==(lhs: Cell, rhs: Cell) -> Bool {
    return lhs.position.x == rhs.position.x &&
    lhs.position.y == rhs.position.y
}

class Cell {
    let position: Position
    var entity: Entity
    
    var print: String {
        return entity.print
    }
    
    init(position: Position, entity: Entity) {
        self.position = position
        self.entity = entity
    }
}

struct Entity {
    var type: EntityType
    var value: Int
    
    var print: String {
        return type.printId
    }
    
    init(type: EntityType = .unknown, value: Int = -1) {
        self.type = type
        self.value = value
    }
}

struct Hero {
    var position: Position
    var health: Int = 20
    var score: Int = 0
    var hammer: Int = 0
    var scythe: Int = 0
    var bow: Int = 0
}

// sword: 10 damage
// Applies damage to one cell that is a step away (in cardinal direction) from the hero.
// hammer: 6 damage
// Applies damage to three cells in range 1. If the given target is diagonal, the attack also hits the closest neighbours in the two adjacent cardinal directions from the hero. If the target is in a cardinal direction, it also hits the closest neighbouring cells in the two diagonal adjacent directions.
// scythe: 7 damage
// A target can be any cell in the chess queen move pattern limited to distance 2. The attack applies damage to the two cells covered by a queen move pattern containing the given target cell.
// bow: 8 damage
// Applies damage to any single cell visible by the hero (which is in range ≤ 3).
enum Weapon {
    case sword
    case hammer
    case scythe
    case bow
    
    var damage: Int {
        switch self {
        case .sword: return 10
        case .hammer: return 6
        case .scythe: return 7
        case .bow: return 8
        }
    }
}

// Exit: Ends the level with success and increases the score by 10000.
// Treasure: Increases the score by 100.
// Potion: Gives up to 10 health (never exceeds the hero's maximum health).
// Hammer: A chest giving additional hammer charge.
// Scythe: A chest giving additional scythe charge.
// Bow: A chest giving additional bow charge.
enum Item {
    case exit
    case treasure
    case potion
    case hammer
    case scythe
    case bow
}


// Box: 1 health, 0 view range, 0 attack range, 0 damage.
// Skeleton: 6 health, 1 view range, 1 attack range, 1 damage.
// Gargoyle: 14 health, 2 view range, 1 attack range, 2 damage.
// Orc: 8 health, 2 view range, 2 attack range, 2 damage.
// Vampire: 10 health, 3 view range, 1 attack range, 3 damage.
enum Monster {
    case box
    case skeleton
    case gargoyle
    case orc
    case vampire
    
    var health: Int {
        switch self {
        case .box: return 1
        case .skeleton: return 6
        case .gargoyle: return 14
        case .orc: return 8
        case .vampire: return 10
        }
    }
    
    var viewRange: Int {
        switch self {
        case .box: return 0
        case .skeleton: return 1
        case .gargoyle: return 2
        case .orc: return 2
        case .vampire: return 3
        }
    }
    
    var attackRange: Int {
        switch self {
        case .box: return 0
        case .skeleton: return 1
        case .gargoyle: return 1
        case .orc: return 2
        case .vampire: return 1
        }
    }
    
    var damage: Int {
        switch self {
        case .box: return 0
        case .skeleton: return 1
        case .gargoyle: return 2
        case .orc: return 2
        case .vampire: return 3
        }
    }
}

typealias Row = [Int: Cell]
typealias Grid = [Int: Row]

struct Board {
    let h: Int
    let w: Int
    
    // need 2 dimensions because of faster access
    var g: Grid = [:]
    
    var cells: [Cell] = []
    var visitedCells: [Cell] = []
    
    var exit: Cell?
    
    init(h: Int, w: Int) {
        self.h = h
        self.w = w
        setup()
    }
    
    mutating func setup() {
        
        for i in 0..<h {
            var row: Row = [:]
            for j in 0..<w {
                let cell = Cell(position: (j,i), entity: Entity())
                row[j] = cell
                cells.append(cell)
//                if let ent = g[i]?[j], ent.type == .visited {
//                    row[j] = ent
//                } else {
//                    row[j] = Entity(position: (j, i))
//                }
            }
            g[i] = row
        }
    }
    
    mutating func setEntity(forPosition position: Position, entity: Entity) {
        g[position.y]?[position.x]?.entity = entity
        
        if entity.type == .exit {
            self.exit = g[position.y]![position.x]!
        }
        if entity.type == .hero {
            visitedCells.append(g[position.y]![position.x]!)
        }
    }
    
    mutating func setPath(for position: Position) {
        for x in position.x-3...position.x+3 {
            for y in position.y-3...position.y+3 {
                guard let cell = g[y]?[x] else {
                    continue
                }
                if visitedCells.contains(where: { $0 == cell }) {
                    cell.entity.type = .visited
                } else {
                    cell.entity.type = .path
                }
            }
        }
    }
    
    func entity(for position: Position) -> Entity? {
        return cell(for: position)?.entity
    }
    
    func cell(for position: Position) -> Cell? {
        return g[position.y]?[position.x]
    }
    
    func printBoard() {
        
        for i in 0..<h {
            var print = ""
            for j in 0..<w {
                if let cell = g[i]?[j] as? Cell {
                    print += "[\(cell.print)]"
                } else {
                    print += "[..]"
                }
            }
            debug(print)
        }
    }
    
    
}



var hero = Hero(position: (-1,-1))
var board = Board(h: 12, w: 16)
var loop = true
var turn = 0
var steps: [Cell] = []

// game loop
while loop {
    turn += 1
    setLoop()
    //board.reset()
    
    let inputs = (read()!).split(separator: " ").map(String.init)
    let x = Int(inputs[0])! // x position of the hero
    let y = Int(inputs[1])! // y position of the hero
    hero.position = (x,y)
    hero.health = Int(inputs[2])! // current health points
    hero.score = Int(inputs[3])! // current score
    hero.hammer = Int(inputs[4])! // how many times the hammer can be used
    hero.scythe = Int(inputs[5])! // how many times the scythe can be used
    hero.bow = Int(inputs[6])! // how many times the bow can be used
    
    board.setPath(for: hero.position)
    
    let visibleEntities = Int(read()!)! // the number of visible entities
    if visibleEntities > 0 {
        for _ in 0...(visibleEntities-1) {
            let inputs = (read()!).split(separator: " ").map(String.init)
            let ex = Int(inputs[0])! // x position of the entity
            let ey = Int(inputs[1])! // y position of the entity
            let etype = Int(inputs[2])! // the type of the entity
            let evalue = Int(inputs[3])! // value associated with the entity
            
            let entity = Entity(type: EntityType(rawValue: etype)!, value: evalue)
            board.setEntity(forPosition:(ex,ey), entity: entity)
        }
    }
    board.setEntity(forPosition: hero.position, entity: Entity(type: .hero))
    // board.printBoard()
    
    DecissionMaker.makeDecission()
    
}

struct DecissionMaker {
    static func makeDecission() {
        
        if let cell = canAttackWithSwordNoBox() {
            print("ATTACK 0 \(cell.position.x) \(cell.position.y) Lets kill that \(cell.entity.type.name) with sword")
            return
        }
        
        // if chasing by monster and probaly are diagonal, than move back
        debug("check for chasing")
        if let chase = chasing() {
            print("\(chase.1) \(chase.0.position.x) \(chase.0.position.y) Lets \(chase.1) to \(chase.0.entity.type.name)")
            return
        }
        
        debug("check for exit if turn gets near end")
        if let exit = board.exit, turn >= 120 {
            if move(to: exit) {
                return
            } else {
                debug("exit is to far away ... damn")
            }
        }
        
        debug("check for attack")
        guard !Self.shouldAttack() else {
            return
        }
        
        Self.makeMove()
    }
    
    
    //sword: 10 damage
    //Applies damage to one cell that is a step away (in cardinal direction) from the hero.
    //hammer: 6 damage
    //Applies damage to three cells in range 1. If the given target is diagonal, the attack also hits the closest neighbours in the two adjacent cardinal directions from the hero. If the target is in a cardinal direction, it also hits the closest neighbouring cells in the two diagonal adjacent directions.
    //scythe: 7 damage
    //A target can be any cell in the chess queen move pattern limited to distance 2. The attack applies damage to the two cells covered by a queen move pattern containing the given target cell.
    //bow: 8 damage
    //Applies damage to any single cell visible by the hero (which is in range ≤ 3).
    
    
    static func shouldAttack() -> Bool {
        // 0 for sword, 1 for hammer, 2 for scythe, and 3 for bow.
        
        
        if hero.health < 8 {
            debug("check for exit")
            if let cell = getTheExit() {
                if move(to: cell) {
                    return true
                }
                debug("exit to far away")
            }
        }
        
        if let cell = canAttackWithSword() {
            print("ATTACK 0 \(cell.position.x) \(cell.position.y) Lets kill that \(cell.entity.type.name) with sword")
            return true
        }
        if let cell = canAttackWithHammer() {
            print("ATTACK 1 \(cell.position.x) \(cell.position.y) Lets kill that \(cell.entity.type.name) with hammer")
            return true
        }
        if let cell = canAttackWithBow() {
            print("ATTACK 3 \(cell.position.x) \(cell.position.y) Lets kill that \(cell.entity.type.name) with bow")
            return true
        }
        if let cell = canAttackWithScythe() {
            print("ATTACK 2 \(cell.position.x) \(cell.position.y) Lets kill that \(cell.entity.type.name) with scythe")
            return true
        }
        return false
    }
    
    static func makeMove() {
        
        // treasure somewhere?
        debug("check for item")
        if let cell = getItem() {
            if move(to: cell) {
                return
            }
        }
        
        // move towards unknown fields?
        debug("check for not visited path")
        if let cell = findNextNotVisitedPath() {
            if move(to: cell) {
                return
            }
        }
        
        // found exit?
        debug("check for exit")
        if turn < 120 {
            if let cell = getTheExit() {
                if move(to: cell) {
                    return
                }
            }
        }
        
        // TODO : find a solution here
        // step back seems to be ok.
        // would be more happy, to walk through exit here
        // if exit is to far away
        debug("panic mode")
        let cell = steps.removeLast()
        print("MOVE \(cell.position.x) \(cell.position.y) Let's move back ... cannot risk timeout again.")
    }
}

func chasing() -> (Cell, String)? {
    
    let x = hero.position.x
    let y = hero.position.y
    var i = 1
    let diagonalCells: [Cell] = [
        board.cell(for: (x-i, y-i)),
        board.cell(for: (x+i, y+i)),
        board.cell(for: (x+i, y-i)),
        board.cell(for: (x-i, y+i))
    ].compactMap({ $0 })
        .filter({ $0.entity.type.isChasingMonster })
    
    
    if !diagonalCells.isEmpty {
        debug("there is a diagonal enemy. Lets move back")
        // check in which cell to move here
        let cardinalCells: [Cell] = [
            board.cell(for: (x-i, y)),
            board.cell(for: (x+i, y)),
            board.cell(for: (x, y-i)),
            board.cell(for: (x, y+i))
        ].compactMap { $0 }
            .filter({ $0.entity.type.isPassable })
        
        var freeCells: [Cell] = []
        var possibleBoxCells: [Cell] = []
        
        for cell in cardinalCells {
            debug("Check safety of \(cell.position)")
            let cx = cell.position.x
            let cy = cell.position.y
            // is there a monster on the cardinal edges?
            
            let cells = [board.cell(for: (cx-1, cy-1)),
                         board.cell(for: (cx+1, cy+1)),
                         board.cell(for: (cx+1, cy-1)),
                         board.cell(for: (cx-1, cy+1)),
                         board.cell(for: (cx-1, cy)),
                         board.cell(for: (cx+1, cy)),
                         board.cell(for: (cx, cy-1)),
                         board.cell(for: (cx, cy+1))]
                .compactMap({$0})
            
            if !cells.contains(where: { $0.entity.type.isMonster || $0.entity.type == .box }) {
                freeCells.append(cell)
            } else if !cells.contains(where: { $0.entity.type.isMonster }) {
                possibleBoxCells.append(cell)
            }
        }
        
        if let cell = freeCells.first {
            return (cell, "MOVE")
        }
        
        if let cell = possibleBoxCells.first {
            return (cell, "MOVE")
        }
        
        return nil
    }
    
    
    i = 2
    let cardinalCells2: [Cell] = [
        board.cell(for: (x-i, y)),
        board.cell(for: (x+i, y)),
        board.cell(for: (x, y-i)),
        board.cell(for: (x, y+i))
    ].compactMap { $0 }
        .filter({ $0.entity.type.isChasingMonster })
    
    if !cardinalCells2.isEmpty {
        debug("There is cardinal enemy 2 cells ahead")
        // this will tell hero just to wait.
        // enemy is chasing already
        // but we need to check the diagonals as well,
        // to not move in there direction
        // obstacles in between could stop me forever
        for cell in cardinalCells2 {
            debug("check \(cell.position)")
            if x > cell.position.x {
                guard let nCell = board.cell(for: (x-1, y)), nCell.entity.type.isPassable else {
                    continue
                }
            }
            
            if x < cell.position.x {
                guard let nCell = board.cell(for: (x+1, y)), nCell.entity.type.isPassable else {
                    continue
                }
            }
            
            if y > cell.position.y {
                guard let nCell = board.cell(for: (x, y-1)), nCell.entity.type.isPassable else {
                    continue
                }
            }
            
            if y < cell.position.y {
                guard let nCell = board.cell(for: (x, y+1)), nCell.entity.type.isPassable else {
                    continue
                }
            }
            
            if cell.entity.value > 10 {
                if hero.scythe > 0 {
                    return (cell, "ATTACK 2")
                }
                if hero.bow > 0 {
                    return (cell, "ATTACK 3")
                }
            }
            
            // if we reach here, than the enemy will walk to me next turn
            return (board.cell(for: hero.position)!, "MOVE")
        }
    }
    
    let horseMoveCells: [Cell] = [
        board.cell(for: (x+2, y-1)),
        board.cell(for: (x+2, y+1)),
        board.cell(for: (x-2, y-1)),
        board.cell(for: (x-2, y+1)),
        board.cell(for: (x+1, y+2)),
        board.cell(for: (x-1, y+2)),
        board.cell(for: (x+1, y-2)),
        board.cell(for: (x-1, y-2))
    ].compactMap { $0 }
        .filter({ $0.entity.type.isChasingMonster })
    
    if !horseMoveCells.isEmpty {
        // the enemy is far away, but when i move to
        // the next field it could attack me.
        // so i wait, if its not a orc
        
        // seed=-3245625472022538000
        // has issue with horse move
        
        // --h
        // v
        
        // wenn wait, check if bow or scythe attack es needed!!!
        
        for cell in horseMoveCells {
            debug("HORSE CELL: \(cell.position)")
            
            // if horseMove is on the left
            if x-1 > cell.position.x {
                if y > cell.position.y {
                    debug("LEFT TOP HORSE MOVE")
                    guard let action = horseMoveCheck(position1: (x-1, y), position2: (x-2, y), position3: (x-1, y-1)) else {
                        continue
                    }
                    return action
                } else {
                    debug("LEFT BOTTOM HORSE MOVE")
                    guard let action = horseMoveCheck(position1: (x-1, y), position2: (x-2, y), position3: (x-1, y+1)) else {
                        continue
                    }
                    return action
                }
            }
            
            // if horseMove is on the right
            if x+1 < cell.position.x {
                if y > cell.position.y {
                    debug("RIGHT TOP HORSE MOVE")
                    guard let action = horseMoveCheck(position1: (x+1, y), position2: (x+2,y), position3: (x+1, y-1)) else {
                        continue
                    }
                    return action
                } else {
                    debug("RIGHT BOTTOM HORSE MOVE")
                    guard let action = horseMoveCheck(position1: (x+1, y), position2: (x+2,y), position3: (x+1, y+1)) else {
                        continue
                    }
                    return action
                }
                
            }
            
            // if horseMove is on the top
            if y-1 > cell.position.y {
                
                if x > cell.position.x {
                    debug("TOP LEFT HORSE MOVE")
                    guard let action = horseMoveCheck(position1: (x, y-1), position2: (x,y-2), position3: (x-1, y-1)) else {
                        continue
                    }
                    return action
                } else {
                    debug("TOP RIGHT HORSE MOVE")
                    guard let action = horseMoveCheck(position1: (x, y-1), position2: (x,y-2), position3: (x+1, y-1)) else {
                        continue
                    }
                    return action
                }
                
            }
            
            // if horseMove is at the bottom
            if y+1 < cell.position.y {
                
                if x > cell.position.x {
                    debug("BOTTOM LEFT HORSE MOVE")
                    guard let action = horseMoveCheck(position1: (x, y+1), position2: (x,y+2), position3: (x-1, y+1)) else {
                        continue
                    }
                    return action
                } else {
                    debug("BOTTOM RIGHT HORSE MOVE")
                    guard let action = horseMoveCheck(position1: (x, y+1), position2: (x,y+2), position3: (x+1, y+1)) else {
                        continue
                    }
                    return action
                }
                
            }
            
            // if we reach here, than the enemy will walk to me next turn
            return (board.cell(for: hero.position)!, "MOVE")
        }
    }
    
    return nil
}

func horseMoveCheck(position1: Position, position2: Position, position3: Position) -> (Cell, String)? {
    
    // one step in front
    let cell1 = board.cell(for: (position1.x, position1.y))
    
    // two steps in front
    let cell2 = board.cell(for: (position2.x, position2.y))
    
    // the direct diagonal cell of horsemove
    let diagonalCell = board.cell(for: (position3.x, position3.y))
    
    if let cell = diagonalCell,
       (cell.entity.type == .skeleton ||
        cell.entity.type == .box ||
        cell.entity.type == .orc) {
        if hero.hammer > 0 {
            return (cell, "ATTACK 1")
        }
        if hero.scythe > 0 {
            return (cell, "ATTACK 2")
        }
        if hero.bow > 0 {
            return (cell, "ATTACK 3")
        }
    }
    
    if let cell = cell2,
       (cell.entity.type == .skeleton ||
        cell.entity.type == .box ||
        cell.entity.type == .orc ||
        cell.entity.value > 10 ) {
        if hero.scythe > 0 {
            return (cell, "ATTACK 2")
        }
        if hero.bow > 0 {
            return (cell, "ATTACK 3")
        }
    }
    
    let cells = [
        cell1,
        cell2
    ].compactMap({ $0 })
    
    let cellsInFront = [
        cell1,
        diagonalCell
    ].compactMap({ $0 })
    
    if cells.filter({ $0.entity.type.isPassableHorseMove }).count == 2 ||
        cellsInFront.contains(where: { $0.entity.type.isPassableHorseMove }){
        
        debug("STAY")
        return (board.cell(for: hero.position)!, "MOVE")
    }
    
    
    if let cell = board.cell(for: (position1.x, position1.y)),
       (cell.entity.type == .skeleton || cell.entity.type == .box || cell.entity.type == .box) {
        if hero.hammer > 0 {
            return (cell, "ATTACK 1")
        }
        if hero.scythe > 0 {
            return (cell, "ATTACK 2")
        }
        if hero.bow > 0 {
            return (cell, "ATTACK 3")
        }
    }
    
    
    
    debug("SKIP")
    return nil
}

func findNext(cell: Cell, condition: ((Cell) -> Bool), depth: Int = 0, maxDepth: Int, lastCells: [Cell] = []) -> (Cell, Int)? {
    //debug("findNext - START CHECK CELL: \(cell.position) - \(depth)")
    
    var checkedCells = lastCells
    checkedCells.append(cell)
    
    var mutableMaxDepth = maxDepth
    
    let x = cell.position.x
    let y = cell.position.y
    
    let cardinalCells =  [
        board.cell(for: (x-1, y)),
        board.cell(for: (x+1, y)),
        board.cell(for: (x, y-1)),
        board.cell(for: (x, y+1))
    ].compactMap { $0 }
        .filter({ $0.entity.type.isPassable })
    
    if let cell = cardinalCells.first(where: condition) {
        // debug("findNext direct - Found cell that met condition: \(cell.position) - \(depth)")
        return (cell, depth)
    } else if depth <= maxDepth {
        var foundCells: [(Cell, Int)] = []
        
        for cell in cardinalCells {
            //debug("Current Cell Check \(currentCell.position)")
            
            if lastCells.contains(where: { $0 == cell }) {
                continue
            }
            
            if let found = findNext(cell: cell, condition: condition, depth: depth+1, maxDepth: mutableMaxDepth, lastCells: checkedCells) {
                // debug("findNext loop - Found cell that met condition - NextWay: \(cell.position) - \(depth)")
                foundCells.append((cell, found.1))
                if found.1 < mutableMaxDepth {
                    mutableMaxDepth = found.1
                }
            } else {
                continue
            }
        }
        
        return foundCells.sorted(by: { $0.1 < $1.1 }).first
    }
    
    return nil
}

func move(to cell: Cell) -> Bool {
    
    let heroCell = board.cell(for: hero.position)!
    let condition: ((Cell) -> Bool) = { $0 == cell }
    
    guard let foundCell = findNext(cell: heroCell, condition: condition, maxDepth: 10, lastCells: [])?.0 else {
        return false
    }
    
    print("MOVE \(foundCell.position.x) \(foundCell.position.y) Lets move to \(foundCell.entity.type.name)")
    steps.append(foundCell)
    return true
}
//
//
//func nearestPath(from fromPosition: Position, to toPosition: Position) -> Cell? {
//
//    board.cells.sorted { (left, right) -> Bool in
//        let ldistance = distance(from: left.position, to: obj.point)
//        let rdistance = right.point.distance(to: obj.point)
//        return ldistance < rdistance
//    }
//}


func distance(from fromPosition: Position, to toPosition: Position) -> Int {
    let y = toPosition.y - fromPosition.y
    let x = toPosition.x - fromPosition.x
    let distance = abs(y) + abs(x)
    return distance
}

// when enemy is walking to hero and next step would be diagonal pos
// remember this and move away until he is in cardinal direction

//func getPotion() -> Cell? {
//    let potions = board.cells.filter({ $0.entity.type == .potion })
//    let sPotions = potions.sorted { (left, right) -> Bool in
//        let ldistance = distance(from: left.position, to: hero.position)
//        let rdistance = distance(from: right.position, to: hero.position)
//        return ldistance < rdistance
//    }
//
//    return sPotions.first
//}

func getItem() -> Cell? {
    let heroCell = board.cell(for: hero.position)!
    let condition: ((Cell) -> Bool) = { $0.entity.type.isItem }
    
    guard let found = findNext(cell: heroCell, condition: condition, maxDepth: 5, lastCells: []) else {
        return nil
    }
    
    return found.0
}

func getTheExit() -> Cell? {
    return board.exit
}

func findNextNotVisitedPath() -> Cell? {
    
    let heroCell = board.cell(for: hero.position)!
    let condition: ((Cell) -> Bool ) = { cell in
        return !board.visitedCells.contains(where: { $0 == cell })
    }
    
    // TODO: i could add a check, that when target was found, i check if there items arround
    // if cells already known.
    // this could save unneded steps
    
    guard let found = findNext(cell: heroCell, condition: condition, maxDepth: 5, lastCells: []) else {
        return nil
    }
    
    return found.0
}

func canAttackWithSword() -> Cell? {
    let cells: [Cell] = [
        board.cell(for: (hero.position.x-1, hero.position.y)),
        board.cell(for: (hero.position.x+1, hero.position.y)),
        board.cell(for: (hero.position.x, hero.position.y-1)),
        board.cell(for: (hero.position.x, hero.position.y+1))
    ].compactMap { $0 }
    
    return cells.first(where: { $0.entity.type.isAttackable })
}

func canAttackWithSwordNoBox() -> Cell? {
    let cells: [Cell] = [
        board.cell(for: (hero.position.x-1, hero.position.y)),
        board.cell(for: (hero.position.x+1, hero.position.y)),
        board.cell(for: (hero.position.x, hero.position.y-1)),
        board.cell(for: (hero.position.x, hero.position.y+1))
    ].compactMap { $0 }
    
    
    guard let cell = cells.first(where: { $0.entity.type.isMonster }) else {
        return cells.first(where: { $0.entity.type == .box })
    }
    
    return cell
}

func canAttackWithScythe() -> Cell? {
    guard hero.scythe > 0 else {
        return nil
    }
    
    for x in hero.position.x-1...hero.position.x+1 {
        for y in hero.position.y-1...hero.position.y+1 {
            guard let cell = board.cell(for: (x, y)),
                  cell.entity.type.isAttackable,
                  cell.entity.type != .box else {
                continue
            }
            return cell
        }
    }
    
    let cells: [Cell] = [
        board.cell(for: (hero.position.x-2, hero.position.y)),
        board.cell(for: (hero.position.x+2, hero.position.y)),
        board.cell(for: (hero.position.x, hero.position.y-2)),
        board.cell(for: (hero.position.x, hero.position.y+2)),
        board.cell(for: (hero.position.x-2, hero.position.y-2)),
        board.cell(for: (hero.position.x+2, hero.position.y+2)),
        board.cell(for: (hero.position.x-2, hero.position.y+2)),
        board.cell(for: (hero.position.x+2, hero.position.y-2))
    ].compactMap { $0 }
    
    return cells.first(where: { $0.entity.type == .orc })
}

func canAttackWithHammer() -> Cell? {
    guard hero.hammer > 0 else {
        return nil
    }
    
    for x in hero.position.x-1...hero.position.x+1 {
        for y in hero.position.y-1...hero.position.y+1 {
            guard let cell = board.cell(for: (x, y)),
                  cell.entity.type.isAttackable,
                  cell.entity.type != .box else {
                continue
            }
            return cell
        }
    }
    
    return nil
}


func canAttackWithBow() -> Cell? {
    guard hero.bow > 0 else {
        return nil
    }
    
    for x in hero.position.x-3...hero.position.x+3 {
        for y in hero.position.y-3...hero.position.y+3 {
            guard let cell = board.cell(for: (x, y)),
                  cell.entity.type == .orc else {
                continue
            }
            return cell
        }
    }
    
    return nil
}

