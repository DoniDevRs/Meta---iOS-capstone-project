//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Doni Silva on 11/12/24.
//

import SwiftUI

struct UserProfile: View {
    
    private enum Constants {
        static let imageMaxHeight: CGFloat = 75
    }
    
    @StateObject private var viewModel = ViewModel()
    
    @Environment(\.presentationMode) var presentation
    
    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var isLoggedOut = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { }
            VStack(spacing: Metrics.nano) {
                VStack {
                    Text("Avatar")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.primaryColor1)
                        .font(.custom("Karla-Bold", size: 13))
                    HStack(spacing: .zero) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(maxHeight: Constants.imageMaxHeight)
                            .clipShape(Circle())
                            .padding(.trailing)
                        Button("Change") { }
                            .buttonStyle(ButtonStylePrimaryColor1())
                        Button("Remove") { }
                            .buttonStyle(ButtonStylePrimaryColorReverse())
                        Spacer()
                    }
                }
                
                VStack{
                    Text("First name")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.primaryColor1)
                        .font(.custom("Karla-Bold", size: 13))
                    TextField("First Name", text: $firstName)
                }
                
                VStack {
                    Text("Last name")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.primaryColor1)
                        .font(.custom("Karla-Bold", size: 13))
                    TextField("Last Name", text: $lastName)
                }
                
                VStack {
                    Text("E-mail")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.primaryColor1)
                        .font(.custom("Karla-Bold", size: 13))
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                }
                
                VStack {
                    Text("Phone number")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.primaryColor1)
                        .font(.custom("Karla-Bold", size: 13))
                    TextField("Phone number", text: $phoneNumber)
                        .keyboardType(.default)
                }
            }
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            .padding()
            
            Text("Email notifications")
                .font(.custom("Markazi Text", size: 18))
                .foregroundColor(.primaryColor1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack(spacing: 15) {
                Checkbox(toggle: self.$orderStatuses, text: "Order statuses")
                Checkbox(toggle: self.$passwordChanges, text: "Password changes")
                Checkbox(toggle: self.$specialOffers, text: "Special offers")
                Checkbox(toggle: self.$newsletter, text: "Newsletter")
            }
            .padding()
            .font(.custom("Karla", size: 16).weight(.medium))
            .foregroundColor(.primaryColor1)
            
            Button("Log out") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                UserDefaults.standard.set("", forKey: kPhoneNumber)
                UserDefaults.standard.set(false, forKey: kOrderStatuses)
                UserDefaults.standard.set(false, forKey: kPasswordChanges)
                UserDefaults.standard.set(false, forKey: kSpecialOffers)
                UserDefaults.standard.set(false, forKey: kNewsletter)
                isLoggedOut = true
            }
            .buttonStyle(ButtonStyleYellowColorWide())
            Spacer(minLength: Metrics.padding)
            HStack {
                Button("Discard Changes") {
                    firstName = viewModel.firstName
                    lastName = viewModel.lastName
                    email = viewModel.email
                    phoneNumber = viewModel.phoneNumber
                    
                    orderStatuses = viewModel.orderStatuses
                    passwordChanges = viewModel.passwordChanges
                    specialOffers = viewModel.specialOffers
                    newsletter = viewModel.newsletter
                    self.presentation.wrappedValue.dismiss()
                }
                    .buttonStyle(ButtonStylePrimaryColorReverse())
                Button("Save changes") {
                    if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                        UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                        UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                        UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                        UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                    .buttonStyle(ButtonStylePrimaryColor1())
            }
            if viewModel.errorMessageShow {
                withAnimation() {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
            
        }
        .onAppear {
            firstName = viewModel.firstName
            lastName = viewModel.lastName
            email = viewModel.email
            phoneNumber = viewModel.phoneNumber
            
            orderStatuses = viewModel.orderStatuses
            passwordChanges = viewModel.passwordChanges
            specialOffers = viewModel.specialOffers
            newsletter = viewModel.newsletter
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

struct Checkbox: View {
    @Binding var toggle: Bool
    var text: String
    var body: some View {
        Button(action: {
            self.toggle.toggle()
        }) {
            Image(self.toggle ? "checkbox-on" :  "checkbox-off")
                .renderingMode(.original)
                .resizable()
                .padding(0)
                .frame(width: 18.0, height: 18.0)
                .background(Color(.white))
            Text(text).padding(0)
        }
        .buttonStyle(PlainButtonStyle())
        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.02))
        .cornerRadius(0)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
