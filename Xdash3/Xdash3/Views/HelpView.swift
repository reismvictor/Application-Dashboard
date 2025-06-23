//
//  HelpView.swift
//  Xtracta Dashboard3
//
//  Created by Victor Reis on 01/04/2025.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack {
            Text("Help Information")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle("Help")
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
