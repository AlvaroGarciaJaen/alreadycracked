# alreadycracked

## Descripción
Se pretende desarrollar una API que recoja hashes de diferentes algoritmos (MD5,
SHA1...) junto con su correspondiente en texto plano. Los usuarios podrán
consultar si cierto hash ha sido ya "_crackeado_" y, si es así, se le devolverá la
información correspondiente. También se pretende que la comunidad pueda
colaborar añadiendo sus propios datos a la base de datos (previa comprobación)
para que la API se vaya realimentando y vaya creciendo por sí sola.

## Implementación
Esta API se escribirá en [Ruby](ruby-lang.org) usando la librería [Sinatra](sinatrarb.com).
Se ha elegido este lenguaje principalmente por ser también open source. En
cuanto a la base de datos, aún está por determinar.

## Referencias
Está basada en la famosa web [CrackStation](crackstation.net)
