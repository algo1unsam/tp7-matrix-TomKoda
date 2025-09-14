import mensajeros.*

object mensajeria {
    const tamañoMensajeriaGrande = 2
    const property mensajeros = #{}
    const property pendientes = #{}
    var property balance = 0

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

    method puedeEntregar(paquete) = !self.quienesPuedenEntregar(paquete).isEmpty()
    method quienesPuedenEntregar(paquete) = mensajeros.filter({mensajero => paquete.destino().dejarPasar(mensajero)})
    method sobrePeso() = mensajeros.map({mensajero => mensajero.peso()}).sum() / mensajeros.size() > 500
    
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

    method enviarConjunto(conjunto) {conjunto.forEach({paquete => self.enviar(paquete)})}
    method enviarPendienteCaro() {
        self.enviar(self.pendientes().asList().sortedBy({pq1, pq2 => pq1.precio() > pq2.precio()}).get(0))
    }
}
