import Foundation
import AarKay

let url = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

if let aarkay = AarKay(url: url) { aarkay.bootstrap(force: true) }
