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

class ByCreditComms {
    method canCall(credit) = credit > 0
}
class BuiltInComms {
    method canCall(credit) = true
}

class Vehicle {
    var property weight
}
class VehicleWithTrailer inherits Vehicle {
    var property trailerCount = 1

    override method weight() = trailerCount * weight
}

class SimplePackage {
    const property dropLocation
    const property price = 0
    var isPaid = false
    var isDelivered = false

    method isDelivered() = isDelivered
    method isPaid() = isPaid
    method pay() {isPaid = true}
    method deliver() {isDelivered = true}
    method isDeliverable(courier) = isPaid && dropLocation.canPass(courier)
}
class MultiStopPackage {
    const property dropLocations
    const property remainingLocations = dropLocations
    const stopPrice = 100
    var amountPaid = 0
    var isPaid = false
    var isDelivered = false

    method isDelivered() = isDelivered
    method isPaid() = isPaid
    method price() = stopPrice * dropLocations.size()
    method pay(amount) {
        if (amount > self.price() - amountPaid){
            amountPaid += self.price() - amountPaid
        }else{
            amountPaid += amount
        }
        if (amountPaid == self.price()) isPaid = true
    }
    method deliver() {
        if (isPaid && !remainingLocations.isEmpty()) remainingLocations.remove(remainingLocations.first())
        if (isPaid && remainingLocations.isEmpty()) isDelivered = true
    }

    method isDeliverable(courier) = isPaid && dropLocations.get(0).canPass(courier)
}
class SmallPackage inherits SimplePackage {
    override method price() = 0
    override method isPaid() = true
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

const simplePackage = new SimplePackage(dropLocation = bridge)
const smallPackage = new SmallPackage(dropLocation = matrix)
const bigPackage = new MultiStopPackage(dropLocations = [matrix,bridge])

const morfeo = new Courier(weight = 90,
                           mobilityStrategy = new GroundMobility(vehicle = new VehicleWithTrailer(weight = 500)),
                           commsStrategy = new ByCreditComms())
const neo = new Courier(weight = 90,
                        mobilityStrategy = new FlyingMobility(),
                        commsStrategy = new ByCreditComms())
const trinity = new Courier(weight = 900,
                            mobilityStrategy = new GroundMobility(vehicle = new Vehicle(weight = 1)),
                            commsStrategy = new BuiltInComms())
const samPorter = new Courier(weight = 900,
                              mobilityStrategy = new GroundMobility(vehicle = new Vehicle(weight = 100)),
                              commsStrategy = new BuiltInComms())
