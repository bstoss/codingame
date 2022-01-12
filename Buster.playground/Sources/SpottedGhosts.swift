import Foundation

struct SpottedGhosts {
    
    var ghosts: [Ghost] = []
    var ghostTrigger: [(buster: Buster, ghostId: Int)] = []
    let team: Team
    
    init(withTeam team: Team) {
        self.team = team
    }
    
    mutating internal func updateGhosts(newGhosts: [Ghost]) {
        
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
    
    mutating internal func removeGhost(withId id: Int) {
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