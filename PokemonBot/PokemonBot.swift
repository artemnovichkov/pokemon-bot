//
//  PokemonBot.swift
//  PokemonBot
//
//  Created by Artem Novichkov on 17.07.16.
//  Copyright © 2016 Artem Novichkov. All rights reserved.
//

import Foundation
import SlackKit

let botName = "pokemonbot"

class PokemonBot: MessageEventsDelegate {
    
    var client: Client
    private let factory = PokemonFactory()
    
    init(token: String) {
        client = Client(apiToken: token)
        client.messageEventsDelegate = self
    }
    
    // MARK: - Methods
    
    private func listen(message: Message) {
        if let text = message.text, userID = message.user {
            let user = client.users[userID]!
            let botUser = client.authenticatedUser!
            guard user.id != botUser.id else {
                return
            }
            if let pokemon = factory.pokemonByName(text) {
                sendCaughtPokemon(pokemon, user: user)
            } else {
                sendError(user.id!)
            }
        }
    }
    
    private func sendCaughtPokemon(pokemon: Pokemon, user: User) {
        let name = user.profile!.realName!
        let text = "\(name) поймал \(pokemon.type.rawValue)! Лови его прямо в офисе!\n\(pokemon.imageLink)"
        for channel in client.channels.values {
            if let isMember = channel.isMember, name = channel.name {
                if isMember {
                    sendMessage(name, text: text)
                }
            }
        }
    }
    
    private func sendError(userID: String) {
        let text = "Похоже, я не знаю такого покемона"
        sendMessage(userID, text: text)
    }
    
    private func sendMessage(channel: String, text: String) {
        client.webAPI.sendMessage(channel, text: text, username: botName, asUser: true, parse: .None, linkNames: true, attachments: nil, unfurlLinks: true, unfurlMedia: true, iconURL: nil, iconEmoji: nil, success: { (_: (ts: String?, channel: String?)) in
            
        }) { (error) in
            
        }
    }
    
    // MARK: - MessageEventsDelegate
    
    func messageSent(message: Message) {}
    
    func messageReceived(message: Message) {
        listen(message)
    }
    
    func messageChanged(message: Message) {}
    func messageDeleted(message: Message?) {}
}