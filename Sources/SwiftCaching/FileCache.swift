import Foundation

public final class FileCache: CodableCache {
    
    private let manager: FileManager
    private let baseURL: URL
    
    public init(manager: FileManager = .default, container: String = "FileCache") {
        self.manager = manager
        let cacheDir = try! manager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.baseURL = cacheDir.appendingPathComponent(container, isDirectory: true)
        try! manager.createDirectory(at: self.baseURL, withIntermediateDirectories: true)
    }
    
    public func cache(_ key: String, data: Data) {
        do {
            let file = URL(fileURLWithPath: "\(key).cache", relativeTo: baseURL)
            try data.write(to: file)
        } catch {
            print("cache error", error)
        }
    }
    
    public func retrieve(_ key: String) -> Data? {
        do {
            let file = URL(fileURLWithPath: "\(key).cache", relativeTo: baseURL)
            return try Data(contentsOf: file)
        } catch {
            print("cache error", error)
            return nil
        }
    }
    
    public func clear() {
        do {
            try manager.removeItem(at: baseURL)
        } catch {
            print("cache error", error)
        }
    }
}
