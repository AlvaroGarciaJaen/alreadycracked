God.watch do |w|
  w.name = "alreadycracked"
  w.dir = "."
  w.pid_file = "#{w.name}.pid"
  w.start = "rackup -D config.ru -p 9292 -P #{w.pid_file} --host 0.0.0.0"
  w.keepalive
end
