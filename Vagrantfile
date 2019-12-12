# -*- mode: ruby -*-
# vi: set ft=ruby :

# Para este archivo de configuración de Vagrant, usaremos la versión 2
Vagrant.configure("2") do |config|
  # Se ha elegido la imagen oficial Ubuntu 18.04 LTS (Bionic). En la
  # documentación se dan más detalles sobre la elección de esta imagen en lugar
  # de otras.
  config.vm.box = "ubuntu/bionic64"

  config.vm.hostname = "alreadycracked"

  # Vagrant comprobará si hay actualizaciones cada vez que se levanta la máquina
  # virtual. Si se encuentra una actualización, se informa al usuario.
  config.vm.box_check_update = true

  # Mapeamos el puerto 8080 de nuestra maquina con el puerto 80 de la máquina
  # virtual. De esta forma podremos acceder de manera cómoda a nuestra API a
  # través de localhost
  config.vm.network "forwarded_port", guest: 9292, host: 9292

  config.vm.network "public_network", bridge: "enp2s0", ip: "192.168.1.252"

  # No necesitamos un directorio compartido para pasar los archivos ya que
  # usaremos git. Para evitar diversos problemas de seguridad, desactivaremos
  # /vagrant ya que se encuentra activa por defecto.
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Como estamos trabajando con una máquina Linux, establecemos que usaremos ssh
  # para comunicarnos. 
  config.vm.communicator = "ssh"

end
