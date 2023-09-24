import SwiftUI

struct SignUpView: View {
    @Binding var showSignUp: Bool
    @Binding var showCategoryList: Bool
    @State private var name: String = ""
    @State private var login: String = ""
    @State private var password: String = ""
    @Binding var user: User?
    @State var showAlert: Bool = false
    
    @Environment(\.dismiss) private var dismiss
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
//                                showCategoryList.toggle()
                                dismiss()
                            } catch {
                                showAlert.toggle()
                                print("error EmployeeSignInView \(login) \(password)")
                            }
                        }
                    })
                    .alert(isPresented: $showAlert, content:{
                        Alert(title: Text("Этот логин занят, попробуйте другой"))
                    })
                    Spacer()
                }
                .vAllign(.center)
            }
            .padding()
        }
    }
}
