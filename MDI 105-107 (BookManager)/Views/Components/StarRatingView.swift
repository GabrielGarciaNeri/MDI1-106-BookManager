//
//  StarRatingView.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/20/25.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { starRate in
                Button(action: {
                    rating = starRate
                }) {
                    Image(systemName: starRate <= self.rating ? "star.fill" : "star")
                        .foregroundStyle(Color.yellow)
                        .font(.title2)
                }.buttonStyle(.plain)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityValue ( "\(rating) out of 5 stars")
            .accessibilityLabel("Book Rating")
            .accessibilityAdjustableAction {direction in
                switch direction {
                case .increment:
                    rating = min(rating + 1, 5)
                case .decrement:
                    rating = max(rating - 1, 1)
                @unknown default:
                    break
                }
                
            }
            
        }
    }


