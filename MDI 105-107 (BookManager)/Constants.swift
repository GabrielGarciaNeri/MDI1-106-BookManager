//
//  Constants.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/25/25.
//
import SwiftUI


public let SETTINGS_THEME_KEY = "SETTINGS_THEME_KEY"
public let SETTINGS_ACCENT_COLOR_KEY = "SETTINGS_ACCENT_COLOR_KEY"
public let SETTINGS_ACCENT_COLOR_DEFAULT_VALUE = Color.blue
public let SETTINGS_GRID_COLUMNS_KEY = "SETTINGS_GRID_COLUMNS_KEY"
public let SETTINGS_GRID_COLUMNS_DEFAULT_VALUE = 2

public let SETTINGS_LIST_COMPACT_ROWS_KEY = "SETTINGS_LIST_COMPACT_ROWS_KEY"
public let SETTINGS_LIST_COMPACT_ROWS_DEFAULT = false

public enum ListSort: String, CaseIterable, Identifiable, Codable {
    case title, author, rating
    public var id: String { rawValue }
    public var label: String {
        switch self {
        case .title:  return "Title"
        case .author: return "Author"
        case .rating: return "Rating"
        }
    }
}

public let SETTINGS_LIST_SORT_KEY = "SETTINGS_LIST_SORT_KEY"
public let SETTINGS_LIST_SORT_DEFAULT: ListSort = .title
