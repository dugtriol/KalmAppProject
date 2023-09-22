import SwiftUI

extension LessonView {
    @ViewBuilder
    func OptionView(_ option: Word, _ tint: Color, _ method: Int) -> some View {
        if method == 2 {
            Image(option.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Rectangle())
                .hAllign(.center)
                .background{
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(tint.opacity(0.55))
                        .background{
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(tint.opacity(tint == .white ? 0.85 : 1), lineWidth: 2)
                        }
                }
        }
        else {
            Text(method == 0 ? option.kalmyk : option.russian)
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .hAllign(.leading)
                .background {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(tint.opacity(0.45))
                        .background {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(tint.opacity(tint == .white ? 0.85 : 1), lineWidth: 2)
                        }
                }
        }
    }
}
