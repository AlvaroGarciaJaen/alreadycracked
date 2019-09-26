# alreadycracked

## Descripción
Se pretende desarrollar un microservicio que recoja hashes de diferentes
algoritos (MD5, SHA1...) junto con su correspondiente en texto plano. El usuario
podrá tanto consultar un hash para obtener el texto plano, como añadir aquellas
correspondencias que no se encuentren. De esta manera se pretende que poco a
poco el conjunto de datos vaya creciendo.

Para hacer uso de este microservicio, se implementará un API REST también como
parte de este proyecto. Se espera así que cualquiera pueda desarrollar de manera
fácil y cómoda cualquier tipo de interfaz a partir de este trabajo.

## Implementación
Se escribirá en [Ruby](http://ruby-lang.org) usando la librería [Sinatra](http://sinatrarb.com).
Se ha elegido este lenguaje principalmente por ser también open source. En
cuanto a la base de datos, aún está por determinar.

## Referencias
Está basada en la famosa web [CrackStation](http://crackstation.net)
