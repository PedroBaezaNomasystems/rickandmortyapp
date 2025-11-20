import SwiftUI
import Domain
import Combine
import Presentation

struct ScrollView: View {
    @StateObject private var dataSource: ScrollDataSource
    private let representable: any ScrollRepresentable
    private let moduleRenderer: Renderer
    
    init(representable: any ScrollRepresentable, moduleRenderer: Renderer) {
        self._dataSource = StateObject(wrappedValue: representable.scrollDataSource)
        self.representable = representable
        self.moduleRenderer = moduleRenderer
    }
    
    var body: some View {
        SwiftUI.ScrollView {
            ForEach(dataSource.modules, id: \.uuid) {
                moduleRenderer.render(module: $0)
            }
        }
        .refreshable {
            representable.onRefresh()
        }
        .onAppear {
            representable.onAppear()
        }
    }
}
