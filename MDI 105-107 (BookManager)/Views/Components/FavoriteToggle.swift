//
//  FavoriteToggle.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/25/25.
//

import SwiftUI

struct FavoriteToggle: View {
    
    @Binding var isFavorite: Bool
    
    //animation variables
    @State private var scale: CGFloat = 1
    @State private var opacity: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    
   
    
    
    public var body: some View {
        ZStack {
            Image(systemName: "hear.fill")
                .foregroundColor(.red)
                .font(.largeTitle)
                .opacity(opacity)
                .scaleEffect(scale)
                .offset(y: offsetY)
            Toggle(isOn: $isFavorite){
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .secondary)
                
            }
            .toggleStyle(.button)
            .buttonStyle(.plain)
            .animation(.spring, value: isFavorite)
            .accessibilityLabel(isFavorite ? "Remove from Favorites" : "Add to Favorites")
            .onChange(of: isFavorite) { oldValue, newValue in
                guard newValue == true else {
                    return
                }
                //if guard is true it continues to here
                
                //appear and grow
                withAnimation(.spring(response:0.5, dampingFraction: 0.4)){
                    opacity = 1 //makes the heart completly visible
                    scale = 1.2 // increase scale to %120
                    
                }
                //float and vanish
                withAnimation(.easeInOut(duration: 0.5).delay(0.3)){
                    opacity = 0
                    offsetY = -100
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    scale = 1
                    offsetY = 0
                }
            }
        }
        
    }
}
