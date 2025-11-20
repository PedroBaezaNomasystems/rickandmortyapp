import SwiftUI
import Presentation

struct TextView: View {
    private let representable: any TextRepresentable
    
    init(representable: any TextRepresentable) {
        self.representable = representable
    }
    
    var body: some View {
        Text(representable.text)
            .font(.openSansLight(size: .title))
    }
}
