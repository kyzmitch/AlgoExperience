//
//  main.swift
//  Trie
//
//  Created by Andrei Ermoshin on 02/07/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

import Foundation

let keys = ["the", "a", "there", "answer", "any",
    "by", "bye", "their"]

let output = ["Not present in trie", "Present in trie"]

let trie = Trie()

func analyzePresence(in trie: Trie, of string: String) {
    if trie.search(string) {
        print("\(string) --- " + output[1])
    } else {
        print("\(string) --- " + output[0])
    }
}

for x in keys {
    trie.insert(x)
}

analyzePresence(in: trie, of: "the")
analyzePresence(in: trie, of: "these")
analyzePresence(in: trie, of: "their")
analyzePresence(in: trie, of: "thaw")
