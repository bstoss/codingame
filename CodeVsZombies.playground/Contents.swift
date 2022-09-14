// https://www.codingame.com/ide/puzzle/reverse-minesweeper

import UIKit

// input from game not setup to work
var input = ["0"]

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
    let id: Int
    let point: Point
    let moves: Int

    init(id: Int, x: Int, y: Int, moves: Int = 0) {
        self.id = id
        self.point = Point(x: x, y: y)
        self.moves = moves
    }
}

class Ash: MapObject {


}

class Human: MapObject {

}

class Zombie: MapObject {
    let target: Point

    init(id: Int, x: Int, y: Int, moves: Int = 0, tX: Int, tY: Int) {
        self.target = Point(x: tX, y: tY)
        super.init(id: id, x: x, y: y, moves: moves)
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

func reachableWithoutKilled<T: MapObject>(for humans: [T], zombies: [T], to obj: T) -> [T] {
    return humans.filter({ human in
        debug("Human: \(human.id) - \(human.point)")

        let distanceObj = human.point.distance(to: obj.point)
        debug("DistToAsh: \(distanceObj)")
        debug("Moves Ash: \(obj.moves)")
        if distanceObj == 0 {
            return false
        }
        if let nearestZombie = nearestList(for: zombies, to: human).first {
            debug("Zombie: \(nearestZombie.id) - \(nearestZombie.point)")
            let distanceHuZo = human.point.distance(to: nearestZombie.point)
             debug("DistToZom: \(distanceHuZo)")
             debug("Moves Zom: \(nearestZombie.moves)")
            if distanceHuZo == 0 {
                return false
            }

            let distObj = distanceObj / (obj.moves + 2000)
            let distZom = distanceHuZo / nearestZombie.moves
            debug("DistObj: \(distObj)")
            debug("DistZomn: \(distZom)")

            // if not savable
            if distObj >= distZom {
                return false
            }

            if distanceHuZo > 4000 {
                return false
            }
        }
        debug("------- SAVE HUMAN: \(human.id)")
        return true
    })
}

// this function uses humans as zombies and vice versa // lazy programmer :)
func reachableDangerZombie<T: MapObject>(for humans: [T], zombies: [T], to obj: T) -> [T] {
    return humans.filter({ human in
        debug("Human: \(human.id) - \(human.point)")

        let distanceObj = human.point.distance(to: obj.point)
        debug("DistToAsh: \(distanceObj)")
        debug("Moves Ash: \(obj.moves)")
        if distanceObj == 0 {
            return false
        }
        if let nearestZombie = nearestList(for: zombies, to: human).first {
            debug("Zombie: \(nearestZombie.id) - \(nearestZombie.point)")
            let distanceHuZo = human.point.distance(to: nearestZombie.point)
             debug("DistToZom: \(distanceHuZo)")
             debug("Moves Zom: \(nearestZombie.moves)")
            if distanceHuZo == 0 ||  nearestZombie.moves == 0 {
                return false
            }

            debug("DistObj: \(distanceObj / (obj.moves + 2000))")
            debug("DistZomn: \(distanceHuZo / (nearestZombie.moves + 400))")

            if distanceObj / (obj.moves + 2000) <= distanceHuZo / (nearestZombie.moves + 400) {
                return false
            }
        }
        debug("------- SAVE HUMAN: \(human.id)")
        return true
    })
}

// game loop
while true {
    let inputs = (readLine()!).split{$0 == " "}.map(String.init)
    let x = Int(inputs[0])!
    let y = Int(inputs[1])!
    let ash = Ash(id: 0, x: x, y: y)
    
    var humans: [Human] = []

    let humanCount = Int(readLine()!)!
    if humanCount > 0 {
        for i in 0...(humanCount-1) {
            let inputs = (readLine()!).split{$0 == " "}.map(String.init)
            let humanId = Int(inputs[0])!
            let humanX = Int(inputs[1])!
            let humanY = Int(inputs[2])!
            
            humans.append(Human(id: humanId, x: humanX, y: humanY))
        }
    }
    
    var zombies: [Zombie] = []
    let zombieCount = Int(readLine()!)!
    if zombieCount > 0 {
        for i in 0...(zombieCount-1) {
            let inputs = (readLine()!).split{$0 == " "}.map(String.init)
            let zombieId = Int(inputs[0])!
            let zombieX = Int(inputs[1])!
            let zombieY = Int(inputs[2])!
            let zombieXNext = Int(inputs[3])!
            let zombieYNext = Int(inputs[4])!
            
            let zombie = Zombie(id: zombieId, x: zombieX, y: zombieY, moves: 400, tX: zombieXNext, tY: zombieYNext)
            zombies.append(zombie)
        }
    }

    if zombieCount == 1 {
        let zombie = zombies.first!
        print("\(zombie.target.printableCoord)")
        continue
    }

    // finde den nahesten Mensch, den ein Zombie angreift, den ich noch retten kann.

    // finde den nahesten Zombie, der einen Menschen angreift, den ich noch töten kann

    // ADD find out which humans is reacheable befor get killed
    // distance nearest humand to there nearest zombie - 400
    
    let moveTo: MapObject



    // 60k Points
    // filter humans who can be saved by walking to him
    let sHumans = nearestList(for: humans, to: ash)
    let savableHumans = reachableWithoutKilled(for: sHumans, zombies: zombies, to: ash)
    let ssavableHumans = nearestList(for: savableHumans, to: ash)


    if let human = ssavableHumans.first {
        moveTo = human
    } else if let human = sHumans.first {
         moveTo = human
    } else {
        moveTo = ash
    }

    let zombie = nearestList(for: zombies, to: moveTo).first!
    
    // 41k points
    /*
    let sZombies = nearestList(for: zombies, to: ash)
    let killableZombies = reachableDangerZombie(for: sZombies, zombies: humans, to: ash)

    if let zombie = killableZombies.first {
         moveTo = zombie
    } else if let zombie = sZombies.first {
        moveTo = zombie
    } else {
        moveTo = ash
    }
    */

    print("\(zombie.point.printableCoord)") // Your destination coordinates
}
