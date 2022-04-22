//: Playground - noun: a place where people can play

import UIKit
// Version  Bronze League


enum Team: Int {
    case Orange = 0
    case Purple = 1
}

 
/**
 * Send your busters out into the fog to trap ghosts and bring them home!
 **/

let bustersPerPlayer = Int(readLine()!)! // the amount of busters you control
let ghostCount = Int(readLine()!)! // the amount of ghosts on the map
let myTeamId = Int(readLine()!)! // if this is 0, your base is on the top left of the map, if it is one, on the bottom right

var base = (x: 0, y: 0)
var enemyBase = (x: 16000, y: 9000)
if myTeamId == 1 {
    enemyBase = base
    base = (x: 16000, y: 9000)
}

var targets = Targets(withAmountOfBusters: bustersPerPlayer, team: Team(rawValue: myTeamId)!)
var bustersStunCounter = BustersStunCount()
var released = 0
var spottedGhosts = SpottedGhosts(withTeam: Team(rawValue: myTeamId)!)
// game loop
while true {
    bustersStunCounter.reduceStunForTurn()
    
    let entities = Int(readLine()!)! // the number of busters and ghosts visible to you
    
    var busters: [Buster] = []
    var enemies: [Buster] = []
    var ghosts: [Ghost] = []
    if entities > 0 {
        for i in 0...(entities-1) {
            let inputs = (readLine()!).characters.split{$0 == " "}.map(String.init)
            let entityId = Int(inputs[0])! // buster id or ghost id
            let x = Int(inputs[1])!
            let y = Int(inputs[2])! // position of this buster / ghost
            let entityType = Int(inputs[3])! // the team id if it is a buster, -1 if it is a ghost.
            let state = Int(inputs[4])! // For busters: 0=idle, 1=carrying a ghost.
            let value = Int(inputs[5])! // For busters: Ghost id being carried. For ghosts: number of busters attempting to trap this ghost.
            if entityType == -1 {
                let ghost = Ghost(x: x, y: y, id: entityId, bustersAttemping: value, stamina: state)
                ghosts.append(ghost)
            } else if entityType == myTeamId {
                let state = BusterState(rawValue: state)
                let buster = Buster(x: x, y: y, id: entityId, state: state!, value: value)
                busters.append(buster)
            } else {
                let state = BusterState(rawValue: state)
                let enemy = Buster(x: x, y: y, id: entityId, state: state!, value: value)
                enemies.append(enemy)
            }
            
            
        }
    }
    
    spottedGhosts.updateGhosts(ghosts)
    
    if bustersPerPlayer > 0 {
        for i in 0...(bustersPerPlayer-1) {
            let buster = busters[i]
            
            // Bring Back and release ghost
            if buster.state == .CarryingGhost {
                if buster.isInRangeOfBase(x: base.x, y: base.y) {
                    print("RELEASE")
                    released++
                } else {
                    print("MOVE \(base.x) \(base.y)")
                    spottedGhosts.removeGhost(withId: buster.value!)
                }
                continue
            }
            
            // Stun Enemy
            if enemies.count > 0 && bustersStunCounter.busterCanStun(withId: buster.id) {
                
                var targeted = false
                
                for i in 0...(enemies.count-1) {
                    let enemy = enemies[i]
                    if buster.isInRangeOfBuster(x: enemy.x, y:enemy.y) && enemy.state != .Stunned {
                        print("STUN \(enemy.id)")
                        targeted = true
                        enemies.removeAtIndex(i)
                        bustersStunCounter.addBuster(withId: buster.id)
                        break
                    } else if enemy.state == .Catching {
                        targeted = true
                        print("MOVE \(enemy.x) \(enemy.y)")
                    }
                }
                if targeted {
                    continue
                }
            }
            
            // Get Ghost and Follow
            guard let ghost = spottedGhosts.nextFreeGhost(forBuster: buster) else {
                let nextPosition = targets.nextTargetPosition(forBuster: buster)
                print("MOVE \(nextPosition.x) \(nextPosition.y)")
                continue
            }
            
            if buster.isInRangeOfGhost(x: ghost.x, y: ghost.y) && ghost.visible {
                
                print("BUST \(ghost.id)")
            } else if buster.isToCloseForGhost(x: ghost.x, y: ghost.y) && ghost.visible {
                let nextPosition = targets.nextTargetPosition(forBuster: buster)
                print("MOVE \(nextPosition.x) \(nextPosition.y)")
            } else if buster.isToCloseForGhost(x: ghost.x, y: ghost.y) && !ghost.visible {
                spottedGhosts.removeGhost(withId: ghost.id)
                let nextPosition = targets.nextTargetPosition(forBuster: buster)
                print("MOVE \(nextPosition.x) \(nextPosition.y)")
            } else {
                print("MOVE \(ghost.x) \(ghost.y)")
            }
        }
    }
}// Version  Bronze League

