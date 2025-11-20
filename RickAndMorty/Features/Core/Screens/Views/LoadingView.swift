import SwiftUI
import Presentation

struct LoadingView: View {
    private let representable: any LoadingRepresentable
    
    init(representable: any LoadingRepresentable) {
        self.representable = representable
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .mask(Color.black.opacity(0.2))
            
            ProgressView()
                .controlSize(.large)
                .tint(.customPalette.tertiary)
        }
        .onAppear {
            representable.onAppear()
        }
        .ignoresSafeArea()
    }
}
