# working_directory "/app"
#
# pid "/unicorn/pids/unicorn.pid"
#
# stderr_path "/app/log/unicorn.stderr.log"
# stdout_path "/app/log/unicorn.stdout.log"
#
# listen "/unicorn/sockets/unicorn.sock"
# listen 3000
#
# worker_processes 2
#
# timeout 30

working_directory "/app"
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 60
preload_app true

listen '/unicorn/sockets/genero.unicorn.sock'
pid    '/unicorn/pids/genero.unicorn.pid'
# listen 3000

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

stderr_path "/app/log/unicorn.stderr.log"
stdout_path "/app/log/unicorn.stdout.log"
