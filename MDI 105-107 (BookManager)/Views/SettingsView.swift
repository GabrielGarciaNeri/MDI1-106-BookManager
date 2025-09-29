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
                
            }
        }
    }
}
