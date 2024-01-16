// https://www.codingame.com/ide/puzzle/code-keeper---the-hero
import UIKit

// seed with #1 player
// seed=-2031791945071446300


// input from game not setup to work
//var input = [
//    "5 10 20 0 5 5 5",
//    "21",
//    "7 8 3 10",
//    "7 9 1 -1",
//    "7 10 4 1",
//    "7 11 2 100",
//    "2 7 9 14",
//    "2 9 1 -1",
//    "2 10 11 10",
//    "2 11 1 -1",
//    "4 7 1 -1",
//    "4 10 1 -1",
//    "6 7 1 -1",
//    "6 9 1 -1",
//    "6 10 4 1",
//    "6 11 1 -1",
//    "8 7 9 14",
//    "8 8 1 -1",
//    "8 9 1 -1",
//    "8 10 9 14",
//    "8 11 1 -1",
//    "3 7 1 -1",
//    "5 11 11 10"
//]
//
//var input = [
//    "6 1 11 -6 5 5 4",
//    "24",
//    "7 4 1 -1",
//    "9 0 9 6",
//    "9 1 1 -1",
//    "9 2 1 -1",
//    "9 3 1 -1",
//    "9 4 7 1",
//    "4 0 1 -1",
//    "4 2 1 -1",
//    "4 4 1 -1",
//    "6 0 1 -1",
//    "6 4 1 -1",
//    "8 1 8 6",
//    "8 2 11 10",
//    "8 3 1 -1",
//    "8 4 1 -1",
//    "3 2 3 10",
//    "3 4 4 1",
//    "5 0 2 100",
//    "5 2 1 -1",
//    "5 4 1 -1",
//    "7 0 1 -1",
//    "7 1 1 -1",
//    "7 2 11 10",
//    "7 3 1 -1"
//]

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
        case .potion: return "Postion"
        case .chargeHammer: return "Hammer"
        case .chargeScythe: return "Scythe"
        case .chargeBow: return "Bow"
        case .box: return "Box"
        case .skeleton: return "Skel"
        case .gargoyle: return "Bird"
        case .orc: return "Big Boy"
        case .vampire: return "Bloodsucker"
        case .hero: return "Hero"
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
    
    var isItem: Bool {
        switch self {
        case .treasure, .chargeHammer,
                .chargeScythe, .chargeBow:
            return true
        default:
            return false
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
    board.printBoard()
    
    DecissionMaker.makeDecission()
    
}

struct DecissionMaker {
    static func makeDecission() {
        
        if let exit = board.exit, turn >= 100 {
            move(to: exit)
            return
        }
        
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

        if let cell = getPotion(), hero.health <= 15 {
            move(to: cell)
            return true
        }
        
        if let cell = canAttackWithSword() {
            print("ATTACK 0 \(cell.position.x) \(cell.position.y) Lets kill that \(cell.entity.type.name) with sword")
            return true
        }
        if let cell = canAttackWithHammer() {
            print("ATTACK 1 \(cell.position.x) \(cell.position.y) Lets kill that \(cell.entity.type.name) with hammer")
            return true
        }
        if let cell = canAttackWithScythe() {
            print("ATTACK 2 \(cell.position.x) \(cell.position.y) Lets kill that \(cell.entity.type.name) with scythe")
            return true
        }
        if let cell = canAttackWithBow() {
            print("ATTACK 3 \(cell.position.x) \(cell.position.y) Lets kill that \(cell.entity.type.name) with bow")
            return true
        }
        
        // add hammer and scythe
        
        return false
    }
    
    static func makeMove() {
        // need potion and vissible?
        // attack has prio, thats why this can be to late.
        // check if path is open to walk through potion, if not, attack
        if let cell = getPotion(), hero.health <= 10 {
            move(to: cell)
            return
        }
        
        // treasure somewhere?
        if let cell = getItem() {
            move(to: cell)
            return
        }
        
        // move towards unknown fields?
        if let cell = findNextNotVisitedPath() {
            move(to: cell)
            return
        }
        
        // found exit?
        if let cell = getTheExit() {
            move(to: cell)
            return
        }
        
        print("MOVE 6 8 MOVE MOVE MOVE")
    }
}

func move(to cell: Cell) {
    debug("Target: \(cell.position.x) - \(cell.position.y)")
    let td = distance(from: hero.position, to: cell.position)
    debug("Distance: \(td)")
    
    if td > 2 {
        var cells: [Cell] = []
        
        // find the real path to cell
//        for x in hero.position.x-1...hero.position.x+1 {
//            for y in hero.position.y-1...hero.position.y+1 {
//                guard let cell = board.cell(for: (x, y)) else {
//                    continue
//                }
//                cells.append(cell)
//            }
//        }
        
        for x in hero.position.x-1...hero.position.x+1 {
            for y in hero.position.y-1...hero.position.y+1 {
                guard let cell = board.cell(for: (x, y)) else {
                    continue
                }
                cells.append(cell)
            }
        }
        
        let sCells = cells.sorted { (left, right) -> Bool in
            let ldistance = distance(from: left.position, to: cell.position)
            let rdistance = distance(from: right.position, to: cell.position)
            return ldistance < rdistance
        }

        let targetCell = sCells.first(where: { $0.entity.type != .obstacle && $0.entity.type != .exit })!
        print("MOVE \(targetCell.position.x) \(targetCell.position.y) Lets move to \(targetCell.entity.type.name)")

        
    } else {
        print("MOVE \(cell.position.x) \(cell.position.y) Lets move to \(cell.entity.type.name)")
    }
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

func getPotion() -> Cell? {
    let potions = board.cells.filter({ $0.entity.type == .potion })
    let sPotions = potions.sorted { (left, right) -> Bool in
        let ldistance = distance(from: left.position, to: hero.position)
        let rdistance = distance(from: right.position, to: hero.position)
        return ldistance < rdistance
    }
    
    return sPotions.first
}

func getItem() -> Cell? {
    let i = 1
    let x = hero.position.x
    let y = hero.position.y
    let cells: [Cell] = [
        board.cell(for: (x-i, y)),
        board.cell(for: (x+i, y)),
        board.cell(for: (x, y-i)),
        board.cell(for: (x, y+i)),
        board.cell(for: (x-i, y-i)),
        board.cell(for: (x+i, y+i)),
        board.cell(for: (x+i, y-i)),
        board.cell(for: (x-i, y+i))
    ].compactMap { $0 }
    return cells.first(where: { $0.entity.type.isItem })
}

func getTheExit() -> Cell? {
    return board.exit
}


func findNextNotVisitedPath() -> Cell? {
    let x = hero.position.x
    let y = hero.position.y
    for i in 1...16 {
        let cells: [Cell] = [
            board.cell(for: (x-i, y)),
            board.cell(for: (x+i, y)),
            board.cell(for: (x, y-i)),
            board.cell(for: (x, y+i)),
            board.cell(for: (x-i, y-i)),
            board.cell(for: (x+i, y+i)),
            board.cell(for: (x+i, y-i)),
            board.cell(for: (x-i, y+i))
        ].compactMap { $0 }
        guard let cell = cells.first(where: { cell1 in
            return cell1.entity.type == .path && !board.visitedCells.contains(where: { cell in
                return cell == cell1
            })
        }) else {
            continue
        }
        
        return cell
    }
    
    return nil
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
    
    return cells.first(where: { $0.entity.type.isAttackable })
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
                  cell.entity.type.isAttackable,
                  cell.entity.value <= Weapon.bow.damage,
                  cell.entity.type != .box else {
                continue
            }
            return cell
        }
    }
    
    return nil
}
