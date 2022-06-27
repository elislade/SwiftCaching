import Foundation

public final class PersistingCache: CodableCache {
    
    private let fileCache: Cache
    private let memoryCache: Cache
    
    public init(fileCache: Cache, memoryCache: Cache) {
        self.fileCache = fileCache
        self.memoryCache = memoryCache
    }
    
    public func cache(_ key: String, data: Data) {
        fileCache.cache(key, data: data)
        memoryCache.cache(key, data: data)
    }
    
    public func retrieve(_ key: String) -> Data? {
        if let item = memoryCache.retrieve(key) {
            return item
        } else if let item = fileCache.retrieve(key) {
            memoryCache.cache(key, data: item)
            return item
        } else {
            return nil
        }
    }
    
    public func clear() {
        memoryCache.clear()
        fileCache.clear()
    }
}
