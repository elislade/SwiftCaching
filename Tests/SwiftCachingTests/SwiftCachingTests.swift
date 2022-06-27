import XCTest
@testable import SwiftCaching

final class SwiftCachingTests: XCTestCase {
    
    func testMemoryCache() throws {
        let val = FakeData()
        let key = "memory_data"
        let cache = MemoryCache()
        cache.cache(key, data: val)
        let result: FakeData? = cache.retrieve(key)
        XCTAssertEqual(val, result)
        cache.clear()
        XCTAssertNil(cache.retrieve(key))
    }
    
    func testFileCache() throws {
        let val = FakeData()
        let key = "file_data"
        let cache = FileCache(container: "SwiftCachingTest")
        cache.cache(key, data: val)
        let result: FakeData? = cache.retrieve(key)
        XCTAssertEqual(val, result)
        cache.clear()
        XCTAssertNil(cache.retrieve(key))
    }
    
    func testPersistingCache() throws {
        let val = FakeData()
        let key = "persisting_data"
        let fileCache = FileCache(container: "SwiftCachingTest")
        let memoryCache = MemoryCache()
        let cache = PersistingCache(fileCache: fileCache, memoryCache: memoryCache)
        cache.cache(key, data: val)
        
        memoryCache.clear()
        
        let persistResult: FakeData? = cache.retrieve(key)
        XCTAssertEqual(val, persistResult)
        
        let fileResult: FakeData? = fileCache.retrieve(key)
        XCTAssertEqual(val, fileResult)
        
        let memoryResult: FakeData? = memoryCache.retrieve(key)
        XCTAssertEqual(val, memoryResult)
        
        cache.clear()
        XCTAssertNil(cache.retrieve(key))
    }
    
}


struct FakeData: Codable, Hashable {
    let id: UUID
    let value: Int
    
    init() {
        self.id = UUID()
        self.value = .random(in: -1_000...1_000)
    }
}
