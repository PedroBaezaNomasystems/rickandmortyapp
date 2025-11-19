import SwiftUI
import Presentation

struct ErrorView: View {
    @StateObject private var dataSource: ErrorDataSource
    private let representable: any ErrorRepresentable
    
    init(representable: any ErrorRepresentable) {
        self._dataSource = StateObject(wrappedValue: representable.errorDataSource)
        self.representable = representable
    }
    
    var body: some View {
        VStack {
            Text(dataSource.error)
                .font(.openSansBold(size: .title))
            
            Button(action: { representable.onRetry() }) {
                Text("common_error_retry")
                    .font(.openSansRegular(size: .body))
            }
        }
    }
}
