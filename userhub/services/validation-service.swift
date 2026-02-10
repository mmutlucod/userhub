//
//  ValidationService.swift
//  userhub
//

import Foundation

class ValidationService {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    func validateLogin(email: String, password: String) -> (isValid: Bool, error: String?) {
        guard !email.isEmpty else {
            return (false, "Email cannot be empty")
        }
        
        guard isValidEmail(email) else {
            return (false, "Invalid email format")
        }
        
        guard !password.isEmpty else {
            return (false, "Password cannot be empty")
        }
        
        guard isValidPassword(password) else {
            return (false, "Password must be at least 6 characters")
        }
        
        return (true, nil)
    }
}
