from django.urls import path
from Mundial.views import ListaMundiales, DetalleMundial, DetalleSeleccion, \
    ListaSeleccciones, ParticionesSeleccion, ListaPodios, ListaPremios, Grupos, GruposMundial
from django.views.generic.base import RedirectView

urlpatterns = [
    path('Mundiales/', ListaMundiales.as_view(), name='lista_mundiales'),
    path('Mundiales/<str:idTorneo>', DetalleMundial.as_view(), name='detalle_mundial'),
    path('Mundiales/<str:idTorneo>/<str:idSeleccion>', DetalleSeleccion.as_view(), name='detalle_seleccion'),
    path('Selecciones/', ListaSeleccciones.as_view(), name='lista_selecciones'),
    path('Selecciones/<str:idSeleccion>', ParticionesSeleccion.as_view(), name='participaciones_seleccion'),
    path('Podios/', ListaPodios.as_view(), name='lista_podios'),
    path('Premios/', ListaPremios.as_view(), name='lista_premios'),
    path('Grupos/', Grupos.as_view(), name='lista_grupos'),
    path('Grupos/<str:idTorneo>', GruposMundial.as_view(), name='lista_grupos_mundial'),
    path('', RedirectView.as_view(url="Mundiales/")),
]
