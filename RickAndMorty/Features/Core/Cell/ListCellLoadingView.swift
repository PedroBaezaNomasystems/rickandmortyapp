import SwiftUI
import Presentation

struct ListCellLoadingView: View {
    private let representable: any ListCellLoadingRepresentable
    
    init(representable: any ListCellLoadingRepresentable) {
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
