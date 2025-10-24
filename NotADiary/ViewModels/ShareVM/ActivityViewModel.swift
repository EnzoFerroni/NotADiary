//
//  ActivityViewController.swift
//  NotADiary
//
//  Created by Vinicius Alves Marques on 06/10/25.
//

import SwiftUI

struct ActivityViewModel: UIViewControllerRepresentable {
@Binding var activityItems: [Any]
    var excludedActivityTypes: [UIActivity.ActivityType]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewModel>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems,
                                                  applicationActivities: nil)
        
        controller.excludedActivityTypes = excludedActivityTypes
        
        return controller
    }
func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewModel>) {}
}
