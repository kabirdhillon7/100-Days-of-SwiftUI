//
//  RatingView.swift
//  11. Bookworm
//
//  Created by Kabir Dhillon on 4/19/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    @State private var animation = 1.0
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    withAnimation {
                        rating = number
                        animation += 1
                    }
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
                .animation(.smooth(duration: 0.5), value: animation)
            }
        }
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
