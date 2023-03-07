# isEazy_meteo

Aplicación meteorológica desarrollada para el proceso de selección de isEazy

El proyecto cuenta con dos Pods, instalados mediante podfile
  - Bond
  - SwiftLint
  
La app se compone de dos pantallas:
  - La primera solicita los permisos al usuario la primera vez que se abre la app o en veces sucesivas por si el usuario hubiera cambiado los permisos
  - La segunda muestra la iformación meteorológica de la ciudad en la que se encuentre el dispositivo
  
Consideraciones sobre el código:
  - Se ha utilizado el patrón de diseño MVC aunque por costumbre al nombrar las clases se llamen como en el patrón MVVM (aunque dependiento del programador podrá decir que la app realmente es MVVM)
  - El mapeado de datos del JSON se ha realizado utilizando las librerías propias de Swift
  - Se ha traducido la aplicación a los idiomas inglés, español, francés e italiano (en caso de seleccionar alemán por ejemplo, se mostrará la app en inglés)
  - Se utiliza el idioma de la app para enviarlo junto a los parámetros de la llamada a la API
  - Las interfaces se adaptan al tipo de dispositivo (iPhone o iPad) para mostrar los datos de la mejor manera posible
  - No se han utilizado archivos .storyboard ni .xib, todo el desarrollo de las interfaces se ha hecho de manera programática
  - No se realizan test de código ni de interfaz por falta de tiempo, ya que si no se me iba bastante del tiempo que tenía planificado para la prueba
  - No se establece icono de la app ya que no es necesario para la prueba
  - Tampoco se establecen identificadores individuales para las versiones de desarrollo y producción ya que no va a distribuirse la app fuera de un entorno de pruebas
