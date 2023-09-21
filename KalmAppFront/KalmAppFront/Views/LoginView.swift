import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var modelData: ModelData
    @Binding var showSignUp: Bool
    @Binding var showCategoryList: Bool
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
                    Text("Вход")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)

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
                    .padding(.bottom, 50)
                    PrimaryButton(title: "Продолжить", onClick: {
                        Task {
                            do {
                                self.user = try await NetworkService.shared.auth(login: login, password: password)
                                showCategoryList.toggle()
                                
                            } catch {
                                print("error LoginView \(login) \(password)")
                            }
                        }
                    })
                    Spacer()
                }
                .vAllign(.center)
                
                HStack(spacing: 6) {
                    Text("Нет аккаунта?")
                        .foregroundColor(Color("TitleTextColor"))
                        .opacity(0.44)
                    
                    Button(action: {
                        showSignUp.toggle()
                    }, label:{
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
        ContentView()
    }
}

