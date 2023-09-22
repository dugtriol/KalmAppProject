import SwiftUI

struct PrimaryButton: View {
    var title: String
    var onClick: () -> ()
    var body: some View {
        Button {
            onClick()
        } label: {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("PrimaryColor"))
                .cornerRadius(50)
        }
    }
}
