//
//  PhotoPickerEmptyEditView.swift
//  NotADiary
//
//  Created by Francisco Losada on 27/10/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerEmptyEditView: View {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    @State var pickerImage: [PhotosPickerItem] = []
    @State var image: [UIImage] = []
    @State var haptics1: Bool = false

    let entry: JournalEntry
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
                if !image.isEmpty {
                    Image(uiImage: images)
                        .resizable()
                        .frame(width: 240.0, height: 236)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .scaledToFill()
                }
            }
        }
        .onChange(of: pickerImage) {
            Task {
                for item in pickerImage {
                    guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
                    guard let inputImage = UIImage(data: imageData) else { return
                    }
                    image.append(inputImage)
                }
            }
        }
        .onDisappear() {
            ckViewModel.createImageEntry(entry: entry, images: image)
        }
    }
}
