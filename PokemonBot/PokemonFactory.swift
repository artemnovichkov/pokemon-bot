//
//  PokemonFactory.swift
//  PokemonBot
//
//  Created by Artem Novichkov on 23.07.16.
//  Copyright © 2016 Artem Novichkov. All rights reserved.
//

import Foundation

enum Pokedex: String {
    case Bulbasaur
    case Ivysaur
    case Venasaur
    case Charmander
    case Charmeleon
    case Charizard
    case Squirtle
    case Wartortle
    case Blastoise
    case Caterpie
}

struct PokemonFactory {
    
    private let pokemons = PokemonFactory.generatePokemons()
    
    func pokemonByName(name: String) -> Pokemon? {
        return pokemons.filter { name.containsString($0.type.rawValue) }.first
    }
    
    private static func generatePokemons() -> [Pokemon] {
        var pokemons = [Pokemon]()
        if let filePath = NSBundle.mainBundle().pathForResource("PokemonList", ofType: "plist") {
            let array = NSArray(contentsOfFile: filePath) as! [Dictionary<String, String>]
            pokemons = PokemonMapper.pokemonsFromArray(array)
        }
        return pokemons
    }
}