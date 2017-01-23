//
//  BotCache.swift
//  shortbot
//
//  Created by Marko Hlebar on 23/01/2017.
//  Copyright © 2017 Shivkanth B. All rights reserved.
//

import Foundation

class BotCache {
    let defaults: UserDefaults

    init(with defaults: UserDefaults) {
        self.defaults = defaults
    }

    func addBot(with name:String, url: URL) {
        var bots = allBots
        bots.append(Bot(name: name, url:url))
        save(bots)
    }

    var allBots: [Bot] {
        //get JSON from defaults and deserialize it to [Bot] array
        //also think about how to not make this deserialze every time it's called, by having a "dirty" bool for instance
        if let botsJSON = defaults.data(forKey: BotCache.botsKey),
            let jsonDict = try? JSONSerialization.jsonObject(with: botsJSON, options: .allowFragments) {
        }

        //Temporary until serialization works
        return [
            Bot(name: "Bot1", url: URL(string: "http://www.google.com")!),
            Bot(name: "Bot2", url: URL(string: "http://www.google.com")!),
            Bot(name: "Bot3", url: URL(string: "http://www.google.com")!),
            Bot(name: "Bot4", url: URL(string: "http://www.google.com")!)
        ]
    }
}

//Everything in here is private to this swift file and is not part of the public interface
fileprivate extension BotCache {

    static let botsKey = "com.shivkanth.shortbot.bots.key"

    func save(_ bots:[Bot]) {
        //Implement saving, probably the best way would be to JSON serialize the array into a string, and then just save it into UserDeaults
        let botsJSON = serialize(bots)

        defaults.set(botsJSON, forKey: BotCache.botsKey)
        defaults.synchronize()
    }

    func serialize(_ bots:[Bot]) -> String {
        return "JSON"
    }
}
