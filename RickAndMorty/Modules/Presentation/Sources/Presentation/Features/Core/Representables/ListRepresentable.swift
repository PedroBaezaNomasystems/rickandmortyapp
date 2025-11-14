import Combine
import Foundation

public protocol ListRepresentable {
    var cells: Published<[any Module]>.Publisher { get }
    func refresh()
}
