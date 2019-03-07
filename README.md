# TestRappi
Prueba tecnica

Descripcion:
1) Vistas
HomeViewcontroller: Controlador de la vista principal con la lista de peliculas
MovieDetailViewcontroller:Controlador del detalle de una pelicula
SearchViewcontroller:Controlador del buscador online
CaregoryView:Vista para el listado de categorias
2) Modelo
Movie:Contiene todos los atributos del objeto de tipo Pelicula
Genres:Contiene todos los atributos del objeto de tipo genero, perteneciente a una pelicula
Credits:Contieene todos los atributos del objeto de tipo creditos, incluyendo cast y el personal, se refiere a los creditos sobre una pelicula
3) Viewmodel
MovieViewModel:encargado de manejar las respuestas de los servicios referentes a las peliculas y cargar los behaviors para pintarse en el controlador
SearchViewModel:contiene los atributos para una busqueda,offline y online
4) Managers
SessionManager: define el manager para las peticiones a los endpoints
MovieManager: Contiene todos los metodos a endpoints acerca de la pelicula (lista,detalle,buscador)
NetworkManager:Contiene un listener que valida la conexion actual a internet del dispositivo
CategoryManager:Manager para la vista CategoryView
5) Adapter
CacheAdapter:Adaptador que basado en la conexion a internet(si existe o no) trae los datos en el cache.
--------
Preguntas
1) El principio de responsabilidad unica es el primer y mas importante principio de SOLID , el cual define una serie de principios
para mejorar el codigo fuente y la  calidad del mismo. Este principio establece que cada clase creada en el proyecto debe tener una
unica responsabilidad, como mapear objetos por ejemplo.
2) Un codigo limpio debe aplicar en lo posible los principios de SOLID, debe ser legible, todo debe nombrarse segun su funcion o aplicacion
y debe tener la posibilidad de modificarse sin mayor problema(escalabilidad). 
