import SwiftUI

struct CategoryCell: View {
    var category: Category
    
    var body: some View {
        HStack {
            Image(systemName: "flame")
                .resizable()
                .frame(width: 70, height: 70)
                .aspectRatio(contentMode: .fill)
                .clipShape(Rectangle())
            VStack (alignment: .leading, spacing: 5){
                Text(category.titleRussian)
                Text(category.titleKalmyk)
            }.bold()
            Spacer()
        }
    }
}

struct LessonCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCell(category: Category(id: UUID().uuidString, titleRussian: "Приветствие", titleKalmyk: "Менд", image: "pencil"))
    }
}
