//
//  Registration.swift
//  HotelManzana
//
//  Created by ronny abraham on 12/13/17.
//  Copyright © 2017 ronny abraham. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    
    var price: Int
    
    static var all: [RoomType] {
        return [
            RoomType(id: 0, name: "Classy", shortName: "cs", price: 108),
            RoomType(id: 1, name: "Candy Room", shortName: "pedo", price: 1),
            RoomType(id: 2, name: "King Size", shortName: "king", price: 300)
        ]
    }
}

// Equatable Protocol Implementation for RoomType

func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.id == rhs.id
}
