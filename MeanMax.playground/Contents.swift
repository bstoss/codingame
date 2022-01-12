//import Glibc
import Foundation

public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}
public var errStream = StderrOutputStream()

func debug(_ object: Any) {
    print("\(object)", to: &errStream)
}

enum Mode {
    case DEBUG
    case GAME
}

let mode = Mode.DEBUG

func score() -> Int {
    if mode == .DEBUG {
        return 1
    }
    return Int(readLine()!)!
}

func unitsCount() -> Int{
    if mode == .DEBUG {
        return 5
    }
    return Int(readLine()!)!
}

func oneUnit() -> [String] {
    if mode == .DEBUG {
        let line = "0 0 0 0.5 400 2213 1286 0 0 -1 -1"
        return line.split{$0 == " "}.map(String.init)
    }
    return (readLine()!).split{$0 == " "}.map(String.init)
}

// MARK: Models

enum UnitType: Int {
    case Reaper = 0
    case Destroyer = 1
    case Doof = 2
    case Tanker = 3
    case Wreck = 4

    var throttle: Int {
        switch self {
        case .Reaper, .Destroyer, .Doof:
            return 300
        case .Tanker:
            return 500
        case .Wreck:
            return -1
        }
    }

    var mass: Float {
        switch self {
        case .Reaper:
            return 0.5
        case .Destroyer:
            return 1.5
        case .Doof:
            return 1
        case .Tanker:
            return 2.5 // + W/2  ... maby the league?
        case .Wreck:
            return -1
        }
    }

    var friction: Float {
        switch self {
        case .Reaper:
            return 0.2
        case .Destroyer:
            return 0.3
        case .Doof:
            return 0.25
        case .Tanker:
            return 0.4
        case .Wreck:
            return -1
        }
    }
}

typealias Coord = (x: Int, y: Int)

struct Unit {
    let id: Int
    let type: UnitType
    let playerId: Int
    let mass: Float // same as type mass?
    let radius: Int
    let pos: Coord
    let speedX: Int
    let speedY: Int

    let water: Int // -1 if not wreck
    let extra2: Int // not used
}

func calculateDistance(between coord1: Coord, and coord2: Coord) -> Float {

    let a = pow(Float(coord1.x - coord2.x),2)
    let b = pow(Float(coord1.y - coord2.y),2)
    let d = sqrt(a+b)

    return d
}

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/


// game loop
while mode == .GAME {
    let myScore = score()
    let enemyScore1 = score()
    let enemyScore2 = score()
    let myRage = score()
    let enemyRage1 = score()
    let enemyRage2 = score()


    var units: [Unit] = []
    let unitCount = unitsCount()

    if unitCount > 0 {
        for _ in 0...(unitCount-1) {
            let inputs = oneUnit()
            let unitId = Int(inputs[0])!
            let unitType = Int(inputs[1])!
            let player = Int(inputs[2])!
            let mass = Float(inputs[3])!
            let radius = Int(inputs[4])!
            let x = Int(inputs[5])!
            let y = Int(inputs[6])!
            let vx = Int(inputs[7])! // Speed
            let vy = Int(inputs[8])! // Speed
            let extra = Int(inputs[9])! // whater of wrecks
            let extra2 = Int(inputs[10])!

            guard let type = UnitType(rawValue: unitType) else {
                continue
            }

            let unit = Unit(id: unitId, type: type, playerId: player, mass: mass, radius: radius, pos: (x, y), speedX: vx, speedY: vy, water: extra, extra2: extra2)

            units.append(unit)
        }
    }

    // Write an action using print("message...")
    // To debug: print("Debug messages...", to: &errStream)
    var wrecks = units.filter({$0.type == .Wreck})

    guard !wrecks.isEmpty, let myUnit = units.first(where: { $0.playerId == 0 }) else {
        print("WAIT")
        print("WAIT")
        print("WAIT")
        continue
    }

    wrecks.sort(by: { (leftU, rightU) -> Bool in
        let dL = calculateDistance(between: myUnit.pos, and: leftU.pos)
        let dR = calculateDistance(between: myUnit.pos, and: rightU.pos)
        return dL < dR
    })

    debug(wrecks)

    let firstWreck = wrecks.first!

    print("\(firstWreck.pos.x) \(firstWreck.pos.y) 100")
    print("WAIT")
    print("WAIT")
}
