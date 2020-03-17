import XCTest
import TelemachusKit

final class ConnectionTests: XCTestCase {
    let ip: String = "192.168.178.23"
    let port: Int = 8085
    func testConnect() {
        let expect = expectation(description: "Connected Successfully")
        let sm = TelemachusClient(.debug)
        sm.onTelemachusData = { (data: TelemachusData) in
            print(data.gameStatus)
            if data.gameStatus != .error {
                expect.fulfill()
            }
        }
        
        sm.connect(self.ip, self.port) { result in
            switch result {
                case .success: sm.subscribeTo(TelemachusClient.ApiKey.allCases)
                case .failure(let error): print(error)
            }
            
        }
        
        wait(for: [expect], timeout: 120.0)
    }

    static var allTests = [
        ("Test Connection", testConnect),
    ]
}
