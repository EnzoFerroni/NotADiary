//
//  SingleNotificationView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 04/11/25.
//

import SwiftUI

struct SingleNotificationView: View {
    @State var notification: Notifications
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 360, height: 70)
                    .foregroundStyle(.notification)
                VStack(alignment: .trailing) {
                    Text("\(notification.hour):\(notification.minute)")
                    Text("Notificação padrão do sistema")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var notifications = Notifications(hour: "10", minute: "23")
    SingleNotificationView(notification: notifications)
}

