import SwiftUI

public protocol Module: Identifiable {
    var uuid: UUID { get }
}
