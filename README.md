# Rick & Morty
Aplicación iOS que permite listar, buscar y visualizar los personajes de la serie Rick y Morty con la ayuda de la APIRest *https://rickandmortyapi.com*

Caracteristicas:
- Swift
- Diseño de interfaces con *SwiftUI*
- *Clean Architecture*
- *MVVM (Model view - view model)*
- *async/await* como sistema de llamadas asíncronas
- Configuración de entornos de desarrollo y esquemas *(Production, Staging)*
- *SPM (Swift package manager)* para modularización de las capas *(Data, Domain, Presentation)* mediante paquetes locales 
- *Strings Catalogs* para la localización de la aplicación
- Implementación de *Unit Tests* con XCTest
- Manejo centralizado del sistema de estilos (Fuentes, Colores y Temas)
- Patrón de diseño *Router*: Desacoplamiento de la navegación

Librerias de terceros:
- *Factory*: Injección de dependencias *https://github.com/hmlongco/Factory*
- *Kingfisher*: Descarga y caché de imagenes *https://github.com/onevcat/Kingfisher*

# Estructura del proyecto
En cuanto a la estructura del proyecto nos encontramos con las siguientes carpetas principales:
- *App*: Punto de entrada de la aplicación y todo el conjunto de archivos de configuración, fuentes, inyección de dependencias, localización y el resto de archivos de soporte.
- *Components*: Componentes de uso genérico, archivos de configuración de estilo y las diferentes extensiones.
- *Features*: Cada una características de la aplicación.
- *Modules*: Contiene los paquetes SPM locales *Data*, *Domain* y *Presentation* de *Clean Architecture*.

# Paquetes locales SPM
El proyecto emplea el sistema de paquetes locales gestionado por Swift Package Manager, para modularizar y desacoplar las distintas capas que componen una arquitectura limpia. En cada uno de los paquetes nos encontramos con el código fuente en la carpeta *Sources* y todo el conjunto de pruebas unitarias bajo la carpeta *Tests*.

- *Data*: Paquete que contiene todo lo relacionado con el acceso y manejo de los datos *(DataSources, Repository Implementations)*
- *Domain*: Paquete que contiene toda la lógica de negocio *(UseCases, Repository Protocols, Entities)*
- *Presentation*: Paquete que contiene todo lo relacionado con la lógica de presentación *(ViewModels)*
