namespace :production do
  desc "Push to Joyent production environment"
  task :deploy do
    ssh_command = "ssh hih_joyent"
    user        = "hihadmin"
    branch      = "master"
    revision    = ENV["revision"] || "HEAD"
    application = "tgsf"
    env         = "production"
    port        = "10062"


    puts "updating application"
    %x{#{ssh_command} "cd ~/sites/#{application}/#{env} && git checkout master && git pull origin master"}

    puts "linking database.yml"
    %x{#{ssh_command} "ln -nfs ~/sites/#{application}/shared/config/database_#{env}.yml ~/sites/#{application}/#{env}/config/database.yml"}

    puts "linking log directory"
    %x{#{ssh_command} "ln -nfs ~/sites/#{application}/shared/log ~/sites/#{application}/#{env}/log"}

    puts "running rake db:migrate"
    %x{#{ssh_command} "cd ~/sites/#{application}/#{env} && rake db:migrate RAILS_ENV=#{env}"}

    puts "stopping mongrel"
    %x{#{ssh_command} "/usr/local/bin/mongrel_rails stop -P /users/home/hihadmin/var/run/mongrel-#{application}_#{env}-#{port}.pid"}

    puts "starting mongrel"
    %x{#{ssh_command} "/usr/local/bin/mongrel_rails start -c /users/home/hihadmin/sites/#{application}/#{env} -p #{port} -d -e #{env} -a 127.0.0.1 -P /users/home/hihadmin/var/run/mongrel-#{application}_#{env}-#{port}.pid"}
  end
end

namespace :production do
  desc "Restart Joyent production environment"
  task :restart do
    ssh_command = "ssh hih_joyent"
    application = "tgsf"
    env         = "production"
    port        = "10062"

    puts "stopping mongrel"
    %x{#{ssh_command} "/usr/local/bin/mongrel_rails stop -P /users/home/hihadmin/var/run/mongrel-#{application}_#{env}-#{port}.pid"}


    puts "starting mongrel"
    %x{#{ssh_command} "/usr/local/bin/mongrel_rails start -c /users/home/hihadmin/sites/#{application}/#{env} -p #{port} -d -e #{env} -a 127.0.0.1 -P /users/home/hihadmin/var/run/mongrel-#{application}_#{env}-#{port}.pid"}
  end
end

namespace :github do
  desc "Push to Joyent production environment"
  task :update do
    ssh_command = "ssh hih_joyent"
    user        = "hihadmin"
    branch      = "master"
    revision    = ENV["revision"] || "HEAD"
    application = "tgsf"
    env         = "production"
    port        = "10062"



    unless comment = ENV["c"]
      puts "you must provide a comment"
    else
      puts "moving to wripple directory"
      %w{wrpl}

      puts "updating modified files"
      %x{git diff}

      puts "adding new files"
      %x{git add *}

      puts "committing files with message: '#{comment}'"
      %x{git commit -a -m "#{comment}"}

      puts "pushing to github"
      %x{git push github master}

      puts "github update complete!"

      puts "updating application on Joyent"
      %x{#{ssh_command} "cd ~/sites/#{application}/#{env} && git checkout master && git pull origin master"}

      puts "linking database.yml"
      %x{#{ssh_command} "ln -nfs ~/sites/#{application}/shared/config/database_#{env}.yml ~/sites/#{application}/#{env}/config/database.yml"}

      puts "linking log directory"
      %x{#{ssh_command} "ln -nfs ~/sites/#{application}/shared/log ~/sites/#{application}/#{env}/log"}

      puts "running rake db:migrate"
      %x{#{ssh_command} "cd ~/sites/#{application}/#{env} && rake db:migrate RAILS_ENV=#{env}"}

      puts "stopping mongrel"
      %x{#{ssh_command} "/usr/local/bin/mongrel_rails stop -P /users/home/hihadmin/var/run/mongrel-#{application}_#{env}-#{port}.pid"}

      puts "starting mongrel"
      %x{#{ssh_command} "/usr/local/bin/mongrel_rails start -c /users/home/hihadmin/sites/#{application}/#{env} -p #{port} -d -e #{env} -a 127.0.0.1 -P /users/home/hihadmin/var/run/mongrel-#{application}_#{env}-#{port}.pid"}
    end
  end
end