//
//  HomeView.swift
//  Deliver fly
//
//  Created by user on 6/16/24.
//

import SwiftUI

struct HomeView: View {
    let list: [Restaurant] = .restaurants
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        // go to history
                    }, label: {
                        Image(.history)
                            .padding()
                            .background(.lightGray)
                            .clipShape(Circle())
                    })
                    VStack(alignment: .leading) {
                        Text("DELIVER TO")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.darkOrange)
                        Text("16 Halabyan St, Yerevan 0038")
                            .font(.footnote)
                            .foregroundStyle(.darkGray)
                    }
                    .padding()
                }
                ForEach(list, id: \.self) { restaurant in
                    Button(action: {
                        navigation.goTo(view: .restaurant(info: restaurant))
                    }, label: {
                        RestaurantPreview(restaurant: restaurant)
                    })
                }
            }
        }
        .padding(.horizontal)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
}
