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
#include <iostream>

class LFUCache {
private:
    typedef int KeyType;
    typedef int ValueType;
    typedef std::pair<KeyType, ValueType> ListPair;
    typedef std::pair<unsigned char, std::list<ListPair>::iterator> HashMapPair;
    std::unordered_map<KeyType, HashMapPair> hashMap;
    std::list<ListPair> first;
    std::list<ListPair> second;
    int maxSize;
    
    void moveToAnotherFrequency(unsigned char index,
                                std::list<ListPair>::iterator iterator) {
        // need to move to next list to the end of it
        if (index == 0) {
            // Need to move element from the top of
            // one list to the bottom of another list
            second.splice(second.end(), index == 0 ? first : second, iterator);
            // https://stackoverflow.com/a/4912492
        }
        // else we can't move element, it is on the top already
    }
    
    void moveInSameFrequency(unsigned char index,
                             std::list<ListPair>::iterator iterator) {
        // if it's not on the top of the list
        // then need to move element just one position ahead
        auto nextIterator = ++iterator;
        // single element (2) splice method should have 3 arguments
        // http://www.cplusplus.com/reference/list/list/splice/
        (index == 0 ? first : second).splice(nextIterator,
                                             index == 0 ? first : second,
                                             iterator);
    }
    
public:
    LFUCache(int capacity): maxSize(capacity) { }
    
    int get(int key) {
        auto node = hashMap.find(key);
        if (node == hashMap.end()) {
            return -1;
        }
        
        unsigned char index = node->second.first;
        auto iterator = node->second.second;
        if (index == 0 && iterator == first.begin()) {
            moveToAnotherFrequency(index, iterator);
            node->second.first++;
            node->second.second = --second.end();
        } else {
            moveInSameFrequency(index, iterator);
            node->second.second = --iterator;
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
            if (iterator == (index == 0 ? first : second).begin()) {
                moveToAnotherFrequency(index, iterator);
                node->second.first++;
            } else {
                moveInSameFrequency(index, iterator);
            }
            return;
        }
        
        if (hashMap.size() == maxSize) {
            // need to remove last value from the last
            // non empty list
            size_t fsize = first.size();
            size_t ssize = second.size();
            if (fsize != 0) {
                auto lastNode = first.back();
                hashMap.erase(lastNode.first);
                first.pop_back();
            } else if (ssize != 0) {
                auto lastNode = second.back();
                hashMap.erase(lastNode.first);
                second.pop_back();
            }
        }
        
        // Now need to insert completely new value to cache
        ListPair pair(key, value);
        first.push_back(pair);
        
        auto insertedIterator = --first.end();
        HashMapPair subPair(0, insertedIterator);
        std::pair<KeyType, HashMapPair> cachePair(key, subPair);
        hashMap.insert(cachePair);
    }
};

#endif /* LFUCache_hpp */
