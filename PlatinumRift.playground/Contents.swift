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
        //return ["2", "0", "154", "301"]
        return mainInputsData()
    }
    return (readLine()!).split{$0 == " "}.map(String.init)
}

func getZoneInput(_ index: Int) -> [String] {
    if mode == .DEBUG {
        //        func originalZoneInput () -> [[String]] {
        //            return [["0", "0"],["1", "0"],["2", "0"],["3", "3"],["4", "0"],["5", "0"],["6", "0"],["7", "0"],["8", "0"],["9", "0"],["10", "0"],["11", "0"],["12", "0"],["13", "0"],["14", "0"],["15", "0"],["16", "0"],["17", "0"],["18", "5"],["19", "2"],["20", "1"],["21", "0"],["22", "0"],["23", "0"],["24", "0"],["25", "0"],["26", "1"],["27", "0"],["28", "1"],["29", "1"],["30", "1"],["31", "1"],["32", "0"],["33", "0"],["34", "1"],["35", "0"],["36", "0"],["37", "1"],["38", "0"],["39", "1"],["40", "0"],["41", "0"],["42", "2"],["43", "4"],["44", "1"],["45", "0"],["46", "5"],["47", "0"],["48", "0"],["49", "1"],["50", "0"],["51", "2"],["52", "0"],["53", "0"],["54", "1"],["55", "0"],["56", "0"],["57", "2"],["58", "0"],["59", "0"],["60", "1"],["61", "0"],["62", "1"],["63", "0"],["64", "0"],["65", "1"],["66", "0"],["67", "0"],["68", "0"],["69", "0"],["70", "0"],["71", "6"],["72", "0"],["73", "0"],["74", "0"],["75", "2"],["76", "2"],["77", "1"],["78", "0"],["79", "0"],["80", "0"],["81", "1"],["82", "1"],["83", "0"],["84", "1"],["85", "0"],["86", "0"],["87", "0"],["88", "0"],["89", "1"],["90", "1"],["91", "2"],["92", "0"],["93", "1"],["94", "0"],["95", "0"],["96", "1"],["97", "5"],["98", "0"],["99", "2"],["100", "4"],["101", "1"],["102", "0"],["103", "0"],["104", "1"],["105", "0"],["106", "0"],["107", "3"],["108", "3"],["109", "1"],["110", "0"],["111", "0"],["112", "1"],["113", "1"],["114", "0"],["115", "6"],["116", "0"],["117", "0"],["118", "1"],["119", "5"],["120", "0"],["121", "4"],["122", "1"],["123", "0"],["124", "0"],["125", "1"],["126", "0"],["127", "0"],["128", "0"],["129", "0"],["130", "0"],["131", "0"],["132", "1"],["133", "0"],["134", "0"],["135", "6"],["136", "0"],["137", "1"],["138", "0"],["139", "1"],["140", "0"],["141", "1"],["142", "2"],["143", "5"],["144", "1"],["145", "0"],["146", "0"],["147", "0"],["148", "1"],["149", "0"],["150", "1"],["151", "0"],["152", "0"],["153", "0"]]
        //        }
        //        let zones = originalZoneInput()
        //        return zones[index]
        return ["0", "1"]
    }

    return (readLine()!).split{$0 == " "}.map(String.init)
}

