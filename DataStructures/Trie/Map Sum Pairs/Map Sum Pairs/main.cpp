//
//  main.cpp
//  Map Sum Pairs
//
//  Created by Andrei Ermoshin on 24/09/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#include <iostream>
#include "TrieMap.hpp"

int main(int argc, const char * argv[]) {

    /**
     * Your MapSum object will be instantiated and called as such:
     * MapSum obj = new MapSum();
     * obj.insert(key,val);
     * int param_2 = obj.sum(prefix);
     */

    MapSum *obj = new MapSum();
    obj->insert("apple", 3);
    int param_2 = obj->sum("ap"); // 3
    std::cout << param_2 << std::endl;
    obj->insert("app", 2);
    param_2 = obj->sum("ap"); // 5
    std::cout << param_2 << std::endl;
    obj->insert("apple", 10);
    param_2 = obj->sum("ap"); // 12
    std::cout << param_2 << std::endl;
    delete obj;

    return 0;
}
