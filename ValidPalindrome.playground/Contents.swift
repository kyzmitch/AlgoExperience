//: Playground - noun: a place where people can play

import Cocoa

// https://leetcode.com/problems/valid-palindrome/description/

// Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
//
// For example,
// "A man, a plan, a canal: Panama" is a palindrome.
// "race a car" is not a palindrome.
//
// Note:
// Have you consider that the string might be empty? This is a good question to ask during an interview.
//
// For the purpose of this problem, we define empty string as valid palindrome.

class Solution {
    func isPalindrome(s: String) -> Bool {
        return false
    }
}

let t1 = "A man, a plan, a canal: Panama"
let t2 = "race a car"

let solution = Solution()
print("\(t1) - \(solution.isPalindrome(s: t1))")
print("\(t2) - \(solution.isPalindrome(s: t2))")
