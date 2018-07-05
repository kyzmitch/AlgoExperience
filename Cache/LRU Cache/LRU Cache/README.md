#  LRU Cache

LRU is a cache eviction algorithm called least recently used cache.

It uses a hash table to cache the entries and a double linked list to keep track of the access order. If an entry is inserted, updated or accessed, it gets removed and re-linked before the head node. The node before head is the most recently used and the node after is the eldest node. When the cache reaches its maximum size the least recently used entry will be evicted from the cache.

