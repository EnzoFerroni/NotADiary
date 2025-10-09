//
//  ShareSheetModifer.swift
//  NotADiary
//
//  Created by Vinicius Alves Marques on 06/10/25.
//
import SwiftUI

struct ShareSheetModifer: ViewModifier {
    @State private var showShareSheet: Bool = false
    @State var shareSheetItems: [Any] = []
    
    func body(content: Content) -> some View {
        content
            //.contextMenu {
                Button(action: {
                    self.showShareSheet.toggle()
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            //}
            .sheet(isPresented: $showShareSheet, content: {
                ActivityViewModel(activityItems: self.$shareSheetItems)
            })
    }
}

extension View {
    func shareSheet(items: [Any], excludedActivityTypes: [UIActivity.ActivityType]? = nil) -> some View {
        self.modifier(ShareSheetModifer(shareSheetItems: items))
    }
}
