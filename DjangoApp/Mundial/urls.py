from django.urls import path
from Mundial.views import ListaMundiales, DetalleMundial, DetalleSeleccion, ListaSeleccciones, ParticionesSeleccion, ListaPodios

urlpatterns = [
    path('Mundiales/', ListaMundiales.as_view(), name='lista_mundiales'),
    path('Mundiales/<str:idTorneo>', DetalleMundial.as_view(), name='detalle_mundial'),
    path('Mundiales/<str:idTorneo>/<str:idSeleccion>', DetalleSeleccion.as_view(), name='detalle_seleccion'),
    path('Selecciones/', ListaSeleccciones.as_view(), name='lista_selecciones'),
    path('Selecciones/<str:idSeleccion>', ParticionesSeleccion.as_view(), name='participaciones_seleccion'),
    path('Podios/', ListaPodios.as_view(), name='lista_podios'),
]