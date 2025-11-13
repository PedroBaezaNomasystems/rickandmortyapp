//
//  CharacterListRenderer.swift
//  RickAndMorty
//
//  Created by Pedro Juan Baeza Gómez on 12/11/25.
//

import SwiftUI

protocol Renderer {
    func render(module: any Module) -> AnyView
}

struct CharacterListRenderer {
    
}

extension CharacterListRenderer: Renderer {
    func render(module: any Module) -> AnyView {
        switch module {
        case (let character as CharacterViewRepresentable):
            AnyView(
                HStack {
                    UrlImage(
                        url: character.image,
                        width: 60,
                        height: 60
                    )
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.openSansBold(size: .title))
                        
                        Text(character.status)
                            .font(.openSansRegular(size: .label))
                    }
                }
                .onTapGesture {
                    character.onTapCharacter()
                }
                .onAppear {
                    character.onAppearCharacter()
                }
            )
        default:
            AnyView(EmptyView())
        }
    }
}
