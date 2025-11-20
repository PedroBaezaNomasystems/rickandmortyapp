import SwiftUI
import Presentation

struct UrlImageView: View {
    private let representable: any UrlImageRepresentable
    
    init(representable: any UrlImageRepresentable) {
        self.representable = representable
    }
    
    var body: some View {
        UrlImage(url: representable.url)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
