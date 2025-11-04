//
//  ToolbarHomeScreenView.swift
//  NotADiary
//
//  Created by Francisco Losada on 10/10/25.
//

import SwiftUI

struct ToolbarHomeScreenView: View {
    //@Binding var toggleSheet: Bool
    
    var body: some View {
        Text("")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        //toggleSheet.toggle()
                        print("pessoinha")
                    } label: {
                        Image(systemName: "person.crop.circle")
                    }
                }
            }
    }
}

//#Preview {
//    ToolbarHomeScreenView()
//}
