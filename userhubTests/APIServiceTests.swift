//
//  APIServiceTests.swift
//  userhubTests
//

import XCTest
@testable import userhub

final class APIServiceTests: XCTestCase {
    
    var apiService: APIService!
    
    override func setUp() {
        super.setUp()
        apiService = APIService.shared
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }
    
    // MARK: - Login Tests
    
    func testLoginWithValidCredentials() async throws {
        let email = "test@example.com"
        let password = "123456"
        
        let result = try await apiService.login(email: email, password: password)
        
        XCTAssertTrue(result, "Login başarılı olmalı")
    }
    
    func testLoginWithInvalidCredentials() async throws {
        let email = "wrong@example.com"
        let password = "wrongpass"
        
        let result = try await apiService.login(email: email, password: password)
        
        XCTAssertFalse(result, "Login başarısız olmalı")
    }
    
    func testLoginWithInvalidEmail() async throws {
        // Arrange
        let email = "test@example.com"
        let password = "wrongpass"
        
        // Act
        let result = try await apiService.login(email: email, password: password)
        
        // Assert
        XCTAssertFalse(result, "Yanlış şifre ile login başarısız olmalı")
    }
    
    func testLoginWithInvalidPassword() async throws {
        // Arrange
        let email = "wrong@example.com"
        let password = "123456"
        
        // Act
        let result = try await apiService.login(email: email, password: password)
        
        // Assert
        XCTAssertFalse(result, "Yanlış email ile login başarısız olmalı")
    }
    
    // MARK: - Fetch Users Tests
    
    func testFetchUsersSuccess() async throws {
        // Act
        let users = try await apiService.fetchUsers()
        
        // Assert
        XCTAssertFalse(users.isEmpty, "Kullanıcı listesi boş olmamalı")
        XCTAssertGreaterThan(users.count, 0, "En az 1 kullanıcı olmalı")
        
        // İlk kullanıcı kontrolü
        if let firstUser = users.first {
            XCTAssertFalse(firstUser.name.isEmpty, "Kullanıcı adı boş olmamalı")
            XCTAssertFalse(firstUser.email.isEmpty, "Email boş olmamalı")
        }
    }
    
    func testFetchUsersReturnsValidData() async throws {
        // Act
        let users = try await apiService.fetchUsers()
        
        for user in users {
            XCTAssertNotNil(user.id, "User ID nil olmamalı")
            XCTAssertFalse(user.name.isEmpty, "İsim boş olmamalı")
            XCTAssertFalse(user.email.isEmpty, "Email boş olmamalı")
            XCTAssertTrue(user.email.contains("@"), "Email geçerli format olmalı")
        }
    }
    
    func testFetchUsersReturnsTenUsers() async throws {
        // Act
        let users = try await apiService.fetchUsers()
        
        XCTAssertEqual(users.count, 10, "API 10 kullanıcı döndürmeli")
    }
    
    // MARK: - Performance Tests
    
    func testLoginPerformance() {
        measure {
            let expectation = self.expectation(description: "Login performance")
            
            Task {
                _ = try? await apiService.login(email: "test@example.com", password: "123456")
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 5.0)
        }
    }
    
    func testFetchUsersPerformance() {
        measure {
            let expectation = self.expectation(description: "Fetch users performance")
            
            Task {
                _ = try? await apiService.fetchUsers()
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 10.0)
        }
    }
}
