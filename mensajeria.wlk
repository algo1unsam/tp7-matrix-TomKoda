import mensajeros.*

class PackageSystem {
    const property pendingPackages = #{}

    method addPendingPackage(_package) {pendingPackages.add(_package)}
    method removePendigPackage(_package) {pendingPackages.remove(_package)}

    method deliver(_package) {_package.deliver()}
    method deliverBatch(batch) {batch.forEach({_package => _package.deliver()})}
    method deliverMaxPendingPackage() {self.getMaxPendingPackage().deliver()}

    method getMaxPendingPackage() = pendingPackages.max({_package => _package.price()})
}

class CourierSystem {
    const property couriers = #{}

    method hireCourier(courier) {couriers.add(courier)}
    method fireCourier(courier) {if (couriers.contains(courier)) courier.remove(courier)}
    method fireAllCouriers() {couriers.clear()}
    
    method whoCanDeliver(_package) {couriers.map({courier => _package.isDeliverable(courier)})}
    
    method lastWeight() = couriers.asList().last().weight()

    method canFirstDeliver(_package) = _package.isDeliverable(couriers.asList().first())

    method averageWeight() = couriers.sum({courier => courier.weight()}) / couriers.size()
    method getCouriersCount() = couriers.size()
}

class CourierService {
    var property isLargeSize = 2
    var property overWeightLimit = 500
    const packageSystem = new PackageSystem()
    const couriersSystem = new CourierSystem()
    var balance = 0

    method balance() = balance
    method canDeliver(_package) = couriersSystem.couriers().any({courier => _package.isDeliverable(courier)})
    method isLarge () = couriersSystem.getCouriersCount() > isLargeSize
    method overWeight() = couriersSystem.averageWeight() > overWeightLimit

    /*PackageSystem*/
    method deliver(_package){
        if (self.canDeliver(_package)){
            packageSystem.deliver(_package)
            balance += _package.price()
        }else{
            packageSystem.addPendingPackage(_package)
        }
    }


}

object mensajeria {
    const tamañoMensajeriaGrande = 2
    const property mensajeros = #{}
    const property pendientes = #{}
    var property balance = 0

    //method contratarMensajero(mensajero) {mensajeros.add(mensajero)}

    //method despedir(mensajero) {if (mensajeros.contains(mensajero)) mensajeros.remove(mensajero)}

    //method despedirTodos() {
    //    mensajeros.clear()
    //}

    //method esGrande() = mensajeros.size() > tamañoMensajeriaGrande

    method primeroPuedeEntregar(paquete) = paquete.puedeSerEntregadoPor(mensajeros.asList().first())
    //method pesoUltimo() = mensajeros.asList().last().peso()

    //method puedeEntregar(paquete) = self.quienesPuedenEntregar(paquete).any({mensajero => paquete.destino().dejarPasar(mensajero)})
    //method quienesPuedenEntregar(paquete) = mensajeros.filter({mensajero => paquete.destino().dejarPasar(mensajero)})
    //method sobrePeso() = mensajeros.map({mensajero => mensajero.peso()}).sum() / mensajeros.size() > 500
    
    method enviar(paquete) {
        if (self.puedeEntregar(paquete)){
            balance += paquete.precio()
            if (pendientes.contains(paquete)){
                pendientes.remove(paquete)
            }
        }else{
            pendientes.add(paquete)
        }
    }
    
}
