//
//  PhotoPickerView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @State var pickerImage: PhotosPickerItem?
    
    @Binding var image: UIImage?
    
    var isEdit: Bool
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerImage, matching: .images){
                Label("Adicione uma foto", systemImage: "photo")
            }
            
            if image != nil && isEdit {
                Image(uiImage: image!)
                    .resizable()
                    .frame(width: 240.0, height: 236)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .scaledToFill()
            }
        }
        .onChange(of: pickerImage) { oldValue, newValue in
            Task {
                guard let imageData = try await pickerImage?.loadTransferable(type: Data.self) else { return }
                guard let inputImage = UIImage(data: imageData) else { return }
                image = inputImage
            }
        }
    }
}
