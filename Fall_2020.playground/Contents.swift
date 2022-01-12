import Foundation
func debug(_ message: String) {
    print(message)
}

var lines: [String] = ["13",
                       "54 BREW 0 -2 0 -2 12 0 0 0 0",
                       "49 BREW 0 -5 0 0 10 0 0 0 0",
                       "72 BREW 0 -2 -2 -2 19 0 0 0 0",
                       "63 BREW 0 0 -3 -2 17 0 0 0 0",
                       "52 BREW -3 0 0 -2 11 0 0 0 0",
                       "78 CAST 2 0 0 0 0 -1 -1 1 0",
                       "79 CAST -1 1 0 0 0 -1 -1 1 0",
                       "80 CAST 0 -1 1 0 0 -1 -1 1 0",
                       "81 CAST 0 0 -1 1 0 -1 -1 1 0",
                       "82 OPPONENT_CAST 2 0 0 0 0 -1 -1 1 0",
                       "83 OPPONENT_CAST -1 1 0 0 0 -1 -1 1 0",
                       "84 OPPONENT_CAST 0 -1 1 0 0 -1 -1 1 0",
                       "85 OPPONENT_CAST 0 0 -1 1 0 -1 -1 1 0",
                       "3 0 0 0 0",
                       "3 0 0 0 0"]

func getData() -> String? {
    return lines.removeFirst()
}


struct Witch {

}

struct ActionList {
    var actions: [Action] = []
    
    var orders: [Action] {
        actions.filter({ $0.actionType == .BREW})
    }
    
    var mySpells: [Action] {
        actions.filter({ $0.actionType == .CAST})
    }
}

enum ActionType: String {
    case BREW, CAST, OPPONENT_CAST, LEARN
}

struct Action {
    var actionId: Int
    var actionType: ActionType
    var tier0: Int
    var tier1: Int
    var tier2: Int
    var tier3: Int
    var price: Int
    var castable: Bool
    
    var costFactor: Int {
        return (abs(tier0) * 1) + (abs(tier1) * 2) + (abs(tier2) * 4) + (abs(tier3) * 8)
    }
    
    // Inputs from stream
    init(inputs: [String]) {
        actionId = Int(inputs[0])! // the unique ID of this spell or recipe
        actionType = ActionType(rawValue: inputs[1])! // in the first league: BREW; later: CAST, OPPONENT_CAST, LEARN, BREW
        tier0 = Int(inputs[2])! // tier-0 ingredient change
        tier1 = Int(inputs[3])! // tier-1 ingredient change
        tier2 = Int(inputs[4])! // tier-2 ingredient change
        tier3 = Int(inputs[5])! // tier-3 ingredient change
        price = Int(inputs[6])! // the price in rupees if this is a potion
        //let tomeIndex = Int(inputs[7])! // in the first two leagues: always 0; later: the index in the tome if this is a tome spell, equal to the read-ahead tax; For brews, this is the value of the current urgency bonus
//        let taxCount = Int(inputs[8])! // in the first two leagues: always 0; later: the amount of taxed tier-0 ingredients you gain from learning this spell; For brews, this is how many times you can still gain an urgency bonus
        castable = inputs[9] != "0" // in the first league: always 0; later: 1 if this is a castable player spell
//        let repeatable = inputs[10] != "0" // for the first two leagues: always 0; later: 1 if this is a repeatable player spell
    }
    
    // for type brew only
    func brewable(fromInventory inv: Inventory) -> Bool {
        return inv.tier0 >= abs(tier0) && inv.tier1 >= abs(tier1) && inv.tier2 >= abs(tier2) && inv.tier3 >= abs(tier3) && actionType == .BREW
    }
    
    // for type cast only
    func gatherOnly() -> Bool {
        return tier0 >= 0 && tier1 >= 0 && tier2 >= 0 && tier3 >= 0 && actionType == .CAST && castable
    }
    
    func canCastTier3(withInv inv: Inventory) -> Bool {
        return tier3 > 0 &&
            inv.tier2 - abs(tier2) >= 0 &&
            inv.tier1 - abs(tier1) >= 0 &&
            inv.tier0 - abs(tier0) >= 0 &&
            inv.capacity() + tier3 + tier2 + tier1 + tier0 <= 10 &&
            actionType == .CAST && castable
    }
    
    func canCastTier2(withInv inv: Inventory) -> Bool {
        return tier2 > 0 &&
            inv.tier1 - abs(tier1) >= 0 &&
            inv.tier0 - abs(tier0) >= 0 &&
            inv.capacity() + tier2 + tier1 + tier0 <= 10 &&
            actionType == .CAST  && castable
    }
    
    func canCastTier1(withInv inv: Inventory) -> Bool {
        return tier1 > 0 &&
            inv.tier0 - abs(tier0) >= 0 &&
            inv.capacity() + tier1 + tier0 <= 10 &&
            actionType == .CAST  && castable
    }
    
    func canCastTier0(withInv inv: Inventory) -> Bool {
        return abs(tier0) > 0 && inv.capacity() + tier0 <= 10 && actionType == .CAST  && castable
    }
}

struct Inventory {
    var tier0: Int
    var tier1: Int
    var tier2: Int
    var tier3: Int
    var rupees: Int
    
