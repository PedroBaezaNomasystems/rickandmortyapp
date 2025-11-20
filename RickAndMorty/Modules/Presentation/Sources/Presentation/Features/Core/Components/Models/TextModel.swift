import SwiftUI

public final class TextModel {
    public var uuid: UUID
    public var text: String
    
    public init(text: String) {
        self.uuid = UUID()
        self.text = text
    }
}

extension TextModel: TextModule { }
extension TextModel: TextRepresentable { }
