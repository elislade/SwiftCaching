import Foundation

public protocol Cache {
    func cache(_ key: String, data: Data)
    func retrieve(_ key: String) -> Data?
    func clear()
}

public protocol TopLevelEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

public protocol TopLevelDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONEncoder: TopLevelEncoder {}
extension JSONDecoder: TopLevelDecoder {}
extension PropertyListEncoder: TopLevelEncoder {}
extension PropertyListDecoder: TopLevelDecoder {}

public protocol CodableCache: Cache {
    var encoder: TopLevelEncoder { get }
    var decoder: TopLevelDecoder { get }
    
    func cache<T: Encodable>(_ key: String, data: T)
    func retrieve<T: Decodable>(_ key: String) -> T?
}

public extension CodableCache {
    
    var encoder: TopLevelEncoder { JSONEncoder() }
    var decoder: TopLevelDecoder { JSONDecoder() }
    
    func cache<T:Encodable>(_ key: String, data: T) {
        do {
            let data = try encoder.encode(data)
            cache(key, data: data)
        } catch {
            print("Cache coding error", error)
        }
    }
    
    func retrieve<T:Decodable>(_ key: String) -> T? {
        if let data = retrieve(key) {
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }
}