import Glibc
import Foundation

public struct StderrOutputStream: OutputStreamType {
    public mutating func write(string: String) { fputs(string, stderr) }
}
public var errStream = StderrOutputStream()

enum BusterState: Int {
    case Idle
    case CarryingGhost
    case Stunned
    case Catching
}

struct Buster {
    let x: Int
    let y: Int
    let id: Int
    let state: BusterState
    let value: Int?
    
    public init(x:Int, y:Int, id:Int, state: BusterState, value:Int?) {
        self.x = x
        self.y = y
        self.id = id
        self.state = state
        self.value = value
    }
    
    func isInRangeOfBase(x x: Int, y:Int) -> Bool {
        
        let yy = Float(y - self.y) * Float(y - self.y)
        let xx = Float(self.x - x) * Float(self.x - x)
        
        let distance = sqrtf(yy + xx)
        
        if distance < 1600  {
            return true
        }
        
        return false
    }
    func isInRangeOfGhost(x x: Int, y:Int) -> Bool {
        
        let yy = Float(y - self.y) * Float(y - self.y)
        let xx = Float(self.x - x) * Float(self.x - x)
        
        let distance = sqrtf(yy + xx)
        
        if distance < 1760 && distance > 900 {
            return true
        }
        
        return false
    }
    
    func isInRangeOfBuster(x x: Int, y:Int) -> Bool {
        
        let yy = Float(y - self.y) * Float(y - self.y)
        let xx = Float(self.x - x) * Float(self.x - x)
        
        let distance = sqrtf(yy + xx)
        if distance < 1760 {
            return true
        }
        
        return false
    }
    
    
    func isToCloseForGhost(x x: Int, y:Int) -> Bool {
        
        let yy = Float(y - self.y) * Float(y - self.y)
        let xx = Float(self.x - x) * Float(self.x - x)
        
        let distance = sqrtf(yy + xx)
        if distance < 900 {
            return true
        }
        
        return false
    }
}

struct Ghost {
    let x: Int
    let y: Int
    let id: Int
    let bustersAttemping: Int
    var getsAttacked: Bool = false
    var visible: Bool = true
    let stamina: Int
    
    public init(x:Int, y:Int, id:Int, bustersAttemping:Int, stamina: Int) {
        self.x = x
        self.y = y
        self.id = id
        self.bustersAttemping = bustersAttemping
        self.stamina = stamina
    }
}

enum Team: Int {
    case Orange = 0
    case Purple = 1
}

struct Targets {
    let amountOfBusters: Int
    let team: Team
    var targetPositions: [(x:Int, y:Int)] = []
    var enemyBasePositions : [(x:Int, y:Int)] = []
    
    var indexsForBuster: [(id: Int, index: Int)] = []
    
    init(withAmountOfBusters busters: Int, team: Team) {
        self.amountOfBusters = busters
        self.team = team
        
        if team == .Orange {
            targetPositions.append((x:1000, y: 8000))
            targetPositions.append((x:15000, y: 1000))
            targetPositions.append((x:10000, y: 8000))
            targetPositions.append((x:14000, y: 2000))
            targetPositions.append((x:7000, y: 7000))
            targetPositions.append((x:9000, y: 3000))
            
        } else {
            targetPositions.append((x:15000, y: 1000))
            targetPositions.append((x:1000, y: 8000))
            targetPositions.append((x:4000, y: 2000))
            targetPositions.append((x:2000, y: 4000))
            targetPositions.append((x:7000, y: 7000))
            targetPositions.append((x:6000, y: 4700))
        }
        
    }
    
    public func campInEnemyBase(forBuster buster: Buster) -> (x:Int, y:Int) {
        var index = buster.id
        if team == .Purple {
            index = index - (amountOfBusters-1)
        }
        return enemyBasePositions[index]
    }
    
