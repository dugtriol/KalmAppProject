import SwiftUI

struct SelectButton: View {
    @Binding var isSelected: Bool
    @State var color: Color
    @State var text: String
    
    var body: some View {
        ZStack {
            Capsule()
                .frame( height: 50)
                .foregroundColor(isSelected ? color : Color.orange.opacity(0.4))
            Text(text)
                .foregroundColor(.white)
        }
    }
}

struct SelectButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectButton(isSelected: .constant(false),color: .blue, text: "Press me")
    }
}
