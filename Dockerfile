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

# Indicamos que el servicio (dentro del contenedor) estará escuchando en el
# puerto 80 y que además, al ser un servicio web, sera tcp
EXPOSE 80/tcp

# Copiamos el archivo de configuración de rackup
ADD config.ru .

# Al iniciar el contenedor, se ejecutará la siguiente orden (dentro del
# contenedor no usaremos god ya que el PaaS se encargará de la gestión de
# tareas. Además, al estar el servicio "envuelto" en un contenedor, no es
# necesario que nos preocupamos por como se gestiona la tarea)
CMD ["rackup", "config.ru", "--host", "0.0.0.0", "-p", "80"]
