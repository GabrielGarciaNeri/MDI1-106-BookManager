//
//  FilterView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/25/25.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedGenre: Genre?
    @Binding var selectedStatus: ReadingStatus?
    
    var body: some View {
        Form{
            Section(header: Text("Filter by genre")){
                Picker("Genre", selection: $selectedGenre){
                    Text("Select a genre").tag(nil as Genre?) // Case for not selecting a filter value
                    ForEach(Genre.allCases, id: \.self){ status in
                        Text(status.rawValue).tag(status) //All filter possible values
                        
                        
                        }
                    }
                
                        
                }
            Section(header: Text("Filter by status")){
                Picker("Status", selection: $selectedStatus){
                    Text("Select a status").tag(nil as ReadingStatus?)
                    ForEach(ReadingStatus.allCases, id: \.self){ status in
                        Text(status.rawValue).tag(status)
                    }
                }
            }
        }
    }
}
