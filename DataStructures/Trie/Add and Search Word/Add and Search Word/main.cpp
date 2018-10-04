//
//  main.cpp
//  Add and Search Word
//
//  Created by Andrei Ermoshin on 04/10/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#include <iostream>
#include "WordDictionary.hpp"

using namespace std;

void searchExpression(WordDictionary &obj, std::string exp) {
    std::cout << string(obj.search(exp) ? "true" : "false") << string("\n");
}

int main(int argc, const char * argv[]) {
    WordDictionary obj;
    obj.addWord("bad");
    obj.addWord("dad");
    obj.addWord("mad");

    searchExpression(obj, "pad"); // false
    searchExpression(obj, "bad"); // true
    searchExpression(obj, ".ad"); // true
    searchExpression(obj, "b.."); // true

    return 0;
}
