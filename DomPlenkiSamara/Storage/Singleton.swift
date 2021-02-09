//
//  RecentItemsSingleton.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 21.01.2021.
//

import UIKit

class Singleton {
    static let shared = Singleton()
    private init(){}
    
    var user: User?
    
    var catalogueItems: [ShopItem] = []
    private var recents: [ShopItem] = []//change type to some model later
    private var favorites: [ShopItem] = []
    private var cartItems: [ShopItem] = [] {
        didSet {
            print("Cart items!!")
        }
    }
    private var actionItems: [ShopItem] = []
    
    func getItems(type: ItemType) -> [ShopItem] {
        switch type {
        case .recent:
            return recents
        case .favorite:
            return favorites
        case .cart:
            return cartItems
        case .action:
            return actionItems
        }
    }
    
    func recordItem(type: ItemType, item: ShopItem) {
        switch type {
        case .recent:
            recents.append(item)
        case .favorite:
            favorites.append(item)
        case .cart:
            cartItems.append(item)
        case .action:
            actionItems.append(item)
        }
    }
    
    func recordItems(type: ItemType, item: [ShopItem]) {
        switch type {
        case .recent:
            recents.append(contentsOf: item)
        case .favorite:
            favorites.append(contentsOf: item)
        case .cart:
            cartItems.append(contentsOf: item)
        case .action:
            actionItems.append(contentsOf: item)
        }
    }
    
    func removeItem(type: ItemType, position: Int) {
        switch type {
        case .recent:
            recents.remove(at: position)
        case .favorite:
            favorites.remove(at: position)
        case .cart:
            cartItems.remove(at: position)
        case .action:
            actionItems.remove(at: position)
        }
    }
    
    func replaceItem(type: ItemType, at position: Int, item: ShopItem) {
        switch type {
        case .recent:
            recents.remove(at: position)
            recents.insert(item, at: position)
        case .favorite:
            favorites.remove(at: position)
            favorites.insert(item, at: position)
        case .cart:
            cartItems.remove(at: position)
            cartItems.insert(item, at: position)
        case .action:
            actionItems.remove(at: position)
            actionItems.insert(item, at: position)
        }
    }
    
    
    
    enum ItemType {
        case recent, favorite, cart, action
    }
}

extension Singleton: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