    // Inputs from stream
    init(inputs: [String]) {
        tier0 = Int(inputs[0])! // tier-0 ingredients in inventory
        tier1 = Int(inputs[1])!
        tier2 = Int(inputs[2])!
        tier3 = Int(inputs[3])!
        rupees = Int(inputs[4])! // amount of rupees
    }
    
    func capacity() -> Int {
        return tier0 + tier1 + tier2 + tier3
    }
    
    func hasItems(forAction action: Action) -> Bool {
        return tier0 >= abs(action.tier0) && tier1 >= abs(action.tier1) && tier2 >= abs(action.tier2) && tier3 >= abs(action.tier3)
    }
}

enum Command {
    case brew(Int), cast(Int), rest, wait

    var print: String {
        switch self {
            case .brew(let orderId):
            return "BREW \(orderId)"
            case .cast(let id):
            return "CAST \(id)"
            case .rest:
            return "REST"
            case .wait:
                return "WAIT"

        }
    }
}
// game loop
for _ in 0..<1 {
    var actionList = ActionList()
    var inventories: [Inventory] = []
    let firstReadline = getData()!
    //debug(firstReadline)
    let actionCount = Int(firstReadline)! // the number of spells and recipes in play
    if actionCount > 0 {
        for _ in 0...(actionCount-1) {
            let secondReadLines = getData()!
            //debug(secondReadLines)
            let inputs = (secondReadLines).split(separator: " ").map(String.init)
            let action = Action(inputs: inputs)
            actionList.actions.append(action)
        }
    }
    for _ in 0...1 {
        let thirdReadLines = getData()!
        //debug(thirdReadLines)
        let inputs = (thirdReadLines).split(separator: " ").map(String.init)
        let inventory = Inventory(inputs: inputs)
        inventories.append(inventory)
    }

    let myInv = inventories.first!
    let orders = actionList.orders
    let mySpells = actionList.mySpells


    if let orderToBrew = orders.filter({ $0.brewable(fromInventory: myInv) }).sorted(by: { $0.price > $1.price}).first {
        print(Command.brew(orderToBrew.actionId).print)
        continue
    }
    
    if let nextOrderTarget = orders.sorted(by: { $0.costFactor < $1.costFactor}).first {
        debug("\(nextOrderTarget)")
        // what do we need? We need spell to cast Items what we need.
       
        if abs(nextOrderTarget.tier3) > myInv.tier3 {
            debug("need tier3")
            if let cast = mySpells.filter({ $0.canCastTier3(withInv: myInv) }).first {
                debug("cast spell tier3")
                print(Command.cast(cast.actionId).print)
                continue
            }
            
            if let cast = mySpells.filter({ $0.canCastTier2(withInv: myInv) }).first {
                debug("cast spell tier2")
                print(Command.cast(cast.actionId).print)
                continue
            }
            
            if let cast = mySpells.filter({ $0.canCastTier1(withInv: myInv) }).first {
                debug("cast spell tier1")
                print(Command.cast(cast.actionId).print)
                continue
            }
            
            if let cast = mySpells.filter({ $0.canCastTier0(withInv: myInv) }).first {
                debug("cast spell tier0")
                print(Command.cast(cast.actionId).print)
                continue
            }
        }
        
        if abs(nextOrderTarget.tier2) > myInv.tier2 {
            debug("need tier2")
            if let cast = mySpells.filter({ $0.canCastTier2(withInv: myInv) }).first {
                debug("cast spell tier2")
                print(Command.cast(cast.actionId).print)
                continue
            }
            
            if let cast = mySpells.filter({ $0.canCastTier1(withInv: myInv) }).first {
                debug("cast spell tier1")
                print(Command.cast(cast.actionId).print)
                continue
            }
            
            if let cast = mySpells.filter({ $0.canCastTier0(withInv: myInv) }).first {
                debug("cast spell tier0")
                print(Command.cast(cast.actionId).print)
                continue
            }
        }
        
        if abs(nextOrderTarget.tier1) > myInv.tier1 {
            debug("need tier1")
            if let cast = mySpells.filter({ $0.canCastTier1(withInv: myInv) }).first {
                debug("cast spell tier1")
                print(Command.cast(cast.actionId).print)
                continue
            }
            
            if let cast = mySpells.filter({ $0.canCastTier0(withInv: myInv) }).first {
                debug("cast spell tier0")
                print(Command.cast(cast.actionId).print)
                continue
            }
        }
        
        if let cast = mySpells.filter({ $0.canCastTier0(withInv: myInv) }).first {
            debug("cast spell tier0")
            print(Command.cast(cast.actionId).print)
            continue
        }
        debug("nothing to cast ... rest")
        print(Command.rest.print)
        continue
    }

//    if let spellToCastGatherOnly = mySpells.filter({ $0.gatherOnly() }).first {
//        print(Command.cast(spellToCastGatherOnly.actionId).print)
//        continue
//    }


    // Write an action using print("message...")
    // To debug: print("Debug messages...", to: &errStream)


    // in the first league: BREW <id> | WAIT; later: BREW <id> | CAST <id> [<times>] | LEARN <id> | REST | WAIT
    print(Command.rest.print)

}
