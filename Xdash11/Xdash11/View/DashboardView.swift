//
//  DashboardView.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 25/04/2025.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var session = UserSession.shared

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Bem-vindo, \(session.userName)!")
                    .font(.title)
                    .padding()

                Button("Sair") {
                    session.isLoggedIn = false
                }
                .foregroundColor(.red)
            }
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardView()
}
