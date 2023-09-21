//
//  SignUpView.swift
//  KalmAppFront
//
//  Created by Айгуль Манджиева on 21.09.2023.
//

import SwiftUI

struct SignUpView: View {
    @Binding var showSignUp: Bool
    @Binding var showCategoryList: Bool
    @State private var name: String = ""
    @State private var login: String = ""
    @State private var password: String = ""
    @Binding var user: User?
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                VStack {
                    Spacer()
                    Text("Регистрация")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    VStack {
                        HStack {
                            Image(systemName: "face.smiling")
                                .font(.title2)
                                .foregroundColor(Color("PrimaryColor"))
                                .frame(width: 40)
                            TextField("Имя", text: $name)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        HStack {
                            Image(systemName: "person")
                                .font(.title2)
                                .foregroundColor(Color("PrimaryColor"))
                                .frame(width: 40)
                            TextField("Логин", text: $login)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                        HStack {
                            Image(systemName: "lock")
                                .font(.title2)
                                .foregroundColor(Color("PrimaryColor"))
                                .frame(width: 40)
                            SecureField("Пароль", text: $password)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(50)
                    }
                    .padding()
    
                    PrimaryButton(title: "Продолжить", onClick: {
                        Task {
                            do {
                                self.user = try await NetworkService.shared.registerUser(name: name, login: login, password: password)
                                showCategoryList.toggle()
                                
                            } catch {
                                print("error EmployeeSignInView \(login) \(password)")
                            }
                        }
                    })
                    Spacer()
                }
                .vAllign(.center)
            }
            .padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
