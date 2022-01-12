//import Glibc
import Foundation

public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) { fputs(string, stderr) }
}
public var errStream = StderrOutputStream()

func debug(_ message: Any) {
    print(message, to: &errStream)
}

enum Mode {
    case GAME
    case DEBUG
}

let mode = Mode.DEBUG

// TESTDATA
if mode == .DEBUG {
    func readLine() -> String? {
        return ""
    }
}

func getMainInputs() -> [String] {
    if mode == .DEBUG {
        func mainInputsData() -> [String ]{
            return ["2", "0", "154", "301"]
        }
        return mainInputsData()
    }
    return (readLine()!).split{$0 == " "}.map(String.init)
}

func getZoneInput(_ index: Int) -> [String] {
    if mode == .DEBUG {

        //        return zones[index]
        return ["0", "1"]
    }

    return (readLine()!).split{$0 == " "}.map(String.init)
}

func getLinkInput(_ index: Int) -> [String] {
    if mode == .DEBUG {

        //        return links[index]
        return ["1", "2"]
    }

    return (readLine()!).split{$0 == " "}.map(String.init)
}

// HELPER
class Zone: Hashable, Equatable, CustomStringConvertible {
    let id: Int
    var platinum: Int

    var owner: Int?
    var pods0: Int?
    var pods1: Int?

    var visible: Bool = false

    var hashValue: Int {
        return id
    }

    var description : String {
        return "ID: \(id) - Platinum: \(platinum) - Visible: \(visible) - Owner: \(owner)"
    }

    init(id: Int, platinum: Int) {
        self.id = id
        self.platinum = platinum
    }

    func isEmpty() -> Bool {
        return pods0 == 0 && pods1 == 0
    }

    func pods(for owner: Int) -> Int {
        switch owner {
        case 0:
            return pods0 ?? 0
        case 1:
            return pods1 ?? 0
        default:
            return 0
        }
    }

    func pods(notFor owner: Int) -> Int {
        switch owner {
        case 0:
            return pods1 ?? 0
        case 1:
            return pods0 ?? 0
        default:
            return 0
        }
    }

}

func ==(lhs: Zone, rhs: Zone) -> Bool {
    return lhs.id == rhs.id
}

struct Link {
    let zone1: Int
    let zone2: Int

    func otherZone(for id: Int) -> Int {
        if zone1 == id {
            return zone2
        }
        return zone1
    }

    func contains(zone1: Int, zone2: Int) -> Bool {
        return (zone1 == self.zone1 && zone2 == self.zone2) || (zone1 == self.zone2 && zone2 == self.zone1)
    }
}


/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

// GAME VARIABLES
var zones: Set<Zone> = []
var links: [Link] = []

let inputs = getMainInputs()
let playerCount = Int(inputs[0])! // the amount of players (always 2)
let myId = Int(inputs[1])! // my player ID (0 or 1)
let zoneCount = Int(inputs[2])! // the amount of zones on the map
let linkCount = Int(inputs[3])! // the amount of links between all zones

if zoneCount > 0 {
    for i in 0...(zoneCount-1) {
        let inputs = getZoneInput(i)
        let zoneId = Int(inputs[0])! // this zone's ID (between 0 and zoneCount-1)
        let platinumSource = Int(inputs[1])! // the amount of Platinum this zone can provide per game turn
        zones.insert(Zone(id: zoneId, platinum: platinumSource))
    }
}

if linkCount > 0 {
    for i in 0...(linkCount-1) {
        let inputs = getLinkInput(i)
        let zone1 = Int(inputs[0])!
        let zone2 = Int(inputs[1])!
        links.append(Link(zone1: zone1, zone2: zone2))
    }
}

// MARK: Helper

typealias LinkedZones = (neutral: Set<Zone>, others: Set<Zone>, own: Set<Zone> )

func linkedSeperatedZones(for zoneId: Int, in continentZones: Set<Zone>) -> LinkedZones {
    let zoneLinks = links.filter({ $0.zone1 == zoneId || $0.zone2 == zoneId })

    var neutralZones: Set<Zone> = []
    var otherZones: Set<Zone> = []
    var ownZones: Set<Zone> = []

    for link in zoneLinks {
        let linkedZoneId = link.otherZone(for: zoneId)
        if let linkedZone = continentZones.first(where: { $0.id == linkedZoneId }) {
            if linkedZone.owner == -1 {
                neutralZones.insert(linkedZone)
            } else if linkedZone.owner == myId {
                ownZones.insert(linkedZone)
            } else {
                otherZones.insert(linkedZone)
            }
        }
    }

    return (neutralZones, otherZones, ownZones)
}

func zonesWithLinkedOtherZone(for id: Int) -> Set<Zone> {

    let myZones = zones.filter { zone -> Bool in
        guard zone.owner == myId else {
            return false
        }
        let linkedZones = linkedSeperatedZones(for: zone.id, in: zones)
        return !linkedZones.others.isEmpty || !linkedZones.neutral.isEmpty
    }
    return myZones
}


typealias ZonePath = (zone: Zone, prio: Int, parent: Zone?)

var toCheck: [ZonePath] = []
var closed: [ZonePath] = []

