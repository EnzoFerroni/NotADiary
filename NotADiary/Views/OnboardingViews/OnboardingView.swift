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
        GeometryReader { g in
            NavigationStack {
                VStack {
                    Text("Como você gostaria de ser chamado?")
                        .font(.title3)
                        .bold()
                        .padding(.top, 50)
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: g.size.width * 0.95, height: 56)
                            .foregroundStyle(.inputBackground)
                            .overlay(
                                TextField("Nome..", text: $name)
                                    .padding(.leading, 16)
                            )
                    }
                    
                    Spacer()
                    
                    Button {
                        if !name.isEmpty {
                            //ckViewModel.createPreference(name: name)
                            isLoading = true
                            state = 1
                        }
                    } label: {
                        Text("Confirmar")
                            .padding(.horizontal, 70)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(50)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Cadastro")
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            NotificationView(isLoading: $isLoading, state: $state)
                        } label: {
                            Text("Salvar")
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    @Previewable @State var ckViewModel = CloudKitViewModel()
    @Previewable @State var isLoading = false
    @Previewable @State var state = 0
    OnboardingView(name: "", state: $state, isLoading: $isLoading)
        .environment(ckViewModel)
}