func getLinkInput(_ index: Int) -> [String] {
    if mode == .DEBUG {
        //        func orignialLinkInput() -> [[String]] {
        //            return [["2", "3"], ["34", "35"], ["50", "51"], ["98", "99"], ["114", "115"], ["130", "131"], ["146", "147"], ["50", "54"], ["2", "7"], ["50", "55"], ["114", "120"], ["98", "105"], ["34", "42"], ["98", "106"],["66", "76"],["66", "77"],["82", "93"],["82", "94"],["18", "44"],["19", "20"],["3", "4"],["18", "51"],["35", "36"],["83", "84"],["99", "100"],["115", "116"],["131", "132"],["3", "7"],["51", "55"],["3", "8"],["51", "56"],["115", "120"],["147", "152"],["115", "121"],["99", "106"],["19", "27"],["99", "107"],["67", "78"],["83", "95"],["4", "5"],["20", "21"],["52", "53"],["68", "69"],["84", "85"],["100", "101"],["116", "117"],["132", "133"],["4", "8"],["4", "9"],["116", "121"],["116", "122"],["20", "27"],["52", "59"],["100", "107"],["20", "28"],["100", "108"],["68", "79"],["84", "95"],["84", "96"],["5", "6"],["21", "22"],["69", "70"],["85", "86"],["101", "102"],["117", "118"],["149", "150"],["5", "9"],["5", "10"],["117", "122"],["37", "43"],["53", "59"],["117", "123"],["21", "28"],["101", "108"],["21", "29"],["101", "109"],["69", "79"],["69", "80"],["85", "96"],["22", "23"],["54", "55"],["86", "87"],["102", "103"],["118", "119"],["6", "10"],["134", "138"],["6", "11"],["118", "123"],["54", "60"],["118", "124"],["22", "29"],["54", "61"],["102", "109"],["102", "110"],["70", "80"],["70", "81"],["39", "40"],["7", "8"],["55", "56"],["71", "72"],["87", "88"],["135", "136"],["135", "139"],["39", "44"],["119", "124"],["135", "140"],["7", "13"],["55", "61"],["119", "125"],["7", "14"],["55", "62"],["103", "110"],["103", "111"],["71", "83"],["24", "25"],["8", "9"],["40", "41"],["72", "73"],["120", "121"],["152", "153"],["40", "44"],["136", "140"],["40", "45"],["8", "14"],["24", "30"],["56", "62"],["8", "15"],["56", "63"],["120", "128"],["104", "113"],["120", "129"],["72", "83"],["72", "84"],["9", "10"],["25", "26"],["41", "42"],["73", "74"],["105", "106"],["121", "122"],["41", "45"],["137", "141"],["25", "30"],["137", "142"],["9", "15"],["25", "31"],["9", "16"],["89", "97"],["121", "129"],["105", "114"],["121", "130"],["57", "67"],["73", "84"],["73", "85"],["10", "11"],["74", "75"],["90", "91"],["106", "107"],["122", "123"],["138", "139"],["26", "31"],["10", "16"],["26", "32"],["138", "144"],["10", "17"],["90", "98"],["106", "114"],["122", "130"],["90", "99"],["106", "115"],["122", "131"],["58", "68"],["74", "85"],["74", "86"],["11", "12"],["27", "28"],["75", "76"],["91", "92"],["107", "108"],["123", "124"],["139", "140"],["43", "46"],["11", "17"],["139", "145"],["91", "99"],["107", "115"],["123", "131"],["91", "100"],["107", "116"],["123", "132"],["27", "37"],["59", "69"],["59", "70"],["75", "86"],["75", "87"],["44", "45"],["28", "29"],["60", "61"],["76", "77"],["92", "93"],["108", "109"],["124", "125"],["140", "145"],["140", "146"],["92", "100"],["108", "116"],["124", "132"],["92", "101"],["108", "117"],["124", "133"],["28", "38"],["60", "71"],["76", "87"],["76", "88"],["13", "14"],["61", "62"],["93", "94"],["109", "110"],["125", "126"],["141", "142"],["13", "19"],["13", "20"],["141", "148"],["93", "101"],["109", "117"],["125", "133"],["29", "38"],["93", "102"],["109", "118"],["61", "71"],["61", "72"],["77", "88"],["14", "15"],["30", "31"],["46", "47"],["62", "63"],["110", "111"],["126", "127"],["46", "48"],["46", "49"],["14", "20"],["142", "148"],["14", "21"],["94", "102"],["110", "118"],["30", "39"],["94", "103"],["110", "119"],["62", "72"],["62", "73"],["78", "89"],["15", "16"],["31", "32"],["63", "64"],["79", "80"],["95", "96"],["111", "112"],["47", "49"],["15", "21"],["15", "22"],["127", "134"],["143", "150"],["31", "39"],["111", "119"],["31", "40"],["63", "73"],["63", "74"],["79", "90"],["79", "91"],["16", "17"],["0", "1"],["32", "33"],["48", "49"],["64", "65"],["80", "81"],["128", "129"],["16", "22"],["16", "23"],["144", "151"],["32", "40"],["32", "41"],["128", "137"],["64", "74"],["64", "75"],["80", "91"],["80", "92"],["1", "2"],["33", "34"],["65", "66"],["81", "82"],["129", "130"],["145", "146"],["1", "3"],["17", "23"],["97", "104"],["33", "41"],["129", "137"],["33", "42"],["65", "75"],["65", "76"],["81", "92"],["81", "93"]]
        //        }
        //        let links = orignialLinkInput()
        //        return links[index]
        return ["1", "2"]
    }

    return (readLine()!).split{$0 == " "}.map(String.init)
}

// HELPER
class Zone: Hashable, Equatable, CustomStringConvertible {
    let id: Int
    let platinum: Int

    var owner: Int?
    var pods0: Int?
    var pods1: Int?
    var pods2: Int?
    var pods3: Int?

