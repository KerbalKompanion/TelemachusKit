import XCTest
import TelemachusKit

final class ConnectionTests: XCTestCase {
    let ip: String = "0.0.0.0"
    let port: Int = 8085
    func testConnect() {
        let expect = expectation(description: "Connected Successfully")
        let sm = TelemachusClient()
        sm.onConnect = {
            expect.fulfill()
        }
        sm.connect(self.ip, self.port)
        
        wait(for: [expect], timeout: 20.0)
    }

    static var allTests = [
        ("Test Connection", testConnect),
    ]
}
