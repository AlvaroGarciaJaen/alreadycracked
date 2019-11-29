# alreadycracked
![GitHub](https://img.shields.io/github/license/AlvaroGarciaJaen/alreadycracked)
[![Build Status](https://travis-ci.com/AlvaroGarciaJaen/alreadycracked.svg?branch=master)](https://travis-ci.com/AlvaroGarciaJaen/alreadycracked)
[![CircleCI](https://circleci.com/gh/AlvaroGarciaJaen/alreadycracked.svg?style=svg)](https://circleci.com/gh/AlvaroGarciaJaen/alreadycracked)

## Descripción
Microservicio escrito en Ruby que recoge hashes de diferentes
algoritmos (MD5, SHA1...) junto con su correspondiente en texto plano. Se podrá
tanto consultar un hash para obtener el texto plano, como añadir aquellas
correspondencias que no se encuentren. De esta manera se pretende que poco a
poco el conjunto de datos vaya creciendo.

Para hacer uso de este microservicio, se implementará un API REST también como
parte de este proyecto. Se espera así que cualquiera pueda desarrollar de manera
fácil y cómoda cualquier tipo de interfaz a partir de este trabajo.

## Instalación
-   Instalar las gemas:
```bash
rake install
```

## Uso
Para hacer uso del servicio web, podemos hacerlo de dos maneras:

### Directamente desde nuestro Linux
-   Iniciar el gestor de tareas (esto inicia el servicio directamente):
```bash
rake init
```

-   Iniciar el servicio web (si el gestor de tareas ya esta activo):
```bash
rake start
```

-   Parar el servicio web:
```bash
rake stop
```

### Contenedor Docker
-   Para iniciar el contenedor de Docker:
```bash
docker run --rm -t -p 9292:80 alvaronetwork/alreadycracked
```

-   Cuando se inicia el servidor, por defecto escucha en el puerto 9292. Puede
consultarse la funcionalidad básica de la siguiente manera:
```bash
curl http://localhost:9292
```

Para más información, consultar la [documentación
adicional](https://alvaro.network/alreadycracked/#api-rest).

## Tests
-   Ejecutar todos los tests:
```bash
rake test
```

## Despliuegue PaaS
-   Actualmente se encuentra desplegado en el PaaS de Azure:
```
Despliegue: https://alreadycracked.azurewebsites.net/
```

-   Para desplegarse:
```bash
rake deploy_az
```

-   Para deshacer el despliegue:
```bash
rake purge_az
```

## Despliegue PaaS con Docker
-   Actualmente se encuentra desplegado en el PaaS de Azure y Heroku
```
Contenedor: https://alreadycracked.azurewebsites.net/
```
```
Despliegue: https://alreadycracked.herokuapp.com/
```

-   Para desplegarse:
```bash
rake deploy_heroku
```

-   Para deshacer el despliegue:
```bash
rake purge_heroku
```

## Documentación adicional
Como herramienta de construcción, se hace uso de:
```
buildtool: Rakefile
```

-   [Descripción](#descripción)
-   [Motivación](#motivación)
-   [Funcionalidad](#funcionalidad)
-   [Implementación](#implementación)
-   [Herramienta de construcción](#herramienta-de-construcción)
-   [Integración continua](#integración-continua)
-   [API REST](#api-rest)
-   [Despliegue PaaS con Docker](#despliegue-paas-con-docker)
