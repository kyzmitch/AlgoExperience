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
    unsigned int maxSize;
    unsigned int size;
    typedef unsigned int FrequencyType;
    FrequencyType minFreq;
    typedef int KeyType;
    typedef int ValueType;
    typedef std::pair<ValueType, FrequencyType> ValueFreqType;
    std::unordered_map<KeyType, ValueFreqType> cache; // key to {value,freq}
    typedef std::list<KeyType> KeysList;
    std::unordered_map<KeyType, KeysList::iterator> listCache; // key to list iterator
    std::unordered_map<FrequencyType, KeysList> frequencyCache; // freq to key list

    const int notFound = -1;

public:
    LFUCache(int capacity): maxSize(capacity), size(0) { }
    
    int get(int key) {
        if(cache.count(key)==0) return notFound;

        auto frequency = cache[key].second;
        auto removableIterator = listCache[key];
        frequencyCache[frequency].erase(removableIterator);
        cache[key].second++; // increase frequency
        auto nextFrequency = frequency + 1;
        frequencyCache[nextFrequency].push_back(key);
        listCache[key] = --frequencyCache[nextFrequency].end();

        auto list = frequencyCache[minFreq];
        if (list.empty()) {
            minFreq++;
        }

        return cache[key].first;
    }
    
    void put(int key, int value) {
        if (maxSize == 0) return;

        int storedValue = get(key);
        if (storedValue != notFound) {
            cache[key].first=value;
            return;
        }

        if (size >= maxSize ) {
            auto key = frequencyCache[minFreq].front();
            cache.erase(key);
            listCache.erase(key);
            frequencyCache[minFreq].pop_front();
            size--;
        }

        cache[key] = {value, 1};
        frequencyCache[1].push_back(key);
        listCache[key] = --frequencyCache[1].end();
        minFreq = 1;
        size++;
    }
};

#endif /* LFUCache_hpp */
