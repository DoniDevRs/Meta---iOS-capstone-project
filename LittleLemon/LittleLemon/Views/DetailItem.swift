//
//  DetailItem.swift
//  LittleLemon
//
//  Created by Doni Silva on 11/12/24.
//

import SwiftUI

struct DetailItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let dish: Dish
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .clipShape(Rectangle())
            .frame(minHeight: Metrics.imageFrame)
            Text(dish.title ?? "")
                .font(.custom("Markazi Text", size: Metrics.large))
                .foregroundColor(.primaryColor1)
            Spacer(minLength: Metrics.padding)
            Text(dish.descriptionDish ?? "")
                .font(.custom("Markazi Text", size: 18))
            Spacer(minLength: Metrics.little)
            Text("$" + (dish.price ?? ""))
                .font(.custom("Karla", size: 14).weight(.medium))
                .foregroundColor(.primaryColor1)
                .monospaced()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
}

struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItem(dish: PersistenceController.oneDish())
    }
}
