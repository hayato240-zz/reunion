#rails_env = ENV['RAILS_ENV'] || 'production'

threads 4,4

pidfile "/tmp/pids/puma.pid"
bind 'unix://tmp/puma.sock'
state_path "/tmp/pids/puma.state"
activate_control_app