func startPathSearch(withZone startZone: Zone, inGrid grid: Set<Zone>) -> Zone? {

    //debug(startZone)
    toCheck = []
    closed = []
    toCheck.append((startZone, 0, nil))

    repeat {
        toCheck.sort(by: {$0.prio < $1.prio})
        var currentZone = toCheck.removeFirst()
        //debug("Current Zone: \(currentZone)")

        if currentZone.zone.owner != myId {
            //debug("Found ToCheck: \(toCheck)")
            //debug("Found closed: \(closed)")
            while true {
                if let zonePath = closed.first(where: { $0.zone == currentZone.parent && $0.parent != nil }) {
                    currentZone = zonePath
                } else {
                    return currentZone.zone
                }

            }
        }

        closed.append(currentZone)

        expandToCheck(with: currentZone, inGrid: grid)
    } while !toCheck.isEmpty

    return nil
}

func expandToCheck(with zonePath: ZonePath, inGrid gird: Set<Zone>) {
    let zoneLinks = links.filter({ $0.zone1 == zonePath.zone.id || $0.zone2 == zonePath.zone.id })

    for link in zoneLinks {
        let linkedZoneId = link.otherZone(for: zonePath.zone.id)

        if closed.contains(where: {$0.zone.id == linkedZoneId}) {
            continue
        }

        let newPrio = zonePath.prio + 1

        if let existingPath = toCheck.first(where: {$0.zone.id == linkedZoneId}), newPrio > existingPath.prio {
            //debug("Path Exists and prio higher: \(existingPath)")
            continue // for now, we dont need to check this
        }

        if let linkedZone = gird.first(where: { $0.id == linkedZoneId }) {

            if let indexOfExisting = toCheck.index(where: {$0.zone.id == linkedZoneId}) {
                toCheck[indexOfExisting] = (linkedZone, newPrio, zonePath.zone)
            } else {
                toCheck.append((linkedZone, newPrio, zonePath.zone))
            }
        }
    }
}

typealias SeperatedZones = (neutral: [Zone], others: [Zone], own: [Zone])

func seperatedZones(for zones: Set<Zone>) -> SeperatedZones {
    let sortedZones = zones.sorted(by: { $0.platinum > $1.platinum })

    let neutral = sortedZones.filter({$0.owner == -1})
    let own = sortedZones.filter({$0.owner == myId})
    let others = sortedZones.filter({$0.owner != -1 && $0.owner != myId})

    return (neutral, others, own)
}

var firstRound = true


// game loop
while mode == .GAME {

    let platinum = Int(readLine()!)! // my available Platinum
    if zoneCount > 0 {
        for _ in 0...(zoneCount-1) {
            let inputs = (readLine()!).split{$0 == " "}.map(String.init)
            let zId = Int(inputs[0])! // this zone's ID
            guard let zone = zones.first(where: {$0.id == zId}) else {
                continue
            }
            let ownerId = Int(inputs[1])! // the player who owns this zone (-1 otherwise)
            let podsP0 = Int(inputs[2])! // player 0's PODs on this zone
            let podsP1 = Int(inputs[3])! // player 1's PODs on this zone
            let visible = Int(inputs[4])! // 1 if one of your units can see this tile, else 0
            let platinum = Int(inputs[5])! // the amount of Platinum this zone can provide (0 if hidden by fog)

            if visible == 1 {
                zone.owner = ownerId
                zone.pods0 = podsP0
                zone.pods1 = podsP1
                zone.visible = true
                zone.platinum = platinum
            } else {
                zone.visible = false
            }
        }
    }

    // first line for movement commands, second line for POD purchase (see the protocol in the statement for details)
    // BOTS MOVEMENT
    //debug("\()")
    var moveOutput = ""


    // check if there bots to move
    let zonesWithMyBots = zones.filter({ $0.pods(for: myId) > 0 })

    for zone in zonesWithMyBots {
        let linkedZones = linkedSeperatedZones(for: zone.id, in: zones)
        var bots = zone.pods(for: myId)

        // enemy
        // check if pods can kill them
        // if not, there should spawn new ones here, with needed amount?
        if bots > 0 &&  !linkedZones.others.isEmpty {
            var botsPerBase = max(1, Int(floor(Float(bots) / Float(linkedZones.others.count))))
            for eZone in linkedZones.others {
                if eZone.pods(notFor: myId) > 0 && botsPerBase > 2 {
                    botsPerBase -= 2
                    bots -= 2
                }
                moveOutput.append("\(botsPerBase) \(zone.id) \(eZone.id) ")
                bots -= botsPerBase
                if bots <= 0 {
                    break;
                }
            }
        }

        // Neutal
        // check the moveable zone, if its not linked, send only one bot
        // if its linked with more than one, than check what to do.
        // i want to use all bots
        if bots > 0 &&  !linkedZones.neutral.isEmpty {

            let botsPerBase = max(1, Int(floor(Float(bots) / Float(linkedZones.neutral.count))))
            for nZone in linkedZones.neutral {
                moveOutput.append("\(botsPerBase) \(zone.id) \(nZone.id) ")
                bots -= botsPerBase

                if bots <= 0 {
                    break
                }
            }
        }

        // mys
        // proof if the target has moveable positions ...
        // what if not?
        // how to move the bot to a useful place?
        if bots > 0 {
            // TODO: find the first enemy path when existing....
            if let mZone = startPathSearch(withZone: zone, inGrid: zones) {
                moveOutput.append("\(bots) \(zone.id) \(mZone.id) ")
            }
        }
    }

    print(moveOutput.isEmpty ? "WAIT": String(moveOutput[..<moveOutput.index(before: moveOutput.endIndex)]))

    // MARK: BOT DEPLOYMENT

    var buyOutput = ""
    print(buyOutput.isEmpty ? "WAIT": String(buyOutput[..<buyOutput.index(before: buyOutput.endIndex)]))
}


