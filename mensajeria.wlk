import mensajeros.*

class PackageSystem {
    const property pendingPackages = #{}

    method addPendingPackage(_package) {pendingPackages.add(_package)}
    method removePendingPackage(_package) {pendingPackages.remove(_package)}

    method deliver(service, _package) {
        if (service.canDeliver(_package)){
            _package.deliver()
            service.addBalance(_package.price())
            if (pendingPackages.contains(_package)) self.removePendingPackage(_package)
        
        }else self.addPendingPackage(_package)
    }

    method deliverBatch(service, batch) {batch.forEach({_package => self.deliver(service, _package)})}
    method deliverMaxPendingPackage(service) {
        const _package = self.getMaxPendingPackage()
        self.deliver(service, _package)
        self.removePendingPackage(_package)
    }

    method getMaxPendingPackage() = pendingPackages.max({_package => _package.price()})
}

class CourierSystem {
    const property couriers = #{}

    method hireCourier(courier) {couriers.add(courier)}
    method fireCourier(courier) {if (couriers.contains(courier)) couriers.remove(courier)}
    method fireAllCouriers() {couriers.clear()}
    
    method getCouriersCount() = couriers.size()
    
    method whoCanDeliver(_package) = couriers.filter({courier => _package.isDeliverable(courier)})
    method canFirstDeliver(_package) = _package.isDeliverable(couriers.asList().first())
    
    method lastWeight() = couriers.asList().last().weight()
    method averageWeight() = if (couriers.size() > 0) couriers.sum({courier => courier.weight()}) / couriers.size() else 0
}

class CourierService {
    var property isLargeSize = 2
    var property overWeightLimit = 500
    const property packageSystem = new PackageSystem()
    const property couriersSystem = new CourierSystem()
    var balance = 0

    method balance() = balance
    method addBalance(amount) {balance += amount}
    
    method canDeliver(_package) = couriersSystem.couriers().any({courier => _package.isDeliverable(courier)})
    method isLarge () = couriersSystem.getCouriersCount() > isLargeSize
    method overWeight() = couriersSystem.averageWeight() > overWeightLimit

    /*CourierSystem*/
    method getCouriers() = couriersSystem.couriers()

    method hireCourier(courier) {couriersSystem.hireCourier(courier)}
    method fireCourier(courier) {couriersSystem.fireCourier(courier)}
    method fireAllCouriers() {couriersSystem.fireAllCouriers()}

    method whoCanDeliver(_package) = couriersSystem.whoCanDeliver(_package)
    method canFirstDeliver(_package) = couriersSystem.canFirstDeliver(_package)

    method lastWeight() = couriersSystem.lastWeight()


    /*PackageSystem*/
    method getPendingPackages() = packageSystem.pendingPackages()

    method deliver(_package){packageSystem.deliver(self, _package)}
    method deliverBatch(batch) {packageSystem.deliverBatch(self, batch)}
    method deliverMaxPendingPackage() {packageSystem.deliverMaxPendingPackage(self)}
}

const matrixDelivery = new CourierService()