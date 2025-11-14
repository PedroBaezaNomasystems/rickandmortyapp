import Combine
import Foundation

public protocol ListRepresentable {
    var cellsPublisher: Published<[any Module]>.Publisher { get }
    func refresh()
}
