# Elegimos alpine como base para hacerlo lo más pequeño posible
FROM alpine:latest

# Creamos un directorio para la aplicación
RUN mkdir -p /app

# Establecemos el directorio como el espacio de trabajo
WORKDIR /app

# Copiamos el código fuente a la imagen
ADD lib ./lib

# Copiamos nuestro sample.json
ADD t/sample.json ./t/

# Actualizamos los paquetes ya instalados y los repositorios
RUN apk update && apk upgrade

# Instalamos los paquetes necesarios para correr la aplicación
RUN apk add ruby ruby-bundler ruby-dev build-base

# Borramos la cache de apk
RUN rm -rf /var/cache/apk/*

# Instalamos bundler para poder obtener las gemas de ruby directamente desde el
# Gemfile
RUN gem install --no-rdoc --no-ri bundler

# Copiamos el Gemfile
ADD Gemfile* ./

# Instalamos las gemas especificadas en el Gemfile
RUN bundle install

# Copiamos el archivo de configuración de rackup
ADD config.ru .

# Ponemos el valor de PORT a 80 por defecto para levantar el servidor web en el
# puerto 80 dentro del contenedor. Luego el PaaS mapeará el puerto como más le
# interese, pero en principio dentro del contenedor, al ser root, tenemos
# control total.
ENV PORT 80

# Con CMD especificamos el comando por defecto que se ejecutará cuando el
# contenedor se inicia. Lo hacemos en su forma "shell" porque queremos que se
# procese por una shell y reemplaze $PORT por el valor dado anteriormente con la
# orden ENV o luego, en la linea de ejecución del contenedor con -e.
CMD rackup config.ru --host 0.0.0.0 -p $PORT
