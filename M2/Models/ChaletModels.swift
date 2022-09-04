//
//  ChaletModels.swift
//  M2
//
//  Created by Mohammad Alfauri on 04/09/2022.
//

import Foundation

struct ChaletModel: Codable {
    var response: [Product]?
}

struct Product: Codable {
    var categoryName: String?
    var products: [ProductDetails]?
}

struct ProductDetails: Codable {
    var name: String?
    var imageName: String?
    var price: String?
    var description: String?
}
