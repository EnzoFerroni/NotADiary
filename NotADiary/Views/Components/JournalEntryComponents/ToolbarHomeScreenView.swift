//
//  ToolbarHomeScreenView.swift
//  NotADiary
//
//  Created by Francisco Losada on 10/10/25.
//

import SwiftUI

struct ToolbarHomeScreenView: View {
    @Binding var toggleSheet: Bool
    @Binding var teste: String
    
    var body: some View {
        Text("")
            .toolbar {
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        toggleSheet.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .searchable(text: $teste)
    }
}

//#Preview {
//    ToolbarHomeScreenView()
//}
