//
//  ImageField.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/27/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ImageField: View {
    @Binding var image: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
            PhotosPicker(
                selection: $photosPickerItem,
                matching: .images,
                photoLibrary: .shared()
            ){
                Image(uiImage: image ?? UIImage(resource: .defaultBook))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            }
            .onChange(of: photosPickerItem) { _, _ in
                Task{
                    if let photosPickerItem,
                       let image = try? await photosPickerItem.loadTransferable(type: Data.self){
                        if let image = UIImage(data: image) {
                            self.image = image
                        }
                    }
                        
                }
            }
    }
}
