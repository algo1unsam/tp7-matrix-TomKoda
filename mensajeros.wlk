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

object mensajeroOriginal {
    var property credito = 0 
    
    method peso() = monopatin.peso()
    method puedeLlamar() = credito > 0
}


object mensaje{
    const precio = 10
    var property pago = false
    var property destino = puente 

    method precio() = precio
    method estaPago() = pago 
    method pagar() {pago = true}
    method puedeSerEntregadoPor(mensajero) = pago && destino.dejarPasar(mensajero)


}


object paquete {
    const precio = 50
    var property pago = false
    var property destino = puente 

    method precio() = precio
    method estaPago() = pago 
    method pagar() {pago = true}
    method puedeSerEntregadoPor(mensajero) = pago && destino.dejarPasar(mensajero)
}

object paquetito {

    const property pago = true
    var property destino = puente

    method precio() = 0
    method estaPago() = pago 
    method puedeSerEntregadoPor(mensajero) = pago && destino.dejarPasar(mensajero)
}

object paqueton {
    const precioPorDestino = 100
    var cantidadPagada = 0
    var property pago = false
    const property destinos = [puente, matrix]

    method destino() = destinos.get(0)

    method precio() = precioPorDestino * destinos.size()

    method pagar(monto) {
        if (monto > self.precio() - cantidadPagada){
            cantidadPagada += self.precio() - cantidadPagada
        }else{
            cantidadPagada += monto
        }
        if (cantidadPagada == self.precio()) pago = true
    }
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