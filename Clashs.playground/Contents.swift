import Foundation


let S = "Hello World"

// Write an answer using print("message...")
// To debug: print("Debug messages...", to: &errStream)

var output = ""
for c in S {
    if c.isUppercase {
        output += "-"
    } else if c.isLowercase {
        output += "_"
    } else {
         output += "*"
    }
}

let out2 = S.map { c in
    if c.isUppercase {
        return "-"
    } else if c.isLowercase {
        return "_"
    } else {
        return "*"
    }
}.joined()

print(output)
print(out2)
