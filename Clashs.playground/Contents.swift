import Foundation

let count = 5
let repeats: Int = Int(exactly: floor(Double(count)/2+1))!
var arr: [Int] = [22,5,22,4,22]
if count > 0 {
    for i in 0...(count-1) {
        let n = Int(readLine()!)!
        arr.append(n)
    }
}



var output = "N"
for n in Set(arr) {
    if arr.filter({ $0 == n }).count >= repeats {
        output = "\(n)"
        break
    }
}
print(output)
