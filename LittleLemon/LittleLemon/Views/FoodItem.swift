//
//  FoodItem.swift
//  LittleLemon
//
//  Created by Doni Silva on 11/12/24.
//

import SwiftUI

struct FoodItem: View {
    
    let dish:Dish
    
    var body: some View {
        HStack {
            VStack {
                Text(dish.title ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Karla", size: 16).weight(.heavy))
                    .foregroundColor(.black)
                Spacer(minLength: Metrics.little)
                Text(dish.descriptionDish ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Karla", size: 14))
                    .foregroundColor(.primaryColor1)
                    .lineLimit(Int(Metrics.pico))
                Spacer(minLength: Metrics.nano)
                Text("$" + (dish.price ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Karla", size: 14).weight(.medium))
                    .foregroundColor(.primaryColor1)
                    .monospaced()
            }
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: Metrics.squareFrame, maxHeight: Metrics.squareFrame)
            .clipShape(Rectangle())
        }
        .padding(.vertical)
        .frame(maxHeight: Metrics.imageFrame)
    }
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItem(dish: PersistenceController.oneDish())
    }
    
}
