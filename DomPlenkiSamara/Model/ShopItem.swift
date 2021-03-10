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
    var price1: String? = "0" //m2 roznica
    var price2: String? = "0" //m2 opt
    var price3: String? = "0" //pog.m roznica
    var price4: String? = "0" //pog.m opt
    var description: String? = ""
    var properties: String? = ""
    var count: Int = 1
    var priceTypeFlag: Bool = true
    var isFavorite: Bool = false
    var isSale: Bool = false
    var isInCart: Bool = false
    var isRecent: Bool = false
    
    convenience init(image: UIImage, name: String, price1: String?, price2: String?, price3: String?, price4: String?, description: String?, properties: String?, count: Int, priceTypeFlag: Bool, isFavorite: Bool, isSale: Bool, isInCart: Bool, isRecent: Bool) {
        self.init()
        self.image = image
        self.name = name
        self.price1 = price1
        self.price2 = price2
        self.price3 = price3
        self.price4 = price4
        self.description = description
        self.properties = properties
        self.count = count
        self.priceTypeFlag = priceTypeFlag
        self.isFavorite = isFavorite
        self.isSale = isSale
        self.isInCart = isInCart
        self.isRecent = isRecent
    }
}

extension ShopItem: Equatable {
    static func == (lhs: ShopItem, rhs: ShopItem) -> Bool {
        return lhs.name == rhs.name && lhs.price1 == rhs.price1 && lhs.price2 == lhs.price2 && lhs.description == rhs.description && lhs.isSale == rhs.isSale
    }
}

final class ItemsFactory {
    static func createItems() -> [ShopItem] {
        let first = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон. Цена за рулон.", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let second = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 2", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let third = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 3", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let fourth = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 4", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let fifth = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 5", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let first1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let second1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 2", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let third1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 3", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let fourth1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 4", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let fifth1 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 5", price1: "100", price2: "200", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: false, isInCart: false, isRecent: false)
        let first2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая", price1: "80", price2: "100", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: true, isInCart: false, isRecent: false)
        let second2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 2", price1: "80", price2: "100", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: true, isInCart: false, isRecent: false)
        let third2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 3", price1: "80", price2: "100", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: true, isInCart: false, isRecent: false)
        let fourth2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 4", price1: "80", price2: "100", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: true, isInCart: false, isRecent: false)
        let fifth2 = ShopItem(image: UIImage(named: "testImg")!, name: "Пленка полиэтиленовая 5", price1: "80", price2: "100", price3: "50", price4: "40", description: "Пленка полиэтиленова техническая", properties: "Цена за рулон", count: 1, priceTypeFlag: true, isFavorite: false, isSale: true, isInCart: false, isRecent: false)

        return [first, second, third, fourth, fifth, first1, second1, third1, fourth1, fifth1, first2, second2, third2, fourth2, fifth2]
    }
}
