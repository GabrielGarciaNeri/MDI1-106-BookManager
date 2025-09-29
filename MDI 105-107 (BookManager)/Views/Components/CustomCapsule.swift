//
//  CustomCapsule.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/25/25.
//

import SwiftUI

struct CustomCapsule: View {
    var text: String
    var color = Color.accentColor
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.bold)
            .padding(8)
            .background(color.opacity(0.3))
            .clipShape(Capsule())
    }
}
