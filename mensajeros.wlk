class Courier {
    var property weight
    var property credit = 0
    const property mobilityStrategy
    const property commsStrategy

    method weight() = mobilityStrategy.weight(weight)
    method canCall() = commsStrategy.canCall(credit)
    
}

class FlyingMobility {

    method weight(courierWeight) = 0
}
class GroundMobility {
    var property vehicle

    method weight(courierWeight) = courierWeight + vehicle.weight()
}

class Comms {
    method canCall(credit)
}
class ByCreditComms inherits Comms {
    override method canCall(credit) = credit > 0
}
class BuiltInComms inherits Comms {
    override method canCall(credit) = true
}

class Vehicle {
    var property weight
}
class VehicleWithTrailer inherits Vehicle {
    var property trailerCount = 1

    override method weight() = trailerCount * weight
}


class Package {
    const property price
    var isPaid = false
    var isDelivered = false

    method isDelivered() = isDelivered
    method isPaid() = isPaid

    method pay(amount) {if (amount >= price) isPaid = true}
    method deliver() {if (isPaid) isDelivered = true}
}

class SimplePackage inherits Package{
    const property dropLocation

    method isDeliverable(courier) = isPaid && dropLocation.canPass(courier)
}

class MultiStopPackage inherits Package(price = 0){
    const property dropLocations
    const property remainingLocations = dropLocations.copy()
    const stopPrice = 100
    var amountPaid = 0
    
    override method price() = stopPrice * dropLocations.size()
    
    override method pay(amount) {
        if (amount > self.price() - amountPaid){
            amountPaid += self.price() - amountPaid
        }else{
            amountPaid += amount
        }
        if (amountPaid == self.price()) isPaid = true
    }

    override method deliver() {
        if (isPaid && !remainingLocations.isEmpty()) remainingLocations.remove(remainingLocations.first())
        if (isPaid && remainingLocations.isEmpty()) isDelivered = true
    }

    method isDeliverable(courier) = isPaid && dropLocations.all({location => location.canPass(courier)})
}
class SmallPackage inherits SimplePackage(price = 0, isPaid = true){
}

class Location {
    method canPass(courier)
}
class CommsRestrictedLocation inherits Location {
    override method canPass(courier) = courier.canCall()
}
class WeightRestrictedLocation inherits Location {
    const property weightLimit
    override method canPass(courier) = courier.weight() <= weightLimit
}



const matrix = new CommsRestrictedLocation()
const bridge = new WeightRestrictedLocation(weightLimit = 1000)

const simplePackage = new SimplePackage(dropLocation = bridge, price = 50)
const smallPackage = new SmallPackage(dropLocation = bridge)
const bigPackage = new MultiStopPackage(dropLocations = [matrix,bridge])
const matrixPackage = new SimplePackage(dropLocation = matrix, price = 10)


const truck = new VehicleWithTrailer(weight = 500)
const skateBoard = new Vehicle(weight = 1)
const reverseTrike = new Vehicle(weight = 100)

const morfeo = new Courier(weight = 90,
                           mobilityStrategy = new GroundMobility(vehicle = truck),
                           commsStrategy = new ByCreditComms())
const neo = new Courier(weight = 90,
                        mobilityStrategy = new FlyingMobility(),
                        commsStrategy = new ByCreditComms())
const trinity = new Courier(weight = 900,
                            mobilityStrategy = new GroundMobility(vehicle = skateBoard),
                            commsStrategy = new BuiltInComms())
const samPorter = new Courier(weight = 90,
                              mobilityStrategy = new GroundMobility(vehicle = reverseTrike),
                              commsStrategy = new BuiltInComms())
