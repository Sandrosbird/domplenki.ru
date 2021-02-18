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
    
    private var catalogueItems: [ShopItem] = []
    private var shoppingCart: [ShopItem] = []
    
    func getItems(type: ItemType) -> [ShopItem] {
        var items: [ShopItem] = []
        switch type {
        case .recent:
            for item in catalogueItems {
                if item.isRecent {
                    items.append(item)
                }
            }
            return items
        case .favorite:
            for item in catalogueItems {
                if item.isFavorite {
                    items.append(item)
                }
            }
            return items
        case .cart:
            for item in catalogueItems {
                if item.isInCart {
                    items.append(item)
                }
            }
            return items
        case .action:
            for item in catalogueItems {
                if item.isSale {
                    items.append(item)
                }
            }
            return items
        case .catalogue:
            return catalogueItems
        }
    }
    
    func changeItemFlag(type: ItemType, for item: ShopItem) {
        switch type {
        case .action:
            if item.isSale {
                item.isSale = false
            } else {
                item.isSale = true
            }
        case .cart:
            if item.isInCart {
                item.isInCart = false
            } else {
                item.isInCart = true
            }
        case .catalogue:
            break
        case .favorite:
            if item.isFavorite {
                item.isFavorite = false
            } else {
                item.isFavorite = true
            }
        case .recent:
            if item.isRecent {
                item.isRecent = false
            } else {
                item.isRecent = true
            }
        }
    }
    
    func checkCatalogueForEmptiness() -> Bool {
        catalogueItems.isEmpty
    }
    
    func fillCatalogue() {
        catalogueItems = ItemsFactory.createItems()
    }
    
    func addToCart(item: ShopItem) {
        shoppingCart.append(item)
    }
    
    func checkInCart(item: ShopItem) -> (Bool, Int?) {
        guard let i = shoppingCart.firstIndex(of: item)?.distance(to: 0) else { return (false, nil) }
        if shoppingCart.contains(item) {
            return (true, i)
        } else {
            return (false, i)
        }
    }
    
    func removeFromCart(index: Int?) {
        if index != nil {
            shoppingCart.remove(at: index!)
        }
    }
    
    func removeAllFromCart() {
        shoppingCart.removeAll()
    }
    
    enum ItemType {
        case recent, favorite, cart, action, catalogue
    }
}

extension Singleton: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
