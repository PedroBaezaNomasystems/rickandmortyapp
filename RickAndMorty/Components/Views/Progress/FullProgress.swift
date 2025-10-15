//
//  FullProgress.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 15/10/25.
//

import SwiftUI

struct FullProgress: View {
    
    var body: some View {

        ZStack {
            Rectangle()
                .mask(Color.black.opacity(0.1))
            ProgressView()
                .controlSize(.large)
                .tint(.customPalette.secondary)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    
    FullProgress()
}
