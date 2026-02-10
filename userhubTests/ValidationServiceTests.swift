//
//  ValidationServiceTests.swift
//  userhubTests
//

import XCTest
@testable import userhub

final class ValidationServiceTests: XCTestCase {
    
    var validationService: ValidationService!
    
    override func setUp() {
        super.setUp()
        validationService = ValidationService()
    }
    
    override func tearDown() {
        validationService = nil
        super.tearDown()
    }
    
    // MARK: - Email Validation Tests
    
    func testValidEmail() {
        XCTAssertTrue(validationService.isValidEmail("test@example.com"))
        XCTAssertTrue(validationService.isValidEmail("user.name@domain.co.uk"))
    }
    
    func testInvalidEmailWithoutAt() {
        XCTAssertFalse(validationService.isValidEmail("testexample.com"))
    }
    
    func testInvalidEmailWithoutDomain() {
        XCTAssertFalse(validationService.isValidEmail("test@"))
    }
    
    func testEmptyEmail() {
        XCTAssertFalse(validationService.isValidEmail(""))
    }
    
    func testInvalidEmailWithSpaces() {
        XCTAssertFalse(validationService.isValidEmail("test @example.com"))
    }
    
    // MARK: - Password Validation Tests
    
    func testValidPassword() {
        XCTAssertTrue(validationService.isValidPassword("123456"))
        XCTAssertTrue(validationService.isValidPassword("verylongpassword"))
    }
    
    func testInvalidShortPassword() {
        XCTAssertFalse(validationService.isValidPassword("12345"))
        XCTAssertFalse(validationService.isValidPassword("abc"))
    }
    
    func testEmptyPassword() {
        XCTAssertFalse(validationService.isValidPassword(""))
    }
    
    // MARK: - Login Validation Tests
    
    func testSuccessfulLoginValidation() {
        let result = validationService.validateLogin(
            email: "test@example.com",
            password: "password123"
        )
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
    
    func testLoginWithEmptyEmail() {
        let result = validationService.validateLogin(email: "", password: "password123")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, "Email cannot be empty")
    }
    
    func testLoginWithInvalidEmail() {
        let result = validationService.validateLogin(email: "invalidemail", password: "password123")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, "Invalid email format")
    }
    
    func testLoginWithEmptyPassword() {
        let result = validationService.validateLogin(email: "test@example.com", password: "")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, "Password cannot be empty")
    }
    
    func testLoginWithShortPassword() {
        let result = validationService.validateLogin(email: "test@example.com", password: "123")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, "Password must be at least 6 characters")
    }
}
