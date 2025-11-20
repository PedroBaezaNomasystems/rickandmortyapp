import SwiftUI
import Presentation

struct EmptyView: View {
    private let representable: any EmptyRepresentable
    
    init(representable: any EmptyRepresentable) {
        self.representable = representable
    }
    
    var body: some View {
        SwiftUI.EmptyView()
    }
}
