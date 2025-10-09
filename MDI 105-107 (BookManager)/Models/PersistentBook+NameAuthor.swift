
import Foundation

extension PersistentBook {
    /// Returns  "Title by Author" 
    func getNameAndAuthor() -> String {
        let who = author.trimmingCharacters(in: .whitespacesAndNewlines)
        let authorText = who.isEmpty ? "Unknown Author" : who
        return "\(title) by \(authorText)"
    }
}
