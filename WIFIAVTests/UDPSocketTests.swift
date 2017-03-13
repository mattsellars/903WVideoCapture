//
//  UDPSocketTests.swift
//  WIFIAV
//
//  Created by Max Odnovolyk on 3/13/17.
//  Copyright © 2017 Max Odnovolyk. All rights reserved.
//

import XCTest
@testable import WIFIAV

class UDPSocketTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }
    
    func testNotListeningSocketGetsDeallocatedImmediately() {
        var socket: UDPSocket? = try! UDPSocket(port: 55000)
        weak var weakSocket = socket
        
        socket = nil
        
        XCTAssertNil(weakSocket)
    }
    
    func testListeningSocketGetsDeallocatedAfterShutdown() {
        var socket: UDPSocket? = try! UDPSocket(port: 55001)
        weak var weakSocket = socket
        
        socket?.listen()
        
        socket = nil
        
        XCTAssertNotNil(weakSocket)
        
        weakSocket?.shutdown()
        
        XCTAssertNil(weakSocket)
    }
}