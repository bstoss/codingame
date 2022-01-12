import Foundation

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
    
    internal init(x:Int, y:Int, id:Int, state: BusterState, value:Int?) {
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