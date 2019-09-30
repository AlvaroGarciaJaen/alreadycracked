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

## Motivación
Desde hace muchos años, [CrackStation](http://crackstation.net) ha sido el
referente en cuanto a base de datos de hashes a nivel mundial. No obstante,
cuando se desarrolló allá por 2010, se diseñó como una página web al uso. En
este proyecto, propongo desarrollar un microservicio que lleve a cabo la misma
funcionalidad de CrackStation pero aplicando las nuevas tecnologías que
actualmente funcionan tan bien. Una vez acabado su desarrollo (integración
continua, código, despligue...) el usuario podrá hacer consultas de una gran
variedad de funciones hash mediante un API REST. De esta manera, la comunidad
podrá crear diferentes aplicaciones finales (páginas web, aplicaciones móviles,
bots en redes sociales o aplicaciones de mensajería...) de la manera más cómoda
y fiable posible.

## Implementación
El lenguaje principal para este proyecto será [Ruby](https://www.ruby-lang.org).
Se ha elegido este lenguaje por ser open source, por las librerías que tiene y
que nos serán útiles para desarrollar este proyecto y por ser un lenguaje cómodo
y fácil a la hora de escribir y leer.
Para llevarlo a cabo, haremos uso de las siguientes librerias/herramientas:

-   [Sinatra](http://sinatrarb.com). Se trata de un microframework diseñado para
    crear aplicaciones web en Ruby con un mínimo esfuerzo. Podríamos considerar
    que Sinatra es el equivalente a [Flask](https://palletsprojects.com/p/flask/)
    en Ruby. Su sintaxis tan sencilla y la amplia documentación disponible hará
    que el consumo de datos mediante el API REST sea el menor de nuestros problemas.

-   [Digest](https://github.com/ruby/digest). Se trata de un framework que nos
    permitirá usar las diferentes funciones hash. Como se explicó más arriba,
    la función de este microservicio va más allá del simple almacenamiento de
    datos, también permitirá que la comunidad añada entradas nuevas, lo que requerirá
    su comprobación para asegurar la legitimidad de la misma.

-   [rbenv](https://github.com/rbenv/rbenv). Para el correcto desarrollo de un
    proyecto es necesario el uso de entornos virtuales. Esto nos permite no
    entrar en conflicto con el resto de proyectos que estemos llevando a cabo en
    nuestro ordenador y gestionar de manera correcta las versiones de las librerias
    usadas. Se ha decidido usar rbenv en contraposición a [RVM](https://github.com/rvm/rvm)
    por ser más apoyada por la comunidad, además de por ser más ligera (no
    necesitamos más).

-   [MongoDB](https://www.mongodb.com/). Necesitamos una base de datos que se
    adecúe a nuestro proyecto. Como necesitamos una base de datos que sea muy
    escalable debido a la gran cantidad de datos que vamos a almacenar y muy
    rápida para consultas simples, sí o sí debemos ir a por una base de datos
    NoSQL. Se ha elegido MongoDB por ser la más popular, lo que significa mayor 
    documentación en el caso de que nos encontremos algún problema
