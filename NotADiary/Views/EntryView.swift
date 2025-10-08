//
//  EntryView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import SwiftUI
import CloudKit

struct EntryView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = EntryViewModel()
    
    @State private var ckViewModel = CloudKitViewModel()
    
    @State private var isLoading: Bool = true
    @State private var wasClicked: Bool = false
    
    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                .scaleEffect(2.0, anchor: .center)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isLoading = false
                    }
                }
        } else {
            if viewModel.isSignedInToiCloud.description.uppercased() != "FALSE" {
                ZStack {
                    Form {
                        Text("Opa, parece que você não está logado")
                            .font(.title)
                        
                        LabeledContent {
                            TextField("", text: $ckViewModel.name)
                        } label: {
                            Text("Digite seu nome:")
                        }
                        
                        Button {
                            if !ckViewModel.name.isEmpty {
                                ckViewModel.loginButtonPressed()
                                wasClicked = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    dismiss()
                                }
                            }
                        } label: {
                            Text("Cadastrar")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(wasClicked)
                    }
                    if wasClicked {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                            .scaleEffect(2.0, anchor: .center)
                    }
                }
            }
            else {
                VStack {
                    Text("Infelizmente você não está logado em uma conta do iCloud")
                        .font(.title)
                    Text("Vá para as configurações do celular, clique em iCloud e faça seu login!")
                        .font(.title2)
                }
            }
        }
    }
}

#Preview {
    EntryView()
}
