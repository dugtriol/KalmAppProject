import SwiftUI

extension DictionaryView {
    @ViewBuilder
    func WordView(_ option: String, _ tint: Color) -> some View {
        Text(option)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .hAllign(.center)
            .vAllign(.center)
            .background(tint == Color("PrimaryColor") ? tint.opacity(0.1) : tint.opacity(0.75))
    }
}
