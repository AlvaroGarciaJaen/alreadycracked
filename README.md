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
Por el momento, _alreadycracked_ no hace uso de librerías que no formen parte
del core de Ruby. Basta con tener Ruby instalado para usarlo. Se recomienda la
versión latest (2.6.5) de Ruby, pues es la única versión para la que se corren
los tests actualmente.

## Uso
_Aún no está definida la ejecución_

## Tests
```bash
rake
```

## Información adicional
Si quiere consultarse información adicional sobre el proyecto como la
implementación o la toma de decisiones, se han habilitado [gh-pages](https://alvaro.network/alreadycracked).
