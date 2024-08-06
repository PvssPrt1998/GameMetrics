import Foundation
import Combine

final class WebViewModel: ObservableObject {
    var isLoaderVisible = PassthroughSubject<Bool, Never>();
}
