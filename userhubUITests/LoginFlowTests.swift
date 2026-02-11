//
//  LoginFlowTests.swift
//  userhubUITests
//

import XCTest

final class LoginFlowTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    // MARK: - Successful Login Tests
    
    func testSuccessfulLogin() {
        // Arrange
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        
        // Act
        emailTextField.tap()
        emailTextField.typeText("test@example.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        
        loginButton.tap()
        
        let notNowButton = app.buttons["Not Now"]
        if notNowButton.waitForExistence(timeout: 3) {
            notNowButton.tap()
            print("✅ Şifre kaydetme popup'ı kapatıldı")
        }
        
        sleep(3)
        
        let usersNavBar = app.navigationBars["Users"]
        XCTAssertTrue(usersNavBar.waitForExistence(timeout: 10), "Users sayfası açılmadı!")
        sleep(2)
        let cellCount = app.cells.count
        XCTAssertGreaterThan(cellCount, 0, "Hiç kullanıcı yok!")
    }
    
    // MARK: - Negative Login Tests
    
    func testLoginWithEmptyEmail() {
        // Arrange
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        let errorLabel = app.staticTexts["errorLabel"]
        
        // Act
        passwordTextField.tap()
        passwordTextField.typeText("password123")
        loginButton.tap()
        
        // Assert
        XCTAssertTrue(errorLabel.exists)
        XCTAssertEqual(errorLabel.label, "Email cannot be empty")
    }
    
    func testLoginWithInvalidEmail() {
        // Arrange
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        let errorLabel = app.staticTexts["errorLabel"]
        
        // Act
        emailTextField.tap()
        emailTextField.typeText("invalidemail")
        
        passwordTextField.tap()
        passwordTextField.typeText("password123")
        
        loginButton.tap()
        
        // Assert
        XCTAssertTrue(errorLabel.exists)
        XCTAssertEqual(errorLabel.label, "Invalid email format")
    }
    
    func testLoginWithEmptyPassword() {
        // Arrange
        let emailTextField = app.textFields["emailTextField"]
        let loginButton = app.buttons["loginButton"]
        let errorLabel = app.staticTexts["errorLabel"]
        
        // Act
        emailTextField.tap()
        emailTextField.typeText("test@example.com")
        loginButton.tap()
        
        // Assert
        XCTAssertTrue(errorLabel.exists)
        XCTAssertEqual(errorLabel.label, "Password cannot be empty")
    }
    
    func testLoginWithShortPassword() {
        // Arrange
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        let errorLabel = app.staticTexts["errorLabel"]
        
        // Act
        emailTextField.tap()
        emailTextField.typeText("test@example.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("123")
        
        loginButton.tap()
        
        // Assert
        XCTAssertTrue(errorLabel.exists)
        XCTAssertEqual(errorLabel.label, "Password must be at least 6 characters")
    }
    
    func testLoginWithWrongCredentials() {
        // Arrange
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        let errorLabel = app.staticTexts["errorLabel"]
        
        // Act
        emailTextField.tap()
        emailTextField.typeText("wrong@example.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("wrongpassword")
        
        loginButton.tap()
        
        // Assert
        XCTAssertTrue(errorLabel.waitForExistence(timeout: 5))
    }
}
