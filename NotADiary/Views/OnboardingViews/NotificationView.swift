//
//  NotificationView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 04/11/25.
//

import SwiftUI

struct NotificationView: View {
    @Binding var isLoading: Bool
    @Binding var state: Int
    @State var isShowingSheet: Bool = false
    @State var notifications: [Notifications] = []
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var isSelecting: Bool = false
    
    var body: some View {
        GeometryReader { g in
            NavigationStack {
                VStack {
                    ForEach(notifications, id:\.self) { notification in
                        //SingleNotificationView(hour: notification)
                    }
                    .onDelete { indexSet in
                        notifications.remove(atOffsets: indexSet)
                    }
                    
                    Spacer()
                    Button {
                        isShowingSheet = true
                    } label: {
                        Text("Adicionar horário")
                            .frame(width: g.size.width * 0.80)
                        
                    }
                    .buttonStyle(.borderedProminent)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Me lembre às")
                    }
                    
                    ToolbarItem {
                        Button {
                            
                        } label: {
                            Text("Salvar")
                        }
                    }
                }
                .sheet(isPresented: $isShowingSheet) {
                    NavigationStack {
                        VStack {
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: g.size.width * 0.9, height: 50)
                                        .foregroundStyle(.accent)
                                        .onTapGesture {
                                            isSelecting = true
                                        }
                                    
                                    HStack {
                                        Image(systemName: "clock")
                                            .padding(.leading, 35)
                                        
                                        Text("Horário")
                                        Spacer()
                                    }
                                }
                                
                                if isSelecting {
                                    HStack {
                                        Picker("", selection: $hours){
                                            ForEach(0..<24, id: \.self) { i in
                                                Text("\(i) horas").tag(i)
                                            }
                                        }.pickerStyle(WheelPickerStyle())
                                        Picker("", selection: $minutes){
                                            ForEach(0..<60, id: \.self) { i in
                                                Text("\(i) minutos").tag(i)
                                            }
                                        }.pickerStyle(WheelPickerStyle())
                                        
                                    }.padding(.horizontal)
                                    Spacer()
                                }
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Lembretes")
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    //notifications.append()
                                } label: {
                                    Text("Salvar")
                                }
                            }
                            ToolbarItem(placement: .topBarLeading) {
                                Button {
                                    isShowingSheet = false
                                } label: {
                                    Image(systemName: "xmark")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var isLoading: Bool = false
    @Previewable @State var state: Int = 0
    NotificationView(isLoading: $isLoading, state: $state)
}