    var hashValue: Int {
        return id
    }

    var description : String {
        return "ID: \(id) - Platinum: \(platinum)"
    }

    init(id: Int, platinum: Int) {
        self.id = id
        self.platinum = platinum
    }

    func isEmpty() -> Bool {
        return pods0 == 0 && pods1 == 0 && pods2 == 0 && pods3 == 0
    }

    func pods(for owner: Int) -> Int {
        switch owner {
        case 0:
            return pods0 ?? 0
        case 1:
            return pods1 ?? 0
        case 2:
            return pods2 ?? 0
        case 3:
            return pods3 ?? 0
        default:
            return 0
        }
    }

    func pods(notFor owner: Int) -> Int {
        switch owner {
        case 0:
            return (pods1 ?? 0) + (pods2 ?? 0) + (pods3 ?? 0)
        case 1:
            return (pods0 ?? 0) + (pods2 ?? 0) + (pods3 ?? 0)
        case 2:
            return (pods0 ?? 0) + (pods1 ?? 0) + (pods3 ?? 0)
        case 3:
            return (pods0 ?? 0) + (pods1 ?? 0) + (pods2 ?? 0)
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
let playerCount = Int(inputs[0])! // the amount of players (2 to 4)
let myId = Int(inputs[1])! // my player ID (0, 1, 2 or 3)
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
    toCheck = []
    closed = []
    toCheck.append((startZone, 0, nil))

    repeat {
        toCheck.sort(by: {$0.prio < $1.prio})
        var currentZone = toCheck.removeFirst()
        //debug("Current Zone: \(currentZone)")

        if currentZone.zone.owner != myId {
            // THIS WORKS .... but i dont have the path backwards ...
            //debug("Found ToCheck: \(toCheck)")
            //debug("Found closed: \(closed)")
            // check parents backwards in closed list ... hopefully
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


var continents: [Set<Zone>] = []
func buildContinents() {
    var zonesToRemove = zones

    func addZonesToContinent(for zone: Zone, withContinentId continentId: Int) {
        if let removableZoneIndex = zonesToRemove.index(where: { $0.id == zone.id}) {
            zonesToRemove.remove(at: removableZoneIndex)
        }

        continents[continentId].insert(zone)
        let zoneLinks = links.filter({ $0.zone1 == zone.id || $0.zone2 == zone.id })
        for link in zoneLinks {
            let otherZoneId = link.otherZone(for: zone.id)
            guard let otherZone = zonesToRemove.first(where: { $0.id == otherZoneId }),
                !continents[continentId].contains(otherZone) else {
                    continue
            }
            addZonesToContinent(for: otherZone, withContinentId: continentId)
        }
    }
    // while continents zones count != zones
    var continentNumber = 0
    repeat {
        if let zone = zonesToRemove.first {
            continents.append([])
            addZonesToContinent(for: zone, withContinentId: continentNumber)
        }

        continentNumber += 1
    } while !zonesToRemove.isEmpty

    continents.sort { (zonesL, zonesR) -> Bool in

        let platinumL = zonesL.reduce(into: 0, { (res, zone) in
            res += zone.platinum
        })
        let platinumR = zonesR.reduce(into: 0, { (res, zone) in
            res += zone.platinum
        })

        let continentValueL = Float(zonesL.count) / Float(platinumL)
        let continentValueR = Float(zonesR.count) / Float(platinumR)

        return continentValueL < continentValueR
    }
}

buildContinents()

//let conz: Set<Zone> = [Zone(id: 150, platinum: 1), Zone(id: 149, platinum: 0), Zone(id: 143, platinum: 5)]
//let conz2: Set<Zone> = [Zone(id: 152, platinum: 2), Zone(id: 1222, platinum: 0), Zone(id: 14393, platinum: 5)]
//continents.append(conz)
//continents.append(conz2)


//print(continents)

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
            let podsP2 = Int(inputs[4])! // player 2's PODs on this zone (always 0 for a two player game)
            let podsP3 = Int(inputs[5])! // player 3's PODs on this zone (always 0 for a two or three player game)

            zone.owner = ownerId
            zone.pods0 = podsP0
            zone.pods1 = podsP1
            zone.pods2 = podsP2
            zone.pods3 = podsP3
        }
    }

    // first line for movement commands, second line for POD purchase (see the protocol in the statement for details)
    // BOTS MOVEMENT
    //debug("\()")
    var moveOutput = ""

    for cZones in continents {
        // all owned by me
        if cZones.filter({ $0.owner == myId }).count == cZones.count {
            continue
        }

        // check if there bots to move
        let zonesWithMyBots = cZones.filter({ $0.pods(for: myId) > 0 })
        if zonesWithMyBots.isEmpty {
            continue
        }

        // check if enemy zones are in this continent. If yes, than start path finding to attack him
        // if not start path finding to neutral zone

        for zone in zonesWithMyBots {
            let linkedZones = linkedSeperatedZones(for: zone.id, in: cZones)
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
                if let mZone = startPathSearch(withZone: zone, inGrid: cZones) {
                    moveOutput.append("\(bots) \(zone.id) \(mZone.id) ")
                }
            }
        }
    }

    print(moveOutput.isEmpty ? "WAIT": String(moveOutput[..<moveOutput.index(before: moveOutput.endIndex)]))

    // MARK: BOT DEPLOYMENT
    var botsToBuy = Int(floor(Double(platinum) / 20))
    guard botsToBuy > 1 || !firstRound else  {
        print("WAIT")
        firstRound = false
        continue
    }
    var buyOutput = ""

    for cZones in continents {

        let seperatedCZones = seperatedZones(for: cZones)

        // nothing to get
        if seperatedCZones.others.count == cZones.count {
            continue
        }

        // there owned fields
        if !seperatedCZones.own.isEmpty {

            // check for linked enemy
            // if not check if already bot is walking this continent ...
            // if yes, leave it
            let numOfBotsInContinent = seperatedCZones.own.reduce(into: 0, { (res, zone) in
                res += zone.pods(for: myId)
            })

            if seperatedCZones.others.isEmpty && numOfBotsInContinent > 0 {
                // we dont need to do something
                continue
            }

            if !seperatedCZones.others.isEmpty {

                let numOfEnemyBotsInContinent = seperatedCZones.others.reduce(into: 0, { (res, zone) in
                    res += zone.pods(notFor: myId)
                })

                if (Float(numOfEnemyBotsInContinent)*1.3) < Float(numOfBotsInContinent) && numOfBotsInContinent > 0 {
                    // there is no need to place bots.
                    continue
                }

                while botsToBuy > 0 {

                    for oZone in seperatedCZones.own {
                        let linkedZones = linkedSeperatedZones(for: oZone.id, in: zones)
                        // zone with enemy gets the bots
                        if !linkedZones.others.isEmpty {
                            buyOutput.append("1 \(oZone.id) ")
                            botsToBuy -= 1
                        }

                        if botsToBuy <= 0 {
                            break
                        }
                    }

                    for oZone in seperatedCZones.own {
                        let linkedZones = linkedSeperatedZones(for: oZone.id, in: zones)
                        // zone with enemy gets the bots
                        if !linkedZones.neutral.isEmpty {
                            buyOutput.append("1 \(oZone.id) ")
                            botsToBuy -= 1
                        }

                        if botsToBuy <= 0 {
                            break
                        }
                    }

                }
            }
        } else {

            // no owned fields, but neutral

            for nZone in seperatedCZones.neutral {
                if nZone.platinum >= 2 || !seperatedCZones.others.isEmpty {
                    buyOutput.append("1 \(nZone.id) ")
                    botsToBuy -= 1

                    if botsToBuy <= 0 {
                        break
                    }
                }
            }
        }

    }

    if botsToBuy > 0 {
        for cZones in continents {
            let seperatedCZones = seperatedZones(for: cZones)

            // nothing to get
            if seperatedCZones.others.count == cZones.count || seperatedCZones.own.count == cZones.count {
                continue
            }

            if !seperatedCZones.own.isEmpty {
                while botsToBuy > 0 {

                    for oZone in seperatedCZones.own {
                        let linkedZones = linkedSeperatedZones(for: oZone.id, in: zones)
                        // zone with enemy gets the bots
                        if !linkedZones.others.isEmpty {
                            buyOutput.append("1 \(oZone.id) ")
                            botsToBuy -= 1
                        }

                        if botsToBuy <= 0 {
                            break
                        }
                    }

                    for oZone in seperatedCZones.own {
                        let linkedZones = linkedSeperatedZones(for: oZone.id, in: zones)
                        // zone with enemy gets the bots
                        if !linkedZones.neutral.isEmpty {
                            buyOutput.append("1 \(oZone.id) ")
                            botsToBuy -= 1
                        }

                        if botsToBuy <= 0 {
                            break
                        }
                    }

                }
            }
        }
    }

    print(buyOutput.isEmpty ? "WAIT": String(buyOutput[..<buyOutput.index(before: buyOutput.endIndex)]))
}

