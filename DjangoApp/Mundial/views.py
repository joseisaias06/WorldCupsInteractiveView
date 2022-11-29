from django.db import connection

# Create your views here.

from django.views.generic import ListView, TemplateView

class ListaMundiales(ListView):

    cursor = connection.cursor()
    cursor.execute(''' SELECT * FROM mundiales.torneo''')
    row = cursor.fetchall()

    context_object_name = 'lista_mundiales'
    queryset = row
    template_name = 'mundiales.html'

class DetalleMundial(TemplateView):

    template_name = 'detalle_mundial.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        idTorneo = self.kwargs['idTorneo']
        
        cursor = connection.cursor()
        cursor.execute(''' SELECT * FROM 
        (SELECT * FROM mundiales.plantilla WHERE idTorneo = '{}') AS plantillas 
        INNER JOIN mundiales.seleccion ON plantillas.idSeleccion = seleccion.idSeleccion'''.format(idTorneo))
        lista_selecciones = cursor.fetchall()

        lista_confederaciones = []

        for seleccion in lista_selecciones:
            cursor.execute(''' SELECT nombreConfederacion FROM mundiales.confederacion WHERE idCondeferacion = '{}' '''.format(seleccion[8]))
            lista_confederaciones.append(cursor.fetchall())

        lista_selecciones = zip(lista_selecciones, lista_confederaciones)

        cursor.execute(''' SELECT * FROM (SELECT * FROM mundiales.podio WHERE idTorneo = '{}') AS podios 
        INNER JOIN mundiales.seleccion ON podios.idSeleccion = seleccion.idSeleccion'''.format(idTorneo))
        lista_podios = cursor.fetchall()

        context['lista_selecciones'] = lista_selecciones
        context['nombre_torneo'] = idTorneo
        context['lista_podios'] = lista_podios
        
        return context

class DetalleSeleccion(TemplateView):

    template_name = 'detalle_seleccion.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        idTorneo = self.kwargs['idTorneo']
        idSeleccion = self.kwargs['idSeleccion']

        cursor = connection.cursor()
        cursor.execute('''SELECT idPlantilla, idEntrenador, idSeleccion FROM mundiales.plantilla WHERE (idTorneo = '{}' AND idSeleccion = '{}') '''.format(idTorneo, idSeleccion))
        plantilla = cursor.fetchall()

        cursor.execute(''' SELECT * FROM mundiales.entrenador WHERE idEntrenador = '{}' '''.format(plantilla[0][1].rstrip()))
        entrenador = cursor.fetchall()

        cursor.execute(''' SELECT idJugador FROM mundiales.plantilla_has_jugador WHERE idPlantilla = {} '''.format(plantilla[0][0]))
        jugadores = cursor.fetchall()

        lista_jugadores = []

        for jugador in jugadores:
            cursor.execute(''' SELECT * FROM mundiales.jugador WHERE idJugador = '{}' '''.format(jugador[0].rstrip()))
            lista_jugadores.append(cursor.fetchall())

        cursor.execute(''' SELECT nombreFederacion FROM mundiales.seleccion WHERE idSeleccion = '{}' '''.format(idSeleccion))
        nombre_seleccion = cursor.fetchall()

        cursor.execute(''' SELECT * FROM mundiales.partido WHERE ((id_equipo_casa = '{}' OR id_equipo_visitante = '{}') AND (idTorneo = '{}')) '''.format(idSeleccion, idSeleccion, idTorneo    ))
        lista_partidos = cursor.fetchall()

        context['lista_jugadores'] = lista_jugadores
        context['nombre_seleccion'] = nombre_seleccion
        context['nombre_torneo'] = idTorneo
        context['lista_partidos'] = lista_partidos
        context['entrenador'] = entrenador

        return context

class ListaSeleccciones(ListView):

    cursor = connection.cursor()
    cursor.execute(''' SELECT * FROM (SELECT * FROM mundiales.seleccion) AS selecciones INNER JOIN mundiales.confederacion ON selecciones.idCondeferacion = confederacion.idCondeferacion ORDER BY nombreSeleccion''')
    row = cursor.fetchall()

    context_object_name = 'total_selecciones'
    queryset = row
    template_name = 'selecciones.html'

class ParticionesSeleccion(TemplateView):

    template_name = 'participaciones_seleccion.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        idSeleccion = self.kwargs['idSeleccion']

        cursor = connection.cursor()
        cursor.execute(''' SELECT * FROM mundiales.seleccion WHERE idSeleccion = '{}' '''.format(idSeleccion))
        seleccion = cursor.fetchall()

        cursor.execute(''' SELECT * FROM (SELECT DISTINCT idTorneo FROM mundiales.partido WHERE (id_equipo_casa = '{}' OR id_equipo_visitante = '{}')) AS mundiales INNER JOIN mundiales.torneo ON mundiales.idTorneo = torneo.idTorneo; '''.format(idSeleccion, idSeleccion))
        lista_torneos = cursor.fetchall()

        context['lista_torneos'] = lista_torneos
        context['seleccion'] = seleccion
        return context

class ListaPodios(ListView):
    
    cursor = connection.cursor()
    cursor.execute(''' SELECT * FROM mundiales.podio INNER JOIN mundiales.seleccion ON podio.idSeleccion = seleccion.idSeleccion ''')
    row = cursor.fetchall()

    context_object_name = 'lista_podios'
    queryset = row
    template_name = 'podios.html'

class ListaPremios(ListView):
    
    cursor = connection.cursor()
    cursor.execute(''' SELECT nombre_premio, idTorneo, jugador.nombre, jugador.apellido, nombre_seleccion, posicion
    FROM mundiales.premio INNER JOIN mundiales.jugador ON premio.idJugador = jugador.idJugador ''')
    row = cursor.fetchall()

    context_object_name = 'lista_premios'
    queryset = row
    template_name = 'premios.html'

class Grupos(ListView):

    cursor = connection.cursor()
    cursor.execute(''' SELECT * FROM Mundiales.torneo''')
    row = cursor.fetchall()

    context_object_name = 'lista_mundiales'
    queryset = row
    template_name = 'grupos.html'

class GruposMundial(TemplateView):
    
    template_name = 'gruposMundial.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        idTorneo = self.kwargs['idTorneo']

        cursor = connection.cursor()
        cursor.execute(''' SELECT * FROM (SELECT * FROM mundiales.grupo WHERE idTorneo = '{}') 
        AS grupos INNER JOIN mundiales.seleccion ON grupos.idSeleccion = seleccion.idSeleccion '''.format(idTorneo))
        lista_grupos = cursor.fetchall()
        print(lista_grupos)

        context['grupos'] = lista_grupos
        return context
