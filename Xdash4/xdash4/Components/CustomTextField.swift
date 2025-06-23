//
//  CustomTextField.swift
//  Xtracta Dashboard
//
//  Created by Victor Reis on 15/04/2025.
//

import SwiftUI

// Componente reutilizável para campos de texto personalizados
// Utilizamos esse padrão para manter consistência no visual e reutilização em várias telas
struct CustomTextField: View {
    var placeholder: String          // Texto guia dentro do campo
    @Binding var text: String        // Binding permite que o valor se comunique com a View pai
    var isSecure: Bool               // Define se o campo deve ocultar o texto (senha)

    var body: some View {
        Group {
            if isSecure {
                // Campo de senha (oculta o texto digitado)
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground)) // Fundo adaptável ao tema do sistema
                    .cornerRadius(10) // Cantos arredondados (estilo moderno)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            } else {
                // Campo de texto comum (ex: email)
                TextField(placeholder, text: $text)
                    .keyboardType(.emailAddress) // Layout do teclado mais apropriado
                    .autocapitalization(.none)   // Evita que o sistema coloque a primeira letra em maiúscula
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            }
        }
    }
}
