object morfeo {
    var property peso = 90
    var property transporte = camion
    const credito = 0

    method peso() = peso + transporte.peso()
    method puedeLlamar() = credito > 0

}

object neo {
    var property credito = 0 
    
    method peso() = 0
    method puedeLlamar() = credito > 0 
}

object trinity {
    var property peso = 900

    method puedeLlamar() = true

}

object paquete {
    const precio = 50
    var property pago = false
    var property destino = puente 

    method estaPago() = pago 
    method pagar() {pago = true}
    method puedeSerEntregadoPor(mensajero) = pago && destino.dejarPasar(mensajero)
}

object paquetito {
    const property pago = true
    var property destino = puente

    method puedeSerEntregadoPor(mensajero) = pago && destino.dejarPasar(mensajero)
}

object paqueto {
  
}


object camion {
    const pesoAcoplado = 500 
    var property acoplados = 1 

    method peso() = acoplados * pesoAcoplado 
}

object monopatin {
    const property peso = 1 
}


object matrix {

    method dejarPasar(mensajero) = mensajero.puedeLlamar()
}
object puente {
    const property limitePaso = 1000

    method dejarPasar(mensajero) = mensajero.peso() <= limitePaso
}