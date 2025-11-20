import SwiftUI
import Presentation

struct CellLoadingView: View {
    private let representable: any CellLoadingRepresentable
    
    init(representable: any CellLoadingRepresentable) {
        self.representable = representable
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            ProgressView()
                .controlSize(.large)
                .tint(.customPalette.tertiary)
            
            Spacer()
        }
        .onAppear {
            representable.onStart()
        }
    }
}
