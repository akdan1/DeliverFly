//
//  FoodView.swift
//  Deliver fly
//
//  Created by user on 6/24/24.
//

import SwiftUI

struct FoodView: View {
    @Environment (\.dismiss) private var dismiss
    @State private var selectedIngredients: [Ingredient] = []
    @State private var quantity: Int = 1
    private var total: Double {
        food.price*Double(quantity)
    }
    let food: Food
    
    var body: some View {
        VStack {
            ScrollView {
                image
                VStack(alignment: .leading) {
                    title
                    description
                    if !food.ingredients.isEmpty {
                        subtitle
                        ingredientsList
                    }
                }
                .padding()
            }
            Group {
                Divider()
                HStack {
                    totalPrice
                    Spacer()
                    itemQuantity
                }
                addToCart
            }
            .padding(.horizontal)
        }
    }
    
    var image: some View {
        Image(food.image)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipShape(.rect(topLeadingRadius: 0, bottomLeadingRadius: 30, bottomTrailingRadius: 30, topTrailingRadius: 0))
    }
    
    var title: some View {
        Text(food.name)
            .font(.title2)
            .bold()
            .foregroundStyle(.darkBlue)
    }
    
    var description: some View {
        Text(food.description)
            .font(.subheadline)
            .lineSpacing(10)
            .foregroundStyle(.gray)
            .padding(.top, 5)
            .lineLimit(2)
    }
    
    var subtitle: some View {
        Text("INGREDIENTS")
            .font(.footnote)
            .fontWeight(.light)
            .kerning(1.0)
            .padding(.vertical, 10)
    }
    
    var ingredientsList: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 50), alignment: .top)], content: {
            ForEach(food.ingredients, id: \.self) { ingredient in
                Button(action: {
                    ingredientTapped(ingredient)
                }, label: {
                    ingredientButton(ingredient)
                })
                
            }
        })
    }
    
    @ViewBuilder func ingredientButton(_ ingredient: Ingredient) -> some View {
        VStack {
            Image(ingredient.rawValue)
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .foregroundStyle(isSelected(ingredient) ? .lightOrange : .darkOrange)
                .background(isSelected(ingredient) ? .darkOrange : .lightOrange)
                .clipShape(Circle())
            Text(ingredient.rawValue)
                .font(.footnote)
                .foregroundStyle(.darkGray)
        }
        .padding(.bottom)
    }
    
    func isSelected(_ ingredient: Ingredient) -> Bool {
        selectedIngredients.contains { $0 == ingredient }
    }
    
    func ingredientTapped(_ ingredient: Ingredient) {
        if selectedIngredients.contains(where: {$0 == ingredient}) {
            selectedIngredients.removeAll { $0 == ingredient }
        } else if selectedIngredients.count < 3 {
            selectedIngredients.append(ingredient)
        }
    }
    
    var totalPrice: some View {
        Text(total, format: .currency(code: "USD"))
            .font(.title)
            .fontWeight(.medium)
            .padding(.vertical, 10)
    }
    
    var itemQuantity: some View {
        Group {
            Button(action: {
                minusTapped()
            }, label: {
                Text("-")
                    .bold()
                    .foregroundStyle(.darkGray)
                    .frame(width: 25, height: 25)
                    .background(.lightGray)
                    .clipShape(Circle())
            })
            Text("\(quantity)")
                .bold()
                .padding(.horizontal)
            Button(action: {
                plusTapped()
            }, label: {
                Text("+")
                    .bold()
                    .foregroundStyle(.darkGray)
                    .frame(width: 25, height: 25)
                    .background(.lightGray)
                    .clipShape(Circle())
            })
        }
    }
    
    func minusTapped(){
        if quantity > 0 {
            quantity -= 1
        }
    }
    
    func plusTapped(){
        if quantity < 10 {
            quantity += 1
        }
    }
    
    var addToCart: some View {
        Button(action: {
            dismiss()
        }, label: {
            Text("Add to Cart".uppercased())
                .bold()
                .frame(maxWidth: .infinity, minHeight: 60)
                .foregroundStyle(quantity == 0 ? .gray : .white)
                .background(quantity == 0 ? .lightGray :
                        .darkOrange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
        .disabled(quantity == 0)
    }
    
}


#Preview {
    FoodView(food: .doubleDouble)
}
