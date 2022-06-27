import Foundation

public final class MemoryCache: CodableCache {
    
    private var _cache: NSCache<NSString, NSData> = .init()
    
    public init(){ }
    
    public func cache(_ key: String, data: Data) {
        _cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    public func retrieve(_ key: String) -> Data? {
        _cache.object(forKey: key as NSString) as Data?
    }
    
    public func clear() {
        _cache.removeAllObjects()
    }
}
