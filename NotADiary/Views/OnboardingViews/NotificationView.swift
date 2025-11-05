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
    var name: String
    @State var isShowingSheet: Bool = false
    @State var notifications: [Notifications] = []
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var isSelecting: Bool = false
    
    @State var viewModel = NotificationViewModel()
    
    //@Environment(CloudKitViewModel.self) var ckViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(notifications, id:\.self) { notification in
                        SingleNotificationView(notification: notification)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    .onDelete { indexSet in
                        notifications.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.plain)
                
                Spacer()
                Button {
                    isShowingSheet = true
                } label: {
                    Text("Adicionar horário")
                        .frame(width: 200)
                    
                }
                .buttonStyle(.borderedProminent)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Me lembre às")
                }
                
                ToolbarItem {
                    Button {
                        if !notifications.isEmpty && name != "" {
                            notifications.forEach { notification in
                                viewModel.scheduleNotification(hour: Int(notification.hour) ?? 0, minute: Int(notification.minute) ?? 0)
                                //ckViewModel.createPreference(name: name)
                            }
                            state = 1
                            isLoading = true
                        }
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
                                    .frame(width: 240, height: 50)
                                    .foregroundStyle(.accent)
                                    .onTapGesture {
                                        isSelecting = true
                                    }
                                    .overlay {
                                        HStack {
                                            Image(systemName: "clock")
                                                .padding(.leading)
                                            
                                            Text("Horário")
                                            Spacer()
                                        }
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
                                notifications.append(Notifications(hour: String(hours), minute: String(minutes)))
                                isShowingSheet = false
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
        .onAppear {
            //viewModel.requestPermission()
        }
    }
}

#Preview {
    @Previewable @State var isLoading: Bool = false
    @Previewable @State var state: Int = 0
    NotificationView(isLoading: $isLoading, state: $state, name: "Pedro")
}
