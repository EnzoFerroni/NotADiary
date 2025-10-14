//
//  Onboarding.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI

struct OnboardingView: View {
    @State var name: String = ""
    @Binding var state: Int
    @Binding var isLoading: Bool

    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    var body: some View {
        Text("Bem vindo ao NotADiary!")
        Text("Coloque o seu nome:")
        TextField("escreva aqui...", text: $name)
            .padding()
        Button {
            if !name.isEmpty {
                ckViewModel.createPreference(name: name)
                isLoading = true
                state = 1
            }
        } label: {
            Text("Confirmar")
        }
    }
}
