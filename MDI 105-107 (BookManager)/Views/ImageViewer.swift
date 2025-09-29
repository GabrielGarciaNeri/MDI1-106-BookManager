//
//  ImageViewer.swift
//  MDI 105-107 (BookManager)
//
//  Created by Jr . on 9/27/25.
//

import SwiftUI
import SwiftData

struct ImageViewer: View {
    @Query var images: [UploadedImage]
    var body: some View {
        NavigationStack{
            if(images.isEmpty){
                Text("No images found")
            } else {
                List(images, id: \.id){ image in
                    Image(
                        uiImage: UIImage(data: (image.imageData as Data?)!)
                        ?? UIImage(resource: .defaultBook)
                    )
                    .resizable()
                    .frame(width: 100, height: 100)
                    
                }
                .navigationTitle("Images")
            }
            
        }
    }
}
