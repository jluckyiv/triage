worker_processes 4

# APP_PATH = "/var/web/triage/rails"
APP_PATH = File.expand_path('..', File.dirname(__FILE__))
puts APP_PATH
working_directory APP_PATH # available in 0.94.0+

listen APP_PATH + "/tmp/pid/.unicorn.sock", :backlog => 64
# listen 8080, :tcp_nopush => true

timeout 30

pid APP_PATH + "/tmp/pid/unicorn.pid"

stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

end

after_fork do |server, worker|

  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)
end
