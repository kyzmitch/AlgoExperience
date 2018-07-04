//
//  main.cpp
//  LRU Cache
//
//  Created by Andrei Ermoshin on 03/07/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#include <iostream>
#include <list>
#include <unordered_map>

// https://en.wikipedia.org/wiki/Cache_replacement_policies#Least_recently_used_(LRU)
// https://www.geeksforgeeks.org/lru-cache-implementation/

class LRUCache {
private:
    typedef int KeyType;
    typedef int ValueType;
    typedef std::pair<KeyType, ValueType> ListPair;
    /* queue needed to implement caching policy
     to only store keys for values which were recently accessed */
    std::list<ListPair> queue;
    /* dictionary needed to allow fast access
     because list data structure has O(n) complexity for random access */
    typedef std::list<ListPair>::iterator ListIterator;
    std::unordered_map<KeyType, ListIterator> cache;
    typedef std::pair<KeyType, ListIterator> CachePair;
    int maxSize;
public:
    LRUCache(int capacity): maxSize(capacity) {}
    
    void put(int key, int value) {
        auto cachedIterator = cache.find(key);
        if (cachedIterator != cache.end()) {
            // Need to move node to the beginning
            // because it was just accessed
            queue.splice(queue.begin(), queue, cachedIterator->second);
            /*
             splice can be achived by next operations:
             
             queue.erase(cachedIterator->second);
             queue.push_front(ListPair(key, value));
             cache.insert(CachePair(key, queue.begin()));
             */
            
            // Now need to update value
            cachedIterator->second->second = value;
            return;
        }
        if (cache.size() == maxSize) {
            auto removedKey = queue.back().first;
            queue.pop_back();
            cache.erase(removedKey);
        }
        
        ListPair pair(key, value);
        queue.push_front(pair);
        CachePair cachePair(key, queue.begin());
        cache.insert(cachePair);
    }
    
    int get(int key) {
        auto iterator = cache.find(key);
        if (iterator == cache.end()) {
            return -1;
        } else {
            // Need to move node to the beginning of the queue
            queue.splice(queue.begin(), queue, iterator->second);
            ValueType value = iterator->second->second;
            /*
             splice can be achived by next operations:
             
             queue.erase(iterator->second);
             queue.push_front(ListPair(key, value));
             */
            return value;
        }
    }
};

/**
 * Your LRUCache object will be instantiated and called as such:
 * LRUCache obj(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */

int main(int argc, const char * argv[]) {
    LRUCache cache(2);
    cache.put(1, 1);
    cache.put(2, 2);
    std::cout << cache.get(1) << std::endl;
    cache.put(3, 3);
    std::cout << cache.get(2) << std::endl;
    cache.put(4, 4);
    std::cout << cache.get(1) << std::endl;
    std::cout << cache.get(3) << std::endl;
    std::cout << cache.get(4) << std::endl;
    return 0;
}
