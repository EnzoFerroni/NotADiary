//
//  PhotoPickerView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerAddView: View {
    @Binding var image: [UIImage]

    @State var pickerImage: [PhotosPickerItem] = []
    @State var haptics1: Bool = false
        
    var isEdit: Bool
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerImage, matching: .images){
                Label("Adicione uma foto", systemImage: "photo")
                    .onTapGesture {
                        haptics1.toggle()
                    }
            }
            .sensoryFeedback(.selection, trigger: haptics1)
            
            ForEach (image, id: \.self) { images in
                if !image.isEmpty && isEdit {
                    Image(uiImage: images)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 246)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .clipped()
                }
            }
        }
        .onChange(of: pickerImage) { oldValue, newValue in
            Task {
                for item in pickerImage {
                    guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
                    guard let inputImage = UIImage(data: imageData) else { return }
                    image.append(inputImage)
                }
            }
        }
    }
}

