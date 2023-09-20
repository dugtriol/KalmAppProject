//
//  SignInScreenView.swift
//  login
//
//  Created by Abu Anwar MD Abdullah on 23/4/21.
//

import SwiftUI

struct SignInScreenView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                VStack {
                    Spacer()
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    

                    HStack {
                        Image(systemName: "envelope")
                            .font(.title2)
                            .foregroundColor(.black)
                            .frame(width: 40)
                        TextField("Логин", text: $login)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(50)

                    HStack {
                        Image(systemName: "lock")
                            .font(.title2)
                            .foregroundColor(.black)
                            .frame(width: 40)
                        SecureField("Пароль", text: $password)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(50)
                    .padding(.bottom, 50)
                    PrimaryButton(title: "Email me a signup link")
                    Spacer()
                        
                }
                .vAllign(.center)
                
                HStack(spacing: 6) {
                    Text("Нет аккаунта?")
                        .foregroundColor(Color("TitleTextColor"))
                    
                    Button(action: {}, label:{
                        Text("Зарегистрируйтесь")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("PrimaryColor"))
                    })
                }
                .padding(.vertical)
                
            }
            .padding()
        }
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView()
    }
}


struct SocalLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        HStack {
            image
                .padding(.horizontal)
            Spacer()
            text
                .font(.title2)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
    }
}
