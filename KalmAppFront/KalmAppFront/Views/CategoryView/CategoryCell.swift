import SwiftUI

struct CategoryCell: View {
    var category: Category
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: category.image), scale: 20)
                //.resizable()
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
        CategoryCell(category: Category(id: UUID().uuidString, titleRussian: "Приветствие", titleKalmyk: "Менд", image: "https://images.unsplash.com/photo-1425082661705-1834bfd09dca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2952&q=80"))
    }
}
