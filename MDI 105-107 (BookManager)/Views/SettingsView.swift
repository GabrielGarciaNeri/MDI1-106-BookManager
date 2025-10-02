//
//  SettingsView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/25/25.
//

import SwiftUI

struct SettingsView: View {
    
    //@State var currentTheme: Theme = .light
    @AppStorage(SETTINGS_THEME_KEY) var currentTheme: Theme = .light
    @AppStorage(SETTINGS_GRID_COLUMNS_KEY) var gridColumns: Int = SETTINGS_GRID_COLUMNS_DEFAULT_VALUE
    @AppStorage(SETTINGS_ACCENT_COLOR_KEY) var accentColor: Color = SETTINGS_ACCENT_COLOR_DEFAULT_VALUE
    @AppStorage(SETTINGS_LIST_COMPACT_ROWS_KEY) private var listCompactRows: Bool = SETTINGS_LIST_COMPACT_ROWS_DEFAULT
    @AppStorage(SETTINGS_LIST_SORT_KEY) private var listSort: ListSort = SETTINGS_LIST_SORT_DEFAULT
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Appearance")){
                    Picker("Theme", selection: $currentTheme){
                        ForEach(Theme.allCases, id:\.self){
                            theme in
                            Text(theme.rawValue.capitalized).tag(theme.rawValue)
                        }
                    }
                    ColorPicker("Accent Color", selection: $accentColor)
                    .pickerStyle(SegmentedPickerStyle())
                    
                    
                    }
                Section(header: Text("Grid")){
                    Stepper("Columns: \(gridColumns)", value: $gridColumns, in: 2...4)
                }
                Section(header: Text("List settings")) {
                    // Setting 1: Compact rows
                    Toggle("Compact row height", isOn: $listCompactRows)
                        .onChange(of: listCompactRows) { _, _ in /* persists automatically via AppStorage */ }

                    // Setting 2: Sort order
                    Picker("Sort by", selection: $listSort) {
                        ForEach(ListSort.allCases) { option in
                            Text(option.label).tag(option)
                        }
                    }
                }
                
            }
        }
    }
}
