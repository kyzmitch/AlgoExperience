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
    
    void moveToAnotherFrequency(unsigned char index,
                                std::list<ListPair> list,
                                std::list<ListPair>::iterator iterator) {
        // need to move to next list to the end of it
        if (index < listAmount - 1) {
            auto nextList = frequencies[index + 1];
            // Need to move element from the top of
            // one list to the bottom of another list
            nextList.splice(nextList.end(), list, iterator);
            // https://stackoverflow.com/a/4912492
        }
        // else we can't move element, it is on the top already
    }
    
    void moveInSameFrequency(std::list<ListPair> list,
                             std::list<ListPair>::iterator iterator) {
        // if it's not on the top of the list
        // then need to move element just one position ahead
        auto nextIterator = ++iterator;
        // single element (2) splice method should have 3 arguments
        // http://www.cplusplus.com/reference/list/list/splice/
        list.splice(nextIterator, list, iterator);
    }
    
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
            moveToAnotherFrequency(index, list, iterator);
        } else {
            moveInSameFrequency(list, iterator);
        }
        
        int value = node->second.second->second;
        return value;
    }
    
    void put(int key, int value) {
        auto node = hashMap.find(key);
        if (node != hashMap.end()) {
            // need update value and move element up in the queue
            node->second.second->second = value;
            unsigned char index = node->second.first;
            auto iterator = node->second.second;
            auto list = frequencies[index];
            if (iterator == list.begin()) {
                moveToAnotherFrequency(index, list, iterator);
            } else {
                moveInSameFrequency(list, iterator);
            }
            return;
        }
        
        if (hashMap.size() == maxSize) {
            // need to remove last value from the last
            // non empty list
            for (int i = 0; i < listAmount; i++) {
                auto list = frequencies[i];
                if (list.size() != 0) {
                    auto lastNode = list.back();
                    hashMap.erase(lastNode.first);
                    list.pop_back();
                    break;
                }
            }
        }
        
        // Now need to insert completely new value to cache
        ListPair pair(key, value);
        auto firstList = frequencies.front();
        firstList.push_back(pair);
        auto insertedIterator = firstList.end()--;
        HashMapPair subPair(0, insertedIterator);
        std::pair<KeyType, HashMapPair> cachePair(key, subPair);
        hashMap.insert(cachePair);
    }
};

/**
 * Your LFUCache object will be instantiated and called as such:
 * LFUCache obj = new LFUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */

#endif /* LFUCache_hpp */
