//
//  EntryView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import SwiftUI
import CloudKit

struct EntryView: View {
    @StateObject var viewModel = EntryViewModel()
    
    @State private var ckViewModel = CloudKitViewModel()
    
    var body: some View {
        if ckViewModel.isLogged {
            VStack {
                Text("Oi, \(ckViewModel.preference?.name ?? "") você está logado!!!!")
            }
        } else {
            Form {
                Text("opa, parece que você não está logado")
                    .font(.title2)
                
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
                .disabled(viewModel.isSignedInToiCloud.description.uppercased() == "TRUE" ? false : true)
            }
        }
    }
}

#Preview {
    EntryView()
}
