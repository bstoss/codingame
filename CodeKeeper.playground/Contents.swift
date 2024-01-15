// https://www.codingame.com/ide/puzzle/code-keeper---the-hero
import UIKit

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

var input = [
    "6 1 11 -6 5 5 4",
    "24",
    "7 4 1 -1",
    "9 0 9 6",
    "9 1 1 -1",
    "9 2 1 -1",
    "9 3 1 -1",
    "9 4 7 1",
    "4 0 1 -1",
    "4 2 1 -1",
    "4 4 1 -1",
    "6 0 1 -1",
    "6 4 1 -1",
    "8 1 8 6",
    "8 2 11 10",
    "8 3 1 -1",
    "8 4 1 -1",
    "3 2 3 10",
    "3 4 4 1",
    "5 0 2 100",
    "5 2 1 -1",
    "5 4 1 -1",
    "7 0 1 -1",
    "7 1 1 -1",
    "7 2 11 10",
    "7 3 1 -1"
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
    case visited
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
        case .path: return "++"
        case .visited: return "--"
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

struct Entity {
    let position: Position
    var type: EntityType
    var value: Int
    
    var print: String {
        return type.printId
    }
    
    init(position: Position, type: EntityType = .unknown, value: Int = -1) {
        self.position = position
        self.type = type
        self.value = value
    }
}

struct Hero {
    var position: Position = (-1,-1)
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

typealias Row = [Int: Entity]
typealias Grid = [Int: Row]

struct Board {
    let h: Int
    let w: Int
    
    // need 2 dimensions because of faster access
    var g: Grid = [:]
    
    //var entities: [Entity] = []
    
    var exit: Entity?
    
    init(h: Int, w: Int) {
        self.h = h
        self.w = w
        reset()
    }
    
    mutating func reset() {
        var newG: Grid = [:]
        for i in 0..<h {
            var row: Row = [:]
            for j in 0..<w {
                if let ent = g[i]?[j], ent.type == .visited {
                    row[j] = ent
                } else {
                    row[j] = Entity(position: (j, i))
                }
            }
            newG[i] = row
        }
        
        g = newG
    }
    
    mutating func setEntity(_ entity: Entity) {
        g[entity.position.y]![entity.position.x] = entity
        
        if entity.type == .exit {
            self.exit = entity
        }
      //  entities.append(entity)
    }
    
    mutating func setVisited(for position: Position) {
        g[position.y]?[position.x]?.type = .visited
    }
    
    mutating func setPath(for position: Position) {
        for x in position.x-3...position.x+3 {
            for y in position.y-3...position.y+3 {
                guard let row = g[y], let entity = row[x], (entity.type == .unknown || entity.type == .hero) else {
                    continue
                }
                g[y]![x]!.type = .path
            }
        }
    }
    
    func entity(for position: Position) -> Entity? {
        return g[position.y]?[position.x]
    }
    
    func printBoard() {
        
        for i in 0..<h {
            var print = ""
            for j in 0..<w {
                if let entity = g[i]?[j] as? Entity {
                    print += "[\(entity.print)]"
                } else {
                    print += "[..]"
                }
            }
            debug(print)
        }
    }

    
}



var hero = Hero()
var board = Board(h: 12, w: 16)
var loop = true

// game loop
while loop {
    setLoop()
    board.setVisited(for: hero.position)
    board.reset()
    
    let inputs = (read()!).split(separator: " ").map(String.init)
    let x = Int(inputs[0])! // x position of the hero
    let y = Int(inputs[1])! // y position of the hero
    hero.position = (x,y)
    hero.health = Int(inputs[2])! // current health points
    hero.score = Int(inputs[3])! // current score
    hero.hammer = Int(inputs[4])! // how many times the hammer can be used
    hero.scythe = Int(inputs[5])! // how many times the scythe can be used
    hero.bow = Int(inputs[6])! // how many times the bow can be used
    
    
    let visibleEntities = Int(read()!)! // the number of visible entities
    if visibleEntities > 0 {
        for _ in 0...(visibleEntities-1) {
            let inputs = (read()!).split(separator: " ").map(String.init)
            let ex = Int(inputs[0])! // x position of the entity
            let ey = Int(inputs[1])! // y position of the entity
            let etype = Int(inputs[2])! // the type of the entity
            let evalue = Int(inputs[3])! // value associated with the entity
            
            let entity = Entity(position: (ex, ey), type: EntityType(rawValue: etype)!, value: evalue)
            board.setEntity(entity)
        }
    }
    board.setPath(for: hero.position)
    board.setEntity(Entity(position: hero.position, type: .hero))
    board.printBoard()
    
    DecissionMaker.makeDecission()
    
}

struct DecissionMaker {
    static func makeDecission() {
        
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

        if let entity = canAttackWithSword() {
            print("ATTACK 0 \(entity.position.x) \(entity.position.y) Lets kill that \(entity.type.name) with sword")
            return true
        } else if let entity = canAttackWithHammer() {
            print("ATTACK 1 \(entity.position.x) \(entity.position.y) Lets kill that \(entity.type.name) with hammer")
            return true
        } else if let entity = canAttackWithScythe() {
            print("ATTACK 2 \(entity.position.x) \(entity.position.y) Lets kill that \(entity.type.name) with scythe")
            return true
        } else if let entity = canAttackWithBow() {
            print("ATTACK 3 \(entity.position.x) \(entity.position.y) Lets kill that \(entity.type.name) with bow")
            return true
        }
        
        // add hammer and scythe
        
        return false
    }
    
    static func makeMove() {
        // need potion and vissible?
        if let entity = getPotion(), hero.health <= 10 {
            print("MOVE \(entity.position.x) \(entity.position.y) Lets move to potion")
            return
        }
        
        // found exit?
        if let entity = getTheExit() {
            print("MOVE \(entity.position.x) \(entity.position.y) Lets move to a new field")
            return
        }
        
        // treasure somewhere?
        if let entity = getItem() {
            print("MOVE \(entity.position.x) \(entity.position.y) Lets move to \(entity.type.name)")
            return
        }
        
        // move towards unknown fields?
        if let entity = findNextNotVisitedPath() {
            print("MOVE \(entity.position.x) \(entity.position.y) Lets move to a new field")
            return
        }
        
        print("MOVE 6 8 MOVE MOVE MOVE")
    }
}

func getPotion() -> Entity? {
    let x = hero.position.x
    let y = hero.position.y
    for i in 1...2 {
        let entities: [Entity] = [
            board.entity(for: (x-i, y)),
            board.entity(for: (x+i, y)),
            board.entity(for: (x, y-i)),
            board.entity(for: (x, y+i)),
            board.entity(for: (x-i, y-i)),
            board.entity(for: (x+i, y+i)),
            board.entity(for: (x+i, y-i)),
            board.entity(for: (x-i, y+i))
        ].compactMap { $0 }
        guard let entity = entities.first(where: { $0.type == .potion }) else {
            continue
        }
        
        return entity
    }
    
    return nil
}

func getItem() -> Entity? {
    let i = 1
    let x = hero.position.x
    let y = hero.position.y
    let entities: [Entity] = [
        board.entity(for: (x-i, y)),
        board.entity(for: (x+i, y)),
        board.entity(for: (x, y-i)),
        board.entity(for: (x, y+i)),
        board.entity(for: (x-i, y-i)),
        board.entity(for: (x+i, y+i)),
        board.entity(for: (x+i, y-i)),
        board.entity(for: (x-i, y+i))
    ].compactMap { $0 }
    return entities.first(where: { $0.type.isItem })
}

func getTheExit() -> Entity? {
    return board.exit
}


func findNextNotVisitedPath() -> Entity? {
    let x = hero.position.x
    let y = hero.position.y
    for i in 1...5 {
        let entities: [Entity] = [
            board.entity(for: (x-i, y)),
            board.entity(for: (x+i, y)),
            board.entity(for: (x, y-i)),
            board.entity(for: (x, y+i)),
            board.entity(for: (x-i, y-i)),
            board.entity(for: (x+i, y+i)),
            board.entity(for: (x+i, y-i)),
            board.entity(for: (x-i, y+i))
        ].compactMap { $0 }
        guard let entity = entities.first(where: { $0.type == .path }) else {
            continue
        }
        
        return entity
    }
    
    return nil
}



func canAttackWithSword() -> Entity? {
    let entities: [Entity] = [
        board.entity(for: (hero.position.x-1, hero.position.y)),
        board.entity(for: (hero.position.x+1, hero.position.y)),
        board.entity(for: (hero.position.x, hero.position.y-1)),
        board.entity(for: (hero.position.x, hero.position.y+1))
    ].compactMap { $0 }
    
    return entities.first(where: { $0.type.isAttackable })
}

func canAttackWithScythe() -> Entity? {
    guard hero.scythe > 0 else {
        return nil
    }
    
    let entities: [Entity] = [
        board.entity(for: (hero.position.x-1, hero.position.y-1)),
        board.entity(for: (hero.position.x+1, hero.position.y+1)),
        board.entity(for: (hero.position.x-2, hero.position.y-2)),
        board.entity(for: (hero.position.x+2, hero.position.y+2))
    ].compactMap { $0 }
    
    return entities.first(where: {
        $0.type.isAttackable && $0.type != .box
    })
}

func canAttackWithHammer() -> Entity? {
    guard hero.hammer > 0 else {
        return nil
    }
        
    for x in hero.position.x-1...hero.position.x+1 {
        for y in hero.position.y-1...hero.position.y+1 {
            guard let entity = board.entity(for: (x, y)),
                    entity.type.isAttackable,
                  entity.type != .box else {
                continue
            }
            return entity
        }
    }
    
    return nil
}


func canAttackWithBow() -> Entity? {
    guard hero.bow > 0 else {
        return nil
    }
    
    for x in hero.position.x-3...hero.position.x+3 {
        for y in hero.position.y-3...hero.position.y+3 {
            guard let entity = board.entity(for: (x, y)),
                    entity.type.isAttackable,
                  entity.type != .box else {
                continue
            }
            return entity
        }
    }
    
    return nil
}
