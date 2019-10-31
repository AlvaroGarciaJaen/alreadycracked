# alreadycracked
![GitHub](https://img.shields.io/github/license/AlvaroGarciaJaen/alreadycracked)
[![Build Status](https://travis-ci.com/AlvaroGarciaJaen/alreadycracked.svg?branch=master)](https://travis-ci.com/AlvaroGarciaJaen/alreadycracked)
[![CircleCI](https://circleci.com/gh/AlvaroGarciaJaen/alreadycracked.svg?style=svg)](https://circleci.com/gh/AlvaroGarciaJaen/alreadycracked)

## Índice
-   [Descripción](#descripción)
-   [Motivación](#motivación)
-   [Funcionalidad](#funcionalidad)
-   [Implementación](#implementación)
-   [Integración continua](#integración-continua)

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
funcionalidad que CrackStation pero aplicando las nuevas tecnologías que
actualmente funcionan tan bien. Una vez acabado su desarrollo (integración
continua, código, despligue...) el usuario podrá hacer consultas de una gran
variedad de funciones hash mediante un API REST. De esta manera, la comunidad
podrá crear diferentes aplicaciones finales (páginas web, aplicaciones móviles,
bots en redes sociales o aplicaciones de mensajería...) de la manera más cómoda
y fiable posible.

## Funcionalidad
El sistema deberá cumplir las siguientes funciones:
-   A partir de un texto plano, aplicar una función hash (MD5, SHA1...) y
    devolver el resultado.
-   A partir de un hash, detectar su tipo y devolver el texto plano que lo
    genera.

## Implementación
El lenguaje principal para este proyecto será [Ruby](https://www.ruby-lang.org).
Se ha elegido este lenguaje por ser open source, por las librerías que tiene y
que nos serán útiles para desarrollar este proyecto y por ser un lenguaje cómodo
y fácil a la hora de escribir y leer.
Para llevarlo a cabo, haremos uso de las siguientes librerías/herramientas:

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

-   [Logstash](https://www.elastic.co/products/logstash). Necesitamos llevar un
    registro de eventos del microservicio. Debido a su popularidad y al stack al
    que pertenece ([Elastic](https://www.elastic.co/products/)), se ha elegido
    Logstash pensando a largo plazo por su fácil integración con el resto de 
    componentes del stack por si fuera necesario.

-   [Travis CI](https://travis-ci.org/). Para comprobar mediante tests que
    nuestro proyecto cumple los objetivos necesarios, usaremos Travis CI. Se
    elige por su popularidad y su fácil integración con GitHub.

## Herramienta de construcción
Al desarrollarse en Ruby, se ha elegido 
[Rakefile](https://github.com/AlvaroGarciaJaen/alreadycracked/blob/master/Rakefile)
como herramienta de construcción:
```ruby
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "t"
  t.test_files = FileList['t/test*.rb']
  t.verbose = true
end

Rake::TestTask.new(:test_unit) do |t|
  t.libs << "t"
  t.test_files = FileList['t/test_unit.rb']
  t.verbose = true
end

Rake::TestTask.new(:test_func) do |t|
  t.libs << "t"
  t.test_files = FileList['t/test_func.rb']
  t.verbose = true
end

desc "Install gems"
task :install do
  sh 'bundle install'
end

desc "Run service"
task :start do
  sh 'rackup -D'
end

desc "Stop service"
task :stop do
  pid = `lsof -i :9292 -sTCP:LISTEN -t`
  sh "kill -9 #{pid}"
end

task :default => :start
```

Se llama con `rake` y se han definido las
siguientes tareas:
-   `rake` o `rake start`: Inicia el servicio web

Para iniciar el servicio lo hacemos con la herramienta rackup en modo demonio
para que se ejecute en segundo plano. Escucha en el puerto 9292 que es el puerto
estándar. Para su despliegue en PaaS se usará una variable de entorno, pero
mientras tanto con fijar uno es suficiente.

-   `rake stop`: Para el servicio web

Para parar el servicio debemos hacerlo a través de su pid. Como lo único que
sabemos del proceso es que se encuentra escuchando peticiones TCP en el puerto 9292,
hay una herramienta llamada lsof que nos permite buscar un pid a partir de estos
datos.

-   `rake test`: Ejecuta todo los tests 

Se ejecutan tanto los tests unitarios como funcionales.

-   `rake test_unit`: Ejecuta todo los tests unitarios 

Se ejecutan únicamente los tests unitario para comprobar que la lógica de
nuestro servicio funciona correctamente.

-   `rake test_func`: Ejecuta todo los tests funcionales 

Se ejecutan únicamente los tests funcionales para comprobar que la API REST
funciona correctamente. 

Se ha decidido dar la posibilidad de ejecutar los tests por separado para
aprovechar el uso de las dos plataformas de CI.

## Integración continua
Para implementar una correcta integración continua debemos hacer un desarrollo
guiado por pruebas (TDD). Se han escrito tests para cubrir la
[funcionalidad](#funcionalidad) básica:
-   El hash que se devuelve ante un texto plano es el correcto.
-   Se detecta correctamente el tipo de hash.
-   El texto plano que se devuelve a partir de un hash es el correcto.

Para hacerlo, se ha usado el framework 
[test-unit](https://ruby-doc.org/stdlib-1.8.7/libdoc/test/unit/rdoc/Test/Unit.html) 
 y [rack-test](https://github.com/rack-test/rack-test) para probar la API REST
de manera nativa, interactuando con la clase directamente.
Los tests pueden verse
[aquí](https://github.com/AlvaroGarciaJaen/alreadycracked/tree/master/t)
Para automatizar la ejecución de tests se está utilizando [Travis
CI](https://travis-ci.com) y [CircleCI](https://circleci.com/):

### Travis CI
En primer lugar, se ha configurado Travis CI para lanzar los tests de manera
automática. Es uno de los sistemas de integración continua más conocidos, por lo
que tenemos muchos ejemplos sobre como realizar una correcta configuración.
[Nuestro archivo de
configuración](https://github.com/AlvaroGarciaJaen/alreadycracked/blob/master/.travis.yml) es muy sencillo:
```yaml
language: ruby
install: rake install
script: rake test_unit
```
Especificamos el lenguaje con la etiqueta 'language', con la etiqueta install
indicamos la orden con la que debe instalarse lo necesario para realizar los
tests. Como tenemos la tarea install en nuestro [Rakefile](#Herramienta-de-construcción),
 usaremos esto. Por último le decimos cómo ejecutar los tests.
Como vamos a utilizar dos plataformas para correr tests, lo que haremos será
dividirlos en dos partes. Por un lado correremos los tests unitarios (aquí),
y por otro los tests funcionales (CircleCI).
No hace falta especificar la versión, ya que comprueba directamente al archivo
[.ruby-version](https://github.com/AlvaroGarciaJaen/alreadycracked/blob/master/.ruby-version).

### CircleCI
En segundo lugar, se ha configurado CircleCI para lanzar los tests de manera
automática. Se ha elegido por, según la comunidad, ser uno de los más rápidos.
En el siguiente apartado se hablará más sobre eso. [Nuestro archivo de
configuración](https://github.com/AlvaroGarciaJaen/alreadycracked/blob/master/.circleci/config.yml)
también es bastante sencillo:
```yaml
version: 2
jobs:
  build:
    docker:
      - image: circleci/ruby:2.6.5

    steps:
      - checkout

      - run:
          name: Install gems
          command: rake install

      - run:
          name: Run tests
          command: rake test_func

      - run:
          name: Start web service
          command: rake start
```
Como podemos ver en el archivo de
configuración, CircleCI tiene un sistema basado en contenedores. En este caso le
decimos que use el de Ruby con la versión 2.6.5 de su propio repositorio. Una
vez con la imagen corriendo, ya puede lanzar comandos (_rake_ en este caso para
ejecutar los tests). Instalamos las gemas con `rake install`, ejecutamos los
tests funcionales con `rake test_func` y probamos a levantar el servicio con
`rake start`.

### Conclusiones
Los sistemas de integración continua me han parecido una herramienta muy útil,
ya no solo para hacer tests como hemos visto en este apartado sino también para
hacer el despliegue. A raiz de esto incluso he probado a hacer el despliegue
automático de gh-pages usando Travis. Aunque en el repositorio no pueden verse
las mejores prácticas, sí que muestra la potencia que puede llegar a tener esto
cuando se hace desarrollo ágil. El repositorio puede verse
[aquí](https://github.com/AlvaroGarciaJaen/alvarogarciajaen.github.io). 

Hablando ahora sobre los dos sistemas de integración que se han usado (Travis CI y
CircleCI), en mi opinión ambos son muy potentes pero cada uno tiene sus puntos
fuertes:
-   CircleCI es mucho más rápido que Travis. Tras probar ambos, CircleCI
    devuelve resultados en unos 5 segundos mientras que Travis llega al minuto
    casi. Algunos compañeros comentan que se debe a que mi proyecto no cuenta con
    dependencias y por eso es capaz CircleCI de hacerlo tan rápido. Conforme el
    proyecto vaya creciendo veremos como se adapta. No obstante, las VM de
    Travis tardan muchísimo en arrancar en comparación a su competidor. Quizás
    usando Docker también en Travis se mejorarían los resultados indicando un
    lenguaje _minimal_, pero esto no quita que la velocidad con la que CircleCI es
    capaz de arrancar una máquina no tiene ni punto de comparación.
-   Desde el principio, el archivo de configuración de Travis me parece mucho
    más sencillo de entender que el de CircleCI. Claro está, esto variará de una
    persona a otra. 
-   La interfaz de Travis parece mucho más robusta mientras que la de CircleCI
    me ha dado pequeños errores temporales, como ejecución del sistema con
    archivos de configuración desactualizados.

Obviamente, estas son impresiones personales que no tienen por qué coincidir con
todo el mundo.

Al final, tanto Travis, como Circle, como cualquier otra plataforma, lo único que
hacen es ejecutar un programa y
en función del código que devuelva, actuar en consecuencia. Cuando un programa
se ha ejecutado correctamente devuelve 0, si ha habido algún tipo de error
devuelve un número diferente a 0. Teniendo esto en mente, podemos ejecutar
cualquier cosa (como en este caso, que estamos levantando un servicio). En otras
palabras, los tests no son nada especial, sigue siendo un proceso que devuelve 0
si todos los tests se han ejecutado correctamente y otro código si ha habido
algún tipo de error.

## API REST
En este apartado veremos los diferentes endpoints de nuestra API REST para saber
como comunicarnos con ella:

### Raíz

#### Recurso URL
-   `GET /`

#### Ejemplo
`curl localhost:9292/`
```json
{
  "status": "http://localhost:9292/status",
  "get_hash": "http://localhost:9292/hash/:type/:plain"
}
```


### Obtener estado del API REST

#### Recurso URL
-   `GET /status`

#### Ejemplo
`curl localhost:9292/status`
```json
{
  "status": "OK"
}
```

### Obtener hash a partir de un texto plano

#### Recurso URL
-   `GET /hash/:type/:plain`

#### Parámetros
| Nombre | Obligatorio | Descripción | Valor por defecto | Ejemplo |
|--------|-------------|-------------|-------------------|---------|
| type | Sí | Tipo de hash que se quiere obtener, actualmente está MD5, SHA1 y SHA256 | | md5 |
| plain | Sí | Texto plano al que se le quiere aplicar la función hash | | helloworld |

#### Resultado
`curl localhost:9292/hash/md5/helloworld`
```json
{
  "type": "md5",
  "plain": "helloworld",
  "hash": "fc5e038d38a57032085441e7fe7010b0"
}
```

### Obtener texto plano a partir de un hash

#### Recurso URL
-   `GET /crack/:hash`

#### Parámetros


| Nombre | Obligatorio | Descripción | Valor por defecto | Ejemplo |
|--------|--------|--------|--------|--------|
| hash | Sí | Hash que se busca | | fc5e038d38a57032085441e7fe7010b0 |


#### Resultado
`curl localhost:9292/crack/fc5e038d38a57032085441e7fe7010b0`
```json
{
  "hash": "fc5e038d38a57032085441e7fe7010b0",
  "plain": "helloworld"
}
```
