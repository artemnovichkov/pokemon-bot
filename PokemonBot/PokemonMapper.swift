//
//  PokemonMapper.swift
//  PokemonBot
//
//  Created by Artem Novichkov on 23.07.16.
//  Copyright © 2016 Artem Novichkov. All rights reserved.
//

import Foundation

let kType = "type"
let kImageLink = "imageLink"

struct PokemonMapper {
    
    static func pokemonsFromArray(array: [Dictionary<String, String>]) -> [Pokemon] {
        var pokemons = [Pokemon]()
        for dictionary in array {
            if let type = dictionary[kType], imageLink = dictionary[kImageLink] {
                let pokemon = Pokemon(type: Pokedex(rawValue: type)!, imageLink: imageLink)
                pokemons.append(pokemon)
            }
        }
        return pokemons
    }
}