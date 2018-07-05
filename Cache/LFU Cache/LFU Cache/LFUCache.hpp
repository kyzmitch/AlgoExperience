//
//  LFUCache.hpp
//  LFU Cache
//
//  Created by Andrei Ermoshin on 04/07/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#ifndef LFUCache_hpp
#define LFUCache_hpp

#include <unordered_map>
#include <list>
#include <vector>

class LFUCache {
private:
    typedef int KeyType;
    typedef int ValueType;
    typedef std::pair<KeyType, ValueType> ListPair;
    typedef std::pair<unsigned char, std::list<ListPair>::iterator> HashMapPair;
    std::unordered_map<KeyType, HashMapPair> hashMap;
    std::vector<std::list<ListPair>> frequencies;
    int maxSize;
    const unsigned char listAmount = 4;
public:
    LFUCache(int capacity): maxSize(capacity) {
        for (int i = 0; i < listAmount; i++) {
            std::list<ListPair> list;
            frequencies.insert(frequencies.end(), list);
        }
    }
    
    int get(int key) {
        auto node = hashMap.find(key);
        if (node == hashMap.end()) {
            return -1;
        }
        
        unsigned char index = node->second.first;
        auto list = frequencies[index];
        auto iterator = node->second.second;
        if (iterator == list.begin()) {
            // need to move to next list to the end of it
            if (index < listAmount - 1) {
                auto nextList = frequencies[index + 1];
                // Need to move element from the top of
                // one list to the bottom of another list
                nextList.splice(nextList.end(), list, iterator);
                // https://stackoverflow.com/a/4912492
            }
            // else we can't move element, it is on the top already
        } else {
            // if it's not on the top of the list
            // then need to move element just one position ahead
            auto nextIterator = ++iterator;
            // single element (2) splice method should have 3 arguments
            // http://www.cplusplus.com/reference/list/list/splice/
            list.splice(nextIterator, list, iterator);
        }
        
        int value = node->second.second->second;
        return value;
    }
    
    void put(int key, int value) {
        
    }
};

/**
 * Your LFUCache object will be instantiated and called as such:
 * LFUCache obj = new LFUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */

#endif /* LFUCache_hpp */
