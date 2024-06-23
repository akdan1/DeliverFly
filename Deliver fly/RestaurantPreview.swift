//
//  RestaurantPreview.swift
//  Deliver fly
//
//  Created by user on 6/16/24.
//

import SwiftUI

struct RestaurantPreview: View {
    let restaurant: Restaurant
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Image(restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Text(restaurant.name)
                .font(.title2)
                .foregroundStyle(.darkBlue)
            
            Text(restaurant.foods.map{ $0.name }.joined(separator: "-"))
                .font(.subheadline)
                .foregroundStyle(.gray)
                .lineLimit(1)
            
            HStack {
                Image(.star)
                    .renderingMode(.template)
                    .foregroundStyle(.darkOrange)
                Text(String(restaurant.rating))
                    .bold()
                    .foregroundStyle(.darkBlue)
                Image(.truck)
                    .renderingMode(.template)
                    .foregroundStyle(.darkOrange)
                    .padding(.leading)
                Text("Free")
                    .fontWeight(.bold)
                    .foregroundStyle(.darkBlue)
                Image(.clock)
                    .renderingMode(.template)
                    .foregroundStyle(.darkOrange)
                    .padding(.leading)
                Text("\(restaurant.time)")
                    .fontWeight(.bold)
                    .foregroundStyle(.darkBlue)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RestaurantPreview(restaurant: .inNOut)
}
