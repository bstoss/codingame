import Foundation

struct BustersStunCount {
    var busterIdAndStunCount: [(id:Int, stun:Int)] = []
    
    mutating internal func addBuster(withId id: Int) {
        busterIdAndStunCount.append((id: id, stun: 20))
    }
    
    internal func busterCanStun(withId id: Int) -> Bool {
        
        if busterIdAndStunCount.filter({ $0.id == id }).count > 0 {
            return false
        }
        return true
    }
    
    mutating internal func reduceStunForTurn() {
        if busterIdAndStunCount.count == 0 {
            return
        }
        var newList: [(id:Int, stun:Int)] = []
        for i in 0...busterIdAndStunCount.count-1 {
            let busterIdAndStun = busterIdAndStunCount[i]
            if busterIdAndStun.stun - 1 > 0 {
                newList.append((id:busterIdAndStun.id, stun:busterIdAndStun.stun - 1 ))
            }
        }
        
        busterIdAndStunCount = newList
    }
}