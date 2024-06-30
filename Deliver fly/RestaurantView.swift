//
//  RestaurantView.swift
//  Deliver fly
//
//  Created by user on 6/17/24.
//

import SwiftUI

struct RestaurantView: View {
    let restaurant: Restaurant
    @State private var selectedFood: Food?
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                HStack{
                    Button(action: {
                        navigation.goBack()
                    }, label: {
                        Image(.backArrow)
                            .frame(width: 50, height: 50)
                            .background(.lightGray)
                            .clipShape(Circle())
                            .padding(.trailing)
                    })
                    Text("Restaurant")
                    Spacer()
                }
                Image(restaurant.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius:15))
                    .padding(.vertical)
                    .allowsHitTesting(false)
                Text(restaurant.name)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.darkBlue)
                    .padding(.vertical, 5)
                Text(restaurant.description)
                    .font(.subheadline)
                    .lineSpacing(10)
                    .foregroundStyle(.gray)
                Text("Menu")
                    .font(.title)
                    .padding(.vertical)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], content: {
                    ForEach(restaurant.foods, id:\.self) { food in
                        Button(action: {
                            selectedFood = food
                        }, label: {
                            FoodPreview(food: food)
                                .frame(height: 200)
                        })
                    }
                })
            }
            .padding(.horizontal)
        }
        .sheet(item: $selectedFood) { item in
            foodView(item)
        }
    }
    
    @ViewBuilder func foodView(_ item: Food) -> some View {
        FoodView(food: item)
            .presentationDetents(item.ingredients.isEmpty ? [.fraction(0.63)] : [.fraction(0.93)])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(30)
    }
}

#Preview {
    RestaurantView(restaurant: .inNOut)
}
