import SwiftUI

struct SelectButton: View {
    var title: String
    var onClick: () -> ()
    
    var body: some View {
        Button {
            onClick()
        } label: {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .hAllign(.center)
                .padding(.top, 15)
                .padding(.bottom, 10)
                .foregroundColor(.white)
                .background{
                    Rectangle()
                        .fill(Color("PrimaryColor"))
                        .ignoresSafeArea()
                }
        }
        .padding([.bottom, .horizontal], -15)
    }
}
