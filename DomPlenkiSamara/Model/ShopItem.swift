//
//  CollectionViewItem.swift
//  DomPlenkiSamara
//
//  Created by Emil Mescheryakov on 22.01.2021.
//

import UIKit

class ShopItem {
    
    var image: UIImage = UIImage(named: "noImage")!
    var name: String = "Test"
    var price: String? = "0"
    var actionPrice: String? = ""
    var description: String? = ""
    var properties: String? = ""
    var count: Int = 1
    var isFavorite: Bool = false
    var isSale: Bool = false
    var isInCart: Bool = false
    var isRecent: Bool = false
    
    convenience init(image: UIImage, name: String, price: String?, actionPrice: String?, description: String?, properties: String?, count: Int, isFavorite: Bool, isSale: Bool, isRecent: Bool) {
        self.init()
        self.image = image
        self.name = name
        self.price = price
        self.actionPrice = actionPrice
        self.description = description
        self.properties = properties
        self.count = count
        self.isFavorite = isFavorite
        self.isSale = isSale
        self.isRecent = isRecent
    }
}

extension ShopItem: Equatable {
    static func == (lhs: ShopItem, rhs: ShopItem) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price && lhs.actionPrice == lhs.actionPrice && lhs.description == rhs.description && lhs.isSale == rhs.isSale
    }
}

final class ItemsFactory {
    static func createItems() -> [ShopItem] {
        let first = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let second = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 2", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let third = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 3", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let fourth = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 4", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let fifth = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 5", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let first1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let second1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 2", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let third1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 3", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let fourth1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 4", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let fifth1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 5", price: "100", actionPrice: "", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: false, isRecent: false)
        let first2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая", price: "100", actionPrice: "90", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: true, isRecent: false)
        let second2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 2", price: "100", actionPrice: "90", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: true, isRecent: false)
        let third2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 3", price: "100", actionPrice: "90", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: true, isRecent: false)
        let fourth2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 4", price: "100", actionPrice: "90", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: true, isRecent: false)
        let fifth2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 5", price: "100", actionPrice: "90", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, isFavorite: false, isSale: true, isRecent: false)

        return [first, second, third, fourth, fifth, first1, second1, third1, fourth1, fifth1, first2, second2, third2, fourth2, fifth2]
    }
}
