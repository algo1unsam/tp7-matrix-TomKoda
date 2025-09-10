import mensajeros.*

object mensajeria {
    const tamañoMensajeriaGrande = 2
    const property mensajeros = #{}

    method contratarMensajero(mensajero) {
        mensajeros.add(mensajero)
    }

    method despedir(mensajero) {
        if (mensajeros.contains(mensajero)) mensajeros.remove(mensajero)
    }

    method despedirTodos() {
        mensajeros.clear()
    }

    method esGrande() = mensajeros.size() > tamañoMensajeriaGrande

    method primeroPuedeEntregar(paquete) = paquete.puedeSerEntregadoPor(mensajeros.asList().first())
    method pesoUltimo() = mensajeros.asList().last().peso()
    
}