    mutating public func nextTargetPosition(forBuster buster: Buster) -> (x:Int, y:Int) {
        
        var busterIndex = buster.id
        if team == .Purple {
            busterIndex = busterIndex - (amountOfBusters-1)
        }
        
        /* if busterIndex == 0 {
         if team == .Purple {
         return (x: 2000, y: 2000)
         } else {
         return (x:14000, y:7000)
         }
         }
         */
        if let indexForIndexes = indexsForBuster.indexOf({$0.id == busterIndex}) {
            let busterIndexing = indexsForBuster[indexForIndexes]
            let currentTarget = targetPositions[busterIndexing.index]
            if abs(currentTarget.x - buster.x) > 200 ||   abs(currentTarget.y - buster.y) > 200 {
                return currentTarget
            }
            let nextBusterIndex = busterIndexing.index + 1
            if nextBusterIndex >= targetPositions.count {
                indexsForBuster[indexForIndexes].index = 0
                return targetPositions[0]
            }
            indexsForBuster[indexForIndexes].index = nextBusterIndex
            return targetPositions[nextBusterIndex]
        }
        
        var newIndex = busterIndex
        if newIndex >= targetPositions.count {
            newIndex = newIndex - (newIndex - (targetPositions.count - 1))
        }
        let busterIndexing = (id: busterIndex, index: newIndex)
        indexsForBuster.append(busterIndexing)
        return targetPositions[newIndex]
    }
}

struct BustersStunCount {
    var busterIdAndStunCount: [(id:Int, stun:Int)] = []
    
    mutating public func addBuster(withId id: Int) {
        busterIdAndStunCount.append((id: id, stun: 20))
    }
    
    public func busterCanStun(withId id: Int) -> Bool {
        
        if busterIdAndStunCount.filter({ $0.id == id }).count > 0 {
            return false
        }
        return true
    }
    
    mutating public func reduceStunForTurn() {
        if busterIdAndStunCount.count == 0 {
            return
        }
        var newList: [(id:Int, stun:Int)] = []
        for i in 0...busterIdAndStunCount.count-1 {
            var busterIdAndStun = busterIdAndStunCount[i]
            if busterIdAndStun.stun - 1 > 0 {
                newList.append((id:busterIdAndStun.id, stun:busterIdAndStun.stun - 1 ))
            }
        }
        
        busterIdAndStunCount = newList
    }
}

struct SpottedGhosts {
    
    var ghosts: [Ghost] = []
    var ghostTrigger: [(buster: Buster, ghostId: Int)] = []
    let team: Team
    
    init(withTeam team: Team) {
        self.team = team
    }
    
    mutating public func updateGhosts(newGhosts: [Ghost]) {
        
        ghosts = ghosts.map { ghost in
            var newGhost = ghost
            newGhost.visible = false
            return newGhost
        }
        for i in 0..<newGhosts.count {
            let ghost =  newGhosts[i]
            if let storedGhostIndex = ghosts.indexOf({ $0.id == ghost.id }) {
                ghosts[storedGhostIndex] = ghost
                continue
            }
            
            ghosts.append(ghost)
        }
    }
    
    mutating public func removeGhost(withId id: Int) {
        if let storedGhostIndex = ghosts.indexOf({ $0.id == id }) {
            ghosts.removeAtIndex(storedGhostIndex)
        }
        
        if let storedGhostIndex = ghostTrigger.indexOf({$0.ghostId == id}) {
            ghostTrigger.removeAtIndex(storedGhostIndex)
        }
    }
    
    mutating func nextFreeGhost(forBuster buster: Buster) -> Ghost? {
        
        ghosts = ghosts.sort( { a, b in
            let ad = sqrtf((Float(a.x) * Float(a.x)) + (Float(a.y) * Float(a.y)))
            let bd = sqrtf((Float(b.x) * Float(b.x)) + (Float(b.y) * Float(b.y)))
            if team == .Orange {
                return ad < bd && a.stamina < b.stamina
            } else {
                return ad > bd && a.stamina < b.stamina
            }
            
        })
        
        if buster.state == .Catching {
            return ghosts.filter { $0.id == buster.value }.first!
        }
        
        for i in 0..<ghosts.count {
            
            let ghost = ghosts[i]
            if ghost.stamina != 0 {
                return ghost
            }
            
            /*if let triggerIndex = ghostTrigger.indexOf({ ghost.id == $0.ghostId }) {
             let trigger = ghostTrigger[triggerIndex]
             if trigger.buster.id == buster.id {
             ghostTrigger[triggerIndex] = (buster: buster, ghostId: ghost.id)
             return ghost
             }
             
             if abs(buster.x - ghost.x ) + 100 < abs(trigger.buster.x - ghost.x) &&
             abs(buster.y - ghost.y ) + 100 < abs(trigger.buster.y - ghost.y) {
             ghostTrigger[triggerIndex] = (buster: buster, ghostId: ghost.id)
             return ghost
             }
             }
             
             if ghostTrigger.indexOf({ ghost.id == $0.ghostId }) == nil {
             
             ghostTrigger.append((buster: buster, ghostId: ghost.id))
             return ghost
             }  */
        }
        
        
        return nil
    }
}

/*
 func randomNumber(range: Range<Int> = 1...6) -> Int {
 let min = range.startIndex
 let max = range.endIndex
 return Int(arc4random_uniform(UInt32(max - min))) + min
 }
 */
