import Foundation


struct Ghost {
    let x: Int
    let y: Int
    let id: Int
    let bustersAttemping: Int
    var getsAttacked: Bool = false
    var visible: Bool = true
    let stamina: Int
    
    internal init(x:Int, y:Int, id:Int, bustersAttemping:Int, stamina: Int) {
        self.x = x
        self.y = y
        self.id = id
        self.bustersAttemping = bustersAttemping
        self.stamina = stamina
    }
}