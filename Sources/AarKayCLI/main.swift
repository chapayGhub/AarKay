import Foundation
import AarKay

let url = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

AarKay(url: url).bootstrap(force: true)
