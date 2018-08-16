#  LFU Cache

LFU is a cache eviction algorithm called least frequently used cache.

### implementation
It requires three data structures. One is a hash table which is used to cache the key/values so that given a key we can retrieve the cache entry at O(1). Second one is a double linked list for each frequency of access. The max frequency is capped at the cache size to avoid creating more and more frequency list entries. If we have a cache of max size 4 then we will end up with 4 different frequencies. Each frequency will have a double linked list to keep track of the cache entries belonging to that particular frequency. The third data structure would be to somehow link these frequencies lists. It can be either an array or another linked list so that on accessing a cache entry it can be easily promoted to the next frequency list in time O(1).

### implementation from wikipedia
The simplest method to employ an LFU algorithm is to assign a counter to every block that is loaded into the cache. Each time a reference is made to that block the counter is increased by one. When the cache reaches capacity and has a new block waiting to be inserted the system will search for the block with the lowest counter and remove it from the cache.

### Problems
While the LFU method may seem like an intuitive approach to memory management it is not without faults. Consider an item in memory which is referenced repeatedly for a short period of time and is not accessed again for an extended period of time. Due to how rapidly it was just accessed its counter has increased drastically even though it will not be used again for a decent amount of time. This leaves other blocks which may actually be used more frequently susceptible to purging simply because they were accessed through a different method.[3]

Moreover, new items that just entered the cache are subject to being removed very soon again, because they start with a low counter, even though they might be used very frequently after that. Due to major issues like these, a pure LFU system is fairly uncommon; instead, there are hybrids that utilize LFU concepts.

