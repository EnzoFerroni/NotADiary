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
    
    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2.0, anchor: .center)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        isLoading = false
                    }
                }
        } else {
            NavigationStack {
                if ckViewModel.isLogged {
                    VStack {
                        Text("Oi, \(ckViewModel.preference?.name ?? "") você está logado!!!!")
                            .font(.title)
                        Button {
                            
                        } label: {
                            Text("Entrar")
                        }
                    }
                }
                else {
                    if viewModel.isSignedInToiCloud.description.uppercased() != "FALSE" {
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
                                }
                            } label: {
                                Text("Cadastrar")
                            }
                            .buttonStyle(.borderedProminent)
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
    }
}

#Preview {
    EntryView()
}
