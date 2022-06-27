# SwiftCaching

A simple caching package that allows caching data in-memory with `MemoryCache`, on-disk with `FileCache`, or a hybrid of both with `PersistingCache`.


eg.

```
    let val = FakeData()
    let key = "memory_data"
    let cache = MemoryCache()
    cache.cache(key, data: val)
    let result: FakeData? = cache.retrieve(key)
```
