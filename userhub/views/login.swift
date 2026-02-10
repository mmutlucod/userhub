//
//  LoginView.swift
//  userhub
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var isLoggedIn = false
    
    private let validationService = ValidationService()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("UserHub")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .accessibilityIdentifier("emailTextField")
                }
                .padding(.horizontal, 30)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .accessibilityIdentifier("passwordTextField")
                }
                .padding(.horizontal, 30)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .accessibilityIdentifier("errorLabel")
                }
                
                Button(action: handleLogin) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Login")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 30)
                .padding(.top, 10)
                .disabled(isLoading)
                .accessibilityIdentifier("loginButton")
                
                Text("Use: test@example.com / 123456")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                
                Spacer()
                
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                UserListView()
            }
        }
    }
    
    private func handleLogin() {
        errorMessage = ""
        
        let validation = validationService.validateLogin(email: email, password: password)
        
        if !validation.isValid {
            errorMessage = validation.error ?? "Validation failed"
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let success = try await APIService.shared.login(email: email, password: password)
                
                await MainActor.run {
                    isLoading = false
                    
                    if success {
                        isLoggedIn = true
                    } else {
                        errorMessage = "Invalid credentials"
                    }
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = "Login failed: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
