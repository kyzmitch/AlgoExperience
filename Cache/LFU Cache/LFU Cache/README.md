#  LFU Cache

LFU is a cache eviction algorithm called least frequently used cache.

It requires three data structures. One is a hash table which is used to cache the key/values so that given a key we can retrieve the cache entry at O(1). Second one is a double linked list for each frequency of access. The max frequency is capped at the cache size to avoid creating more and more frequency list entries. If we have a cache of max size 4 then we will end up with 4 different frequencies. Each frequency will have a double linked list to keep track of the cache entries belonging to that particular frequency. The third data structure would be to somehow link these frequencies lists. It can be either an array or another linked list so that on accessing a cache entry it can be easily promoted to the next frequency list in time O(1).

