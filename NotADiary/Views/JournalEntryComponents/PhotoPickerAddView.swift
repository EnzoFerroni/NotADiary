//
//  PhotoPickerView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerAddView: View {
    @State var pickerImage: [PhotosPickerItem] = []
    
    @Binding var image: [UIImage]
    
    var isEdit: Bool
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerImage, matching: .images){
                Label("Adicione uma foto", systemImage: "photo")
            }
            
            ForEach (image, id: \.self) { images in
                if !image.isEmpty && isEdit {
                    Image(uiImage: images)
                        .resizable()
                        .frame(width: 240.0, height: 236)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .scaledToFill()
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

