#========================
#CONFIG
#========================
set :application, "reunion"
set :scm, :git
set :repository, "git@github.com:hayato240/reunion.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true, :port => "10022" }
set :stage, :production
set :user, "nishimaru_hayato"
set :use_sudo, true
set :runner, "deploy"
set :deploy_to, "/data/#{application}"
set :app_server, :puma
set :domain, "172.30.4.124"
set :rails_env, :production
set :puma_pid, "#{current_path}/tmp/pids/server.pid"
set :puma_binary, "puma" 
set :puma_ctl, "pumactl"
set :puma_config, "#{current_path}/config/puma.rb" 
set :puma_state, "#{current_path}/tmp/pids/puma.state"
set :puma_pid, "#{current_path}/shared/tmp/pids/server.pid"
set :rake, "/Users/nishimaru_hayato/.rbenv/shims/rake"

working_directory = Dir.pwd

#directory       working_directory
#bind            "unix:///#{working_directory}/tmp/sockets/puma.sock"


#========================
#ROLES
#========================
role :app, domain
role :web, domain
role :db, domain, :primary => true
#========================
#CUSTOM
#========================
namespace :puma do
  desc "Start Puma"
  task :start, :except => { :no_release => true } do
    # run "cd #{current_path} && sudo rails s -p 80 -e #{rails_env} -d"
    run "cd #{current_path} && RAILS_ENV=production #{puma_binary} -C #{puma_config} -e #{rails_env} -d"
  end
  after "deploy:start", "puma:start"

  desc "Stop Puma"
  task :stop, :except => { :no_release => true } do
    run "cd #{current_path} && pumactl -S #{puma_state} stop || echo 'skip'"
    # run "test -f #{puma_pid} && sudo kill 'cat #{puma_pid}' || echo 'skip'"
    #    run "sudo /usr/local/rbenv/shims/puma stop #{application}"
  end
  after "deploy:stop", "puma:stop"

  desc "Restart Puma"
  task :restart, roles: :app, :expect => { no_release: true } do
    run "cd #{current_path} && pumactl -S #{puma_state} restart || echo 'skip'"
    # stop
    # start
    #    run "sudo /usr/local/rbenv/shims/puma restart #{application}"
  end
  after "deploy:restart", "puma:restart"

  desc "create a shared tmp dir for puma state files"
  task :after_symlink, roles: :app do
    run "sudo rm -rf #{release_path}/tmp"
    run "ln -s #{shared_path}/tmp #{release_path}/tmp"
  end
  after "deploy:create_symlink", "puma:after_symlink"

  desc "boot websocket"
  task :web_socket, roles: :app, :expect => { no_release: true } do
    run "cd #{current_path} && rails runner Cron::WebSocket.web_socket"
  end
=begin
  desc "seed db"
  task :seed, roles: :app do
    run "sudo rake db:seed RAILS_ENV=#{rails_env}"
  end
  after "seeds:db"
=end
end
