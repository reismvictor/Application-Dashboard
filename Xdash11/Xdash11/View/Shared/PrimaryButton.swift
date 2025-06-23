//
//  PrimaryButton.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 25/04/2025.
//


import SwiftUI

struct PrimaryButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}
