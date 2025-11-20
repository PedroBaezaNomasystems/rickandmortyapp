import SwiftUI
import Presentation

struct CharacterCellView: View {
    private let representable: any CharacterCellRepresentable
    
    init(representable: any CharacterCellRepresentable) {
        self.representable = representable
    }
    
    var body: some View {
        HStack {
            UrlImage(
                url: representable.image,
                width: 60,
                height: 60
            )
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            
            VStack(alignment: .leading) {
                Text(representable.name)
                    .font(.openSansBold(size: .title))
                
                Text(representable.status)
                    .font(.openSansRegular(size: .label))
            }
        }
        .onTapGesture {
            representable.onTapCharacter()
        }
    }
}
