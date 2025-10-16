//
//  ListProgress.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import SwiftUI

struct ListProgress: View {
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            ProgressView()
                .controlSize(.large)
                .tint(.customPalette.tertiary)
            
            Spacer()
        }
    }
}

#Preview {
    
    ListProgress()
}
