class Personajes{
  const fuerza 
  const inteligencia 
  var rol
  method cambiarRol(unRol){
    rol = unRol
  }
  method potencialOfensivo(){
    return fuerza * 10 + rol.extra()  
  }
  method esInteligente()
  //el self dentro de esGroso() 
  method esGroso() = self.esInteligente() || rol.esGroso(self)

}

// Un Objeto tambien puede heredar algo de una clase 

object guerrero {
  method extra() = 100
  method brutalidadInnata(unValor){return 0}
  method esGroso(unPersonaje){
    return unPersonaje.fuerza() > 50
  }
}
class Cazador {
  var mascota = new Mascota(fuerza=0,edad=0,tieneGarras=false)
  method cambiarMascota(nuevaMascota){
    mascota = nuevaMascota
  }
  method naceNuvaMascota(fuerza,edad,tieneGarras){
    mascota = new Mascota(fuerza=fuerza, edad=edad, tieneGarras=tieneGarras)
  }
  method extra() = mascota.potencial()
  method brutalidadInnata(unValor) {
    return 0
  }
  method esGroso(unPersonaje){
    return mascota.esLongevaa()
  }

}
class Mascota{
  const fuerza
  const edad
  const tieneGarras
  // este metodo se ejecuta junto al creador, debe llamarse asi, si o si. 
  method initialize(){
    if(fuerza>100){
      self.error("la mascota no puede tener fuerza mas que 100")
    }
  }
  method potencial() = if(tieneGarras){fuerza * 2} else fuerza
  method esLongevaa() = edad > 10

}

object brujo {
  method extra() = 0
  method brutalidadInnata(unValor){return unValor * 0.1}
  method esGroso() = true

}

class Orco inherits Personajes {
  override method potencialOfensivo(){
    return 
    super() + rol.brutalidadInnata(super())
  }

}
class Humano inherits Personajes{
  override method esInteligente() = inteligencia
}


class Localidad{
  var ejercito = new Ejercito()
  method enlistar(unPersonaje){ejercito.agregar(unPersonaje) }
  method poderDefensivo()= ejercito.potencial()
  method serOcupada(unEjercito)
}

class Aldea inherits Localidad{
const cantMaxima
override method enlistar(unPersonaje){ if(ejercito.personajes().size() >= cantMaxima){ 
self.error("se alcanzo el limite maximo - ejercito")} super(unPersonaje)
}
override method serOcupada(unEjercito){
  ejercito.clear()
  unEjercito.forEach({p => p self.enlistar(p)})
  unEjercito.quitarLosMasFuertes(cantMaxima.min(10))
}

}

class Cuidad inherits Localidad{
  override method poderDefensivo(){
    return super() * 300
}
  override method serOcupada(unEjercito){
    ejercito = unEjercito
}
}


class Ejercito{
  const property personajes = []
  method potencial() = personajes.sum({p => p.potencialOfensivo()})
  method agregar(unPersonaje){personajes.add(personajes)}
  method puedeInvadir(unaLocalidad){
    return self.potencial() > unaLocalidad.poderDefensivo()
  }
  method invadir(unaLocalidad){
    if(self.puedeInvadir(unaLocalidad)){
      unaLocalidad.serOcupada(self)
    }
  }

  //take toma los diez primeros, en caso de que haya menos no importa te los retorna igual 
  method losDiezMasPoderosos() = self.listaOrdenadaPorPoder().take(10)
  //sortBy necesita dos variables para que puedan compararse entre ellas 
  method listaOrdenadaPorPoder(){
    return personajes.asList().sortBy({p1,p2 => p1.potencialOfensivo() > p2.potencialOfensivo()})
  }
  method dividirEjercito(){
    new Ejercito()
    return personajes.removeAll(self.losDiezMasPoderosos())
  } 
  method quitarLosMasFuertes(cantidadAQuitar){
    personajes.removeAll(self.losDiezMasPoderosos().take(cantidadAQuitar))
  }
}