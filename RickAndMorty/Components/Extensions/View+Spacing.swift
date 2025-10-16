//
//  View+Spacing.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 16/10/25.
//

import SwiftUI

extension HStack {
    
    init(spacing: Theme.Spacing, @ViewBuilder content: () -> Content) {
        
        self.init(spacing: spacing.rawValue, content: content)
    }
    
    init(alignment: VerticalAlignment, spacing: Theme.Spacing, @ViewBuilder content: () -> Content) {
        
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

extension VStack {
    
    init(spacing: Theme.Spacing, @ViewBuilder content: () -> Content) {
        
        self.init(spacing: spacing.rawValue, content: content)
    }
    
    init(alignment: HorizontalAlignment, spacing: Theme.Spacing, @ViewBuilder content: () -> Content) {
        
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

extension View {
    
    func padding(_ edge: Edge.Set, _ spacing: Theme.Spacing) -> some View {
        
        return padding(edge, spacing.rawValue)
    }
}
