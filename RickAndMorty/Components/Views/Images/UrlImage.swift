//
//  ImageUrl.swift
//  UrlImage
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import SwiftUI
import Kingfisher

struct UrlImage: View {
    let url: String?
    let placeholder: Image
    let width: CGFloat?
    let height: CGFloat?
    let contentMode: SwiftUI.ContentMode
    let showProgress: Bool
    
    @State private var isLoading = false
    
    init(
        url: String?,
        placeholder: Image = SystemIcon.photo.image,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        contentMode: SwiftUI.ContentMode = .fill,
        showProgress: Bool = true
    ) {
        self.url = url
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.contentMode = contentMode
        self.showProgress = showProgress
    }
    
    var body: some View {
        ZStack {
            if let urlString = url, let url = URL(string: urlString) {
                KFImage(url)
                    .onProgress { receivedSize, totalSize in
                        isLoading = totalSize > 0 && receivedSize < totalSize
                    }
                    .onSuccess { result in
                        isLoading = false
                    }
                    .onFailure { error in
                        isLoading = false
                    }
                    .placeholder {
                        placeholderView
                    }
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: width, height: height)
            } else {
                placeholderView
            }
        }
    }
    
    private var placeholderView: some View {
        ZStack {
            placeholder
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray.opacity(0.3))
                .frame(width: width, height: height)
            
            if showProgress && isLoading {
                ProgressView()
                    .tint(.customPalette.tertiary)
            }
        }
    }
}

extension UrlImage {
    init(_ url: String?, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.init(
            url: url,
            width: width,
            height: height
        )
    }
}
