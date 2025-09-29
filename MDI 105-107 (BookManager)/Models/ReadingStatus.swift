//
//  ReadingStatus.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/25/25.
//

enum ReadingStatus: String, CaseIterable {
    case planToRead = "Plan to read"
    case reading = "Reading"
    case read = "Read"
    case dropped = "Dropped"
    case finished = "Finished"
    case unknown = "Unknown"
}
