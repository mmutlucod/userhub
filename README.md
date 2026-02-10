# UserHub - iOS Test Automation Project

## About The Project

UserHub is a modern iOS application built with SwiftUI that demonstrates professional mobile development and comprehensive test automation practices. The project showcases a complete authentication system with user management, backed by extensive automated testing including unit tests, integration tests, and UI tests. Built using clean architecture principles and modern Swift concurrency patterns, this application serves as a portfolio piece demonstrating real-world iOS development skills with a focus on quality assurance and test-driven development.

The application integrates with JSONPlaceholder REST API to fetch and display user data, implements form validation with real-time feedback, and includes proper error handling and loading states. With 22 automated tests achieving 100% pass rate, the project demonstrates industry-standard testing practices including XCTest for unit testing, XCUITest for UI automation, async/await testing patterns, and proper test isolation with setUp/tearDown lifecycle management.

## Features

The application includes a complete login system with email and password validation, providing real-time error feedback and secure credential handling through a mock authentication service. Users can authenticate with test credentials (test@example.com / 123456) and navigate to a user management screen that fetches data from a real REST API.

The user list view displays fetched users with avatar initials, names, emails, and phone numbers in a clean, scrollable interface. It includes proper loading states with progress indicators, comprehensive error handling with retry functionality, and smooth navigation transitions between screens.

The testing suite covers all critical functionality with 8 unit tests for validation logic (email format, password requirements, edge cases), 8 integration tests for API services (authentication, network requests, JSON decoding, performance benchmarks), and 6 UI tests covering the complete user flow (successful login, validation errors, navigation, system popup handling).

Additional features include modern SwiftUI declarative UI design, async/await for network operations, accessibility identifier support for UI testing, screenshot capture on test failures, and handling of iOS system popups like password autofill prompts during automated testing.
