import Foundation
import AarKay

let url = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .deletingLastPathComponent()

let options = AarKayOptions(
    force: true,
    verbose: true
)
AarKay(url: url, options: options).bootstrap()
