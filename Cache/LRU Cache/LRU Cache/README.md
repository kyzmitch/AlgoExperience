#  LRU Cache

LRU is a cache eviction algorithm called least recently used cache.

It uses a hash table to cache the entries and a double linked list to keep track of the access order. If an entry is inserted, updated or accessed, it gets removed and re-linked before the head node. The node before head is the most recently used and the node after is the eldest node. When the cache reaches its maximum size the least recently used entry will be evicted from the cache.

https://stackoverflow.com/a/2504317/483101

A linked list + hashtable of pointers to the linked list nodes is the usual way to implement LRU caches. This gives O(1) operations (assuming a decent hash). Advantage of this (being O(1)): you can do a multithreaded version by just locking the whole structure. You don't have to worry about granular locking etc.

Briefly, the way it works:

On an access of a value, you move the corresponding node in the linked list to the head.

When you need to remove a value from the cache, you remove from the tail end.

When you add a value to cache, you just place it at the head of the linked list.