/**
 * Send your busters out into the fog to trap ghosts and bring them home!
 **/

let bustersPerPlayer = Int(readLine()!)! // the amount of busters you control
let ghostCount = Int(readLine()!)! // the amount of ghosts on the map
let myTeamId = Int(readLine()!)! // if this is 0, your base is on the top left of the map, if it is one, on the bottom right

var base = (x: 0, y: 0)
var enemyBase = (x: 16000, y: 9000)
if myTeamId == 1 {
    enemyBase = base
    base = (x: 16000, y: 9000)
}

var targets = Targets(withAmountOfBusters: bustersPerPlayer, team: Team(rawValue: myTeamId)!)
var bustersStunCounter = BustersStunCount()
var released = 0
var spottedGhosts = SpottedGhosts(withTeam: Team(rawValue: myTeamId)!)
// game loop
while true {
    bustersStunCounter.reduceStunForTurn()
    
    let entities = Int(readLine()!)! // the number of busters and ghosts visible to you
    
    var busters: [Buster] = []
    var enemies: [Buster] = []
    var ghosts: [Ghost] = []
    if entities > 0 {
        for i in 0...(entities-1) {
            let inputs = (readLine()!).characters.split{$0 == " "}.map(String.init)
            let entityId = Int(inputs[0])! // buster id or ghost id
            let x = Int(inputs[1])!
            let y = Int(inputs[2])! // position of this buster / ghost
            let entityType = Int(inputs[3])! // the team id if it is a buster, -1 if it is a ghost.
            let state = Int(inputs[4])! // For busters: 0=idle, 1=carrying a ghost.
            let value = Int(inputs[5])! // For busters: Ghost id being carried. For ghosts: number of busters attempting to trap this ghost.
            if entityType == -1 {
                let ghost = Ghost(x: x, y: y, id: entityId, bustersAttemping: value, stamina: state)
                ghosts.append(ghost)
            } else if entityType == myTeamId {
                let state = BusterState(rawValue: state)
                let buster = Buster(x: x, y: y, id: entityId, state: state!, value: value)
                busters.append(buster)
            } else {
                let state = BusterState(rawValue: state)
                let enemy = Buster(x: x, y: y, id: entityId, state: state!, value: value)
                enemies.append(enemy)
            }
            
            
        }
    }
    
    spottedGhosts.updateGhosts(ghosts)
    
    if bustersPerPlayer > 0 {
        for i in 0...(bustersPerPlayer-1) {
            let buster = busters[i]
            
            // Bring Back and release ghost
            if buster.state == .CarryingGhost {
                if buster.isInRangeOfBase(x: base.x, y: base.y) {
                    print("RELEASE")
                    released++
                } else {
                    print("MOVE \(base.x) \(base.y)")
                    spottedGhosts.removeGhost(withId: buster.value!)
                }
                continue
            }
            
            // Stun Enemy
            if enemies.count > 0 && bustersStunCounter.busterCanStun(withId: buster.id) {
                
                var targeted = false
                
                for i in 0...(enemies.count-1) {
                    let enemy = enemies[i]
                    if buster.isInRangeOfBuster(x: enemy.x, y:enemy.y) && enemy.state != .Stunned {
                        print("STUN \(enemy.id)")
                        targeted = true
                        enemies.removeAtIndex(i)
                        bustersStunCounter.addBuster(withId: buster.id)
                        break
                    } else if enemy.state == .Catching {
                        targeted = true
                        print("MOVE \(enemy.x) \(enemy.y)")
                    }
                }
                if targeted {
                    continue
                }
            }
            
            // Get Ghost and Follow
            guard let ghost = spottedGhosts.nextFreeGhost(forBuster: buster) else {
                let nextPosition = targets.nextTargetPosition(forBuster: buster)
                print("MOVE \(nextPosition.x) \(nextPosition.y)")
                continue
            }
            
            if buster.isInRangeOfGhost(x: ghost.x, y: ghost.y) && ghost.visible {
                
                print("BUST \(ghost.id)")
            } else if buster.isToCloseForGhost(x: ghost.x, y: ghost.y) && ghost.visible {
                let nextPosition = targets.nextTargetPosition(forBuster: buster)
                print("MOVE \(nextPosition.x) \(nextPosition.y)")
            } else if buster.isToCloseForGhost(x: ghost.x, y: ghost.y) && !ghost.visible {
                spottedGhosts.removeGhost(withId: ghost.id)
                let nextPosition = targets.nextTargetPosition(forBuster: buster)
                print("MOVE \(nextPosition.x) \(nextPosition.y)")
            } else {
                print("MOVE \(ghost.x) \(ghost.y)")
            }
        }
    }
}
