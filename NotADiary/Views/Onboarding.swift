//
//  Onboarding.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI

struct Onboarding: View {
    @State var name: String = ""
    var body: some View {
        Text("Bem vindo ao NotADiary!")
        Text("Coloque o seu nome:")
        TextField("escreva aqui...", text: $name)
            .padding()
    }
}

#Preview {
    Onboarding()
}
