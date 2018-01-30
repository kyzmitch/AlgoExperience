//
//  ParkingLotSystem.swift
//  ParkingLot
//
//  Created by admin on 24/01/2018.
//  Copyright © 2018 kyzmitch. All rights reserved.
//

import Foundation

enum CarSize {
    case small, usual, big
}

enum CarEngineType {
    case electric, combustion
}

protocol Parking {
    func park(on parkingLot: ParkingLot) -> Bool
    // if parking lot doesn't have place for specific size
    // the car can be parked on bigger place
    func leave(with permission: ParkingLotLeavePermission)
}

class ParkingLotCard {
    let identifier: UInt
    // Probably it is enough to have just name or id of parking lot
    // and not reference on it
    // let parkingLot: ParkingLot
    init(numberOfPlaceOnParkingLot: UInt) {
        identifier = numberOfPlaceOnParkingLot
    }
}

protocol ParkingPlace {
    var coordinates: (Double, Double) {get set}
}

class ParkingLotDocuments {
    let usedParkingLot: ParkingLot
    let card: ParkingLotCard? // optional because you could miss the card
    let timeOfEntry: Date
    init(parkingLot: ParkingLot, issuedCard: ParkingLotCard, entryTime: Date) {
        usedParkingLot = parkingLot
        card = issuedCard
        // probably it is ok to just create entry time right inside init
        // but not now
        timeOfEntry = entryTime
    }
}

struct ParkingLotPlace: ParkingPlace {
    // car can have some place/coordinates of stop
    // when it is parked on a road
    var coordinates: (Double, Double)
    // by one varibale you will know if you
    // inside parking lot or not
    var parkingLotDocuments: ParkingLotDocuments?
    init(location: (Double, Double), parkingLotDocs: ParkingLotDocuments? = nil) {
        coordinates = location
        parkingLotDocuments = parkingLotDocs
    }
}

// Actually this is too much design for car
// the main task is design for Parking Lot
enum CarState {
    case moving((Double, Double)?) // just moving = nil , or to destination
    case parked(ParkingLotPlace)
    case parking
}

class Car: Parking {
    let sizeType: CarSize
    let engineType: CarEngineType
    let governmentIssuedNumber: String // unique id could be used as a hash
    var state: CarState
    
    init(size: CarSize, engine: CarEngineType, giNumber: String) {
        sizeType = size
        engineType = engine
        governmentIssuedNumber = giNumber
        let placeForParking = ParkingLotPlace(location: (0.0, 0.0))
        state = .parked(placeForParking)
    }
    
    // Actually the main task is design of parking lot
    // so, we probably no need to think about actions
    // like parking of a car
    // we just need action like
    // - move car inside parking lot
    // - move out from the parking lot
    // - move to some specific place inside parking lot
    // and actual parking shoould be done by Parking lot class
    
    // BUT! at the same time each car
    // just need some method to change it's state
    // when car is going to park and it is near the enter to parking lot
    // need to set state to .parking
    // if there is not free place it should be moved to .moving
    // and in case of free place the state should be changed to .parked
    
    func park(on parkingLot: ParkingLot) -> Bool {
        state = .parking
        // better to use reference semantic for Car type
        // because it is passed to functions
        
        if let card = parkingLot.giveParkingLotCardForRandomFreePlace() {
            let documents = ParkingLotDocuments(parkingLot: parkingLot, issuedCard: card, entryTime: Date())
            let place = ParkingLotPlace(location: parkingLot.coordinatesInCity(), parkingLotDocs: documents)
            state = .parked(place)
            return true
        }
        else {
            state = .moving(nil)
            return false
        }
        
    }
    
    func leave(with permission: ParkingLotLeavePermission) {
        // payment should be done before leaving the parking lot
        // but it is responsibility of parking lot itself
        // so, that method should be called only after
        // successfull payment for parking
        
        // method leave should only work with permission from parking lot
        // lets assume it will be check for car government issues number
        
        // permission should be closed structure
        // to disallow implement fake permission without paying
        if permission.isItAllowedToLeave() {
            state = .moving(nil)
        }
        else {
            // TODO: handle solving of that case
        }
    }
}

struct ParkingLotLeavePermission {
    private let parkingLot: ParkingLot
    private let carIdentifier: String

    func isItAllowedToLeave() -> Bool {
        return parkingLot.checkPayments(foor: carIdentifier)
    }
}

protocol ParkingLot: class {
    func coordinatesInCity() -> (Double, Double)
    func giveParkingLotCardForRandomFreePlace() -> ParkingLotCard?
    func checkPayments(foor carNumber: String) -> Bool // enough for exit
    func letIn(_ theCar: Car) throws
    func letOut(_ theCar: Car) throws
}

// specific data structure to abstract from
// levels of parking (1 or n)
protocol ParkingPlaces {
    // let the parking place be just simple number
    // but it's possible to create a model for specific place
    func firstFreePlaceNumber() -> UInt?
}

struct OneLevelPlaces: ParkingPlaces {
    let array = Array<UInt>()
    func firstFreePlaceNumber() -> UInt? {
        // TODO: implement
        return 100
    }
}

class SpecificParkingLot: ParkingLot {
    // https://medium.com/swift-programming/keep-your-swift-exceptions-clean-easy-to-update-and-future-proof-20b997d0b46c
    
    let coordinates: (Double, Double)
    let places: ParkingPlaces
    
    init(parkingLotCityCoordinates: (Double, Double), placesModel: ParkingPlaces) {
        coordinates = parkingLotCityCoordinates
        places = placesModel
    }
    
    func giveParkingLotCardForRandomFreePlace() -> ParkingLotCard? {
        if let placeNumber = places.firstFreePlaceNumber() {
            let card = ParkingLotCard(numberOfPlaceOnParkingLot: placeNumber)
            return card
        }
        else {
            return nil
        }
    }
    
    func checkPayments(foor carNumber: String) -> Bool {
        return true // TODO: check government issues number in the list
    }
    
    func letIn(_ theCar: Car) throws {
        
    }
    
    func letOut(_ theCar: Car) throws {
        
    }
    
    func coordinatesInCity() -> (Double, Double) {
        return coordinates
    }
}
