//
//  EntryView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import SwiftUI
import CloudKit

struct SaveDetails: Identifiable {
    let name: String
    let error: String
    let id = UUID()
}

struct EntryView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var details: SaveDetails?
    
    @StateObject var viewModel = EntryViewModel()
    
    @State private var ckViewModel = CloudKitViewModel()
    
    @State private var isLoading: Bool = true
    @State private var wasClicked: Bool = false
    @State private var showingAlert: Bool = false
    @State private var isLoadingLocal: Bool = false
    
    @State private var state: Int = 0
    
    @ViewBuilder func loadingView() -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .primary))
            .scaleEffect(2.0, anchor: .center)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isLoading = false
                }
            }
    }
    
    var body: some View {
        if isLoading {
            loadingView()
        }
        else {
            if state == 0 {
                NavigationStack {
                    VStack {
                        Text("Já tem uma conta ou deseja criar uma?")
                            .font(.title2)
                        
                        HStack {
                            Button {
                                if ckViewModel.isLogged {
                                    showingAlert = true
                                }
                                else {
                                    state = 1
                                    isLoading = true
                                }
                            } label: {
                                Text("Já tenho")
                            }
                            .buttonStyle(.bordered)
                            .alert("Já possui conta", isPresented: $showingAlert) {
                                Button("OK", role: .confirm) {}
                            } message: {
                                Text("Você já possui uma conta no NotADiary, tente entrar na sua conta!")
                            }
                            
                            Button {
                                state = 2
                                isLoading = true
                            } label: {
                                Text("Ainda não tenho")
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .navigationTitle("Boas vindas")
                }
            }
            else if state == 1 {
                if isLoading {
                    loadingView()
                }
                else {
                    ContentView()
                }
            }
            else if state == 2 {
                if isLoading {
                    loadingView()
                }
                else {
                    // Próxima View
                }
            }
        }
    }
}


#Preview {
    EntryView()
}
