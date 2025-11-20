import SwiftUI

public final class UrlImageModel {
    public var uuid: UUID
    public var url: String
    
    public init(url: String) {
        self.uuid = UUID()
        self.url = url
    }
}

extension UrlImageModel: UrlImageModule { }
extension UrlImageModel: UrlImageRepresentable { }
