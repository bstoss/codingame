//: Playground - noun: a place where people can play

import UIKit

func going(_ n: Int) -> Double {
    // your code

    let fact = factorialInt(n)

    let first = Double(1 / Double(fact))
    var second = 0
    for i in 1..<n {
        second += factorialInt(i)
    }
    second += fact
    let result = first * Double(second)
    return roundDown(result, toPlaces: 6)
}

func going2(_ n: Int) -> Double {
    // your code

    let first = firstResult(n)
    var secondList: [String] = []
    for i in 1...n {
        secondList.append(factorial(i))
    }
    let second = sum(secondList)
    print("\(first)")
    print(secondList)
    print(second)
    let result = "\(first)" * second
    print(result)
    return roundDown(Double(result)!, toPlaces: 6)
}

func roundDown(_ number: Double, toPlaces places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return floor(number * divisor) / divisor
}

func firstResult(_ n: Int) -> Double {
    var result: Double = 1.0
    for i in 1...n {
        result /= Double(i)
    }
    return result
}

func factorial(_ number: Int) -> String {
    if number == 0 {
        return "1"
    } else {
        let stringNumber = "\(number)"
        return factorial(number - 1) * stringNumber
    }
}

func factorialInt(_ number: Int) -> Int {
    if number == 0 {
        return 1
    } else {
        return number * factorialInt(number - 1)
    }
}


func * (_ lhs: String, rhs: String) -> String {
    let reversedLhs = lhs.reversed()
    var i = rhs.count
    var multiList: [String] = []
    rhs.forEach { cr in

        let rNum = String(cr)
        var rMulti = ""
        var lMultiOverload: Int = 0
        reversedLhs.forEach({ cl in
            let lMulti = Int(rNum)! * Int(String(cl))! + lMultiOverload
            var lMultiOverloadS = "\(lMulti)"
            if lMultiOverloadS.count > 1 {
                let lMultiS = lMultiOverloadS.characters.dropFirst()
                lMultiOverload = Int(String(lMultiOverloadS.characters.dropLast()))!
                rMulti = String(lMultiS) + rMulti
            } else {
                rMulti = lMultiOverloadS + rMulti
                lMultiOverload = 0
            }
        })
        if lMultiOverload > 0 {
            rMulti = "\(lMultiOverload)" + rMulti
        }
        for _ in 1..<i {
            rMulti = rMulti + "\(0)"
        }
        multiList.append(rMulti)
        i -= 1
    }

    let summe = sum(multiList)
    return summe
}

func sum (_ list: [String]) -> String {
    var res = ""
    list.forEach { number in

        if res == "" {
            res = number
        } else {

            let lhs = res.reversed()
            let rhs = number.reversed()
            var newRes = ""
            var summOverload = 0
            for i in 0..<lhs.count {
                let lhsIndex = lhs.index(lhs.startIndex, offsetBy: i)
                guard let lhsNumber = Int(String(lhs[lhsIndex])) else {
                    continue
                }
                //print("LHS: \(lhsNumber)")

                if i < rhs.count {
                    let rhsIndex = rhs.index(rhs.startIndex, offsetBy: i)
                    guard let rhsNumber = Int(String(rhs[rhsIndex])) else {
                        continue
                    }
                    let su = lhsNumber + rhsNumber + summOverload
                    if su > 9 {
                        newRes = newRes + "\(su)".dropFirst()
                        summOverload = Int(String("\(su)".dropLast()))!
                    } else {
                        newRes = newRes + "\(su)"
                        summOverload = 0
                    }
                } else {
                    newRes = newRes + "\(lhsNumber+summOverload)"
                    summOverload = 0
                }
            }
            if summOverload > 0 {
                newRes = newRes + "\(summOverload)"
            }
            res = String(newRes.reversed())
        }
        print(res)
    }
    return res
}

//print(going(5))
//print(going2(5))
let test2 = factorial(10)
print(test2)
let test = ["1", "2", "6", "24", "120"]
print(test)
//print(sum(test))





