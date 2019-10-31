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
Instalar las gemas:
```bash
rake install
```

## Uso
Iniciar el microservicio:
```bash
rake start
```

Cuando se inicia el servidor, por defecto escucha en el puerto 9292. Puede
consultarse la funcionalidad básica de la siguiente manera:
```bash
curl localhost:9292
```

Para más información, consultar la [documentación
adicional](https://alvaro.network/alreadycracked/#api-rest).

Parar el microservicio:
```bash
rake stop
```

## Tests
Ejecutar todos los tests:
```bash
rake test
```

## Documentación adicional
-   [Descripción](https://alvaro.network/alreadycracked/#descripción)
-   [Motivación](https://alvaro.network/alreadycracked/#motivación)
-   [Funcionalidad](https://alvaro.network/alreadycracked/#funcionalidad)
-   [Implementación](https://alvaro.network/alreadycracked/#implementación)
-   [Herramienta de construcción](https://alvaro.network/alreadycracked/#herramienta-de-construcción)
-   [Integración continua](https://alvaro.network/alreadycracked/#integración-continua)
-   [API REST](https://alvaro.network/alreadycracked/#api-rest)
