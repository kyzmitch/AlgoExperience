//: Playground - noun: a place where people can play

// Suppose you are building an N node binary search tree with the values 1..N.
// How many structurally different  binary search trees are there that store those values?

//  For example, countTrees(4) should return 14, since there are 14  structurally unique binary search trees that store 1, 2, 3, and 4. The base case is easy, and the recursion is short but dense. Your code should not construct any actual trees; it's just a counting problem.

func countTrees(forUpper bound: Int) -> Int {
    if bound <= 1 {
        return 1
    }
    else {
        var l = 0
        var r = 0
        var sum = 0
        for root in 1...bound {
            l = countTrees(forUpper: root - 1)
            r = countTrees(forUpper: bound - root)
            sum += l * r
        }
        
        return sum
    }
}

print("\(countTrees(forUpper: 4))")
