//
//  main.swift
//  PokemonBot
//
//  Created by Artem Novichkov on 17.07.16.
//  Copyright © 2016 Artem Novichkov. All rights reserved.
//ONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import SlackKit

let pokemonBot = PokemonBot(token: "SLACK_API_TOKEN")
pokemonBot.client.connect()
NSRunLoop.mainRunLoop().run()