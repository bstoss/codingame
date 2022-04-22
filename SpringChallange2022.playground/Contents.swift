/// https://www.codingame.com/ide/challenge/spring-challenge-2022

import Foundation

var input = ["0 0",
             "3",
             "3 0",
             "3 0",
             "6",
             "0 1 1131 1131 0 0 -1 -1 -1 -1 -1",
             "1 1 1414 849 0 0 -1 -1 -1 -1 -1",
             "2 1 849 1414 0 0 -1 -1 -1 -1 -1",
             "3 2 16499 7869 0 0 -1 -1 -1 -1 -1",
             "4 2 16216 8151 0 0 -1 -1 -1 -1 -1",
             "5 2 16781 7586 0 0 -1 -1 -1 -1 -1"]

func read() -> String {
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

 func read() -> String {
     let line = readLine()!
     debug(line)
     return line
 }

 */

// REAL CODE here

typealias Position = (x: Int, y: Int)

struct Base {
    let position: Position
    // max 3 points
    var health: Int = 3
}

enum UnitType: Int {
    case monster
    case player
    case enemy
}

enum ThreatFor: Int {
    case neither
    case playerBase
    case enemyBase
}

class Unit {
    let id: Int
    let position: Position
    
    init(id: Int, position: Position) {
        self.id = id
        self.position = position
    }
}

class Monster: Unit {
    let vPosition: Position
    let health: Int
    let targetsBase: Bool
    let threatFor: ThreatFor
    
    init(
        id: Int,
        position: Position,
        vPosition: Position,
        health: Int,
        targetsBase: Bool,
        threatFor: ThreatFor) {
            
            self.vPosition = vPosition
            self.health = health
            self.targetsBase = targetsBase
            self.threatFor = threatFor
            
            super.init(id: id, position: position)
        }
}

class Hero: Unit {
    
}

enum Command {
    case wait
    case move(Position)
    case spell
    
    var printOut: String {
        switch self {
        case .wait:
            return "WAIT"
        case .move(let pos):
            return "MOVE \(pos.0) \(pos.1)"
        case .spell: // not implemented
            return "SPELL"
        }
    }
}


/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

let inputs = (read()).split(separator: " ").map(String.init)
let baseX = Int(inputs[0])! // The corner of the map representing your base
let baseY = Int(inputs[1])!
let heroesPerPlayer = Int(read())! // Always 3

var base = Base(position: (x: baseX, y: baseY))

let guardPos: [Int: Position] = [0: (x: 4000, y: 4000),
                                 1: (x: 5500, y: 1700),
                                 2: (x: 1700, y: 5500)]
// game loop
while loop() {
    
    var playerUnits: [Hero] = []
    var enemyUnits: [Hero] = []
    var monsterUnits: [Monster] = []
    
    for _ in 0...1 {
        let _ = (read()).split(separator: " ").map(String.init)
        // currently not used ... or usefule
//        let health = Int(inputs[0])! // Each player's base health
//        let mana = Int(inputs[1])! // Ignore in the first league; Spend ten mana to cast a spell
    }
    let entityCount = Int(read())! // Amount of heros and monsters you can see
    if entityCount > 0 {
        for _ in 0...(entityCount-1) {
            let inputs = (read()).split(separator: " ").map(String.init)
            let id = Int(inputs[0])! // Unique identifier
            let type = Int(inputs[1])! // 0=monster, 1=your hero, 2=opponent hero
            let x = Int(inputs[2])! // Position of this entity
            let y = Int(inputs[3])!
            // let shieldLife = Int(inputs[4])! // Ignore for this league; Count down until shield spell fades
            // let isControlled = Int(inputs[5])! // Ignore for this league; Equals 1 when this entity is under a control spell
            let health = Int(inputs[6])! // Remaining health of this monster
            let vx = Int(inputs[7])! // Trajectory of this monster
            let vy = Int(inputs[8])!
            let nearBase = Int(inputs[9])! // 0=monster with no target yet, 1=monster targeting a base
            let threatFor = Int(inputs[10])! // Given this monster's trajectory, is it a threat to 1=your base, 2=your opponent's base, 0=neither
            
            switch UnitType(rawValue: type)! {
            case .player:
                playerUnits.append(Hero(id: id, position: (x: x, y: y)))
            case .enemy:
                enemyUnits.append(Hero(id: id, position: (x: x, y: y)))
            case .monster:
                let monster = Monster(
                    id: id,
                    position: (x: x, y: y),
                    vPosition: (x: vx, y: vy),
                    health: health,
                    targetsBase: nearBase == 1,
                    threatFor: ThreatFor(rawValue: threatFor)!
                )
                monsterUnits.append(monster)
            }
        }
    }
    if heroesPerPlayer > 0 {
        for i in 0...(heroesPerPlayer-1) {
            
           
            
            // In the first league: MOVE <x> <y> | WAIT; In later leagues: | SPELL <spellParams>;
            print(Command.move(guardPos[i]!).printOut)
        }
    }
}
