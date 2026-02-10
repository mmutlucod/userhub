//
//  UserListView.swift
//  userhub
//

import SwiftUI

struct UserListView: View {
    @State private var users: [User] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading users...")
                    .padding()
            } else if let error = errorMessage {
                VStack(spacing: 15) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    
                    Text("Error")
                        .font(.headline)
                    
                    Text(error)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Button("Retry") {
                        loadUsers()
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            } else {
                List(users) { user in
                    UserRowView(user: user)
                        .accessibilityIdentifier("userRow_\(user.id)")
                }
                .listStyle(PlainListStyle())
                .accessibilityIdentifier("userList")
            }
        }
        .navigationTitle("Users")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            loadUsers()
        }
    }
    
    private func loadUsers() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedUsers = try await APIService.shared.fetchUsers()
                
                await MainActor.run {
                    self.users = fetchedUsers
                    self.isLoading = false
                    
                    if let firstUser = fetchedUsers.first {
                        print("✅ İlk kullanıcı ID: \(firstUser.id)")
                        print("✅ İlk kullanıcı isim: \(firstUser.name)")
                    }
                    print("✅ Toplam kullanıcı sayısı: \(fetchedUsers.count)")
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                    print("API Hatası: \(error)")
                }
            }
        }
    }
}
#Preview {
    NavigationStack {
        UserListView()
    }
}
