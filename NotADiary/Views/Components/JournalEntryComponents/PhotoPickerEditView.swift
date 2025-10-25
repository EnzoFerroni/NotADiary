//
//  PhotoPickerView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerEditView: View {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    @State var pickerImage: PhotosPickerItem?
    @State var image: ImageModel
        
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerImage, matching: .images){
                Image(uiImage: image.image)
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
                image.image = inputImage
                await ckViewModel.editImageEntry(image: image)
                
            }
        }
    }
}
