import SwiftUI

public final class EmptyModel {
    public var uuid: UUID
    
    public init() {
        self.uuid = UUID()
    }
}

extension EmptyModel: EmptyModule { }
extension EmptyModel: EmptyRepresentable { }
