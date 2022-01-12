import Foundation

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
    
    internal func campInEnemyBase(forBuster buster: Buster) -> (x:Int, y:Int) {
        var index = buster.id
        if team == .Purple {
            index = index - (amountOfBusters-1)
        }
        return enemyBasePositions[index]
    }
    
    mutating internal func nextTargetPosition(forBuster buster: Buster) -> (x:Int, y:Int) {
        
        var busterIndex = buster.id
        if team == .Purple {
            busterIndex = busterIndex - (amountOfBusters-1)
        }

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