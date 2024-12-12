//
//  Hero.swift
//  LittleLemon
//
//  Created by Doni Silva on 11/12/24.
//

import SwiftUI

struct Hero: View {
    
    private enum Constants {
        static let imageHeroMaxWidth: CGFloat = 120
        static let imageHeroMaxHeight: CGFloat = 140
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Little Lemon")
                        .foregroundColor(Color.primaryColor2)
                        .font(.custom("Markazi Text", size: 42).weight(.medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Chicago")
                        .foregroundColor(.white)
                        .font(.custom("Markazi Text", size: Metrics.large))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: Metrics.nano)
                    Text("""
                     We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                     """)
                    .foregroundColor(.white)
                    .font(.custom("Karla", size: 16).weight(.medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: Metrics.nano)
                }
                Image("hero-image")
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(maxWidth: Constants.imageHeroMaxWidth, maxHeight: Constants.imageHeroMaxHeight)
                    .clipShape(Rectangle())
                    .cornerRadius(Metrics.small)
            }
        }
    }
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
            .padding()
            .background(Color.primaryColor1)
            .frame(maxWidth: .infinity, maxHeight: 240)
    }
}
