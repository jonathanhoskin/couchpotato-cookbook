service 'couchpotato'

user node[:couchpotato][:user] do
  system true
  shell '/bin/bash'
  home node[:couchpotato][:install_dir]
end

app_dirs = [
  node[:couchpotato][:install_dir],
  node[:couchpotato][:config_dir]
]

app_dirs.each do |dir|
  directory dir do
    recursive true
    mode 0755
    owner node[:couchpotato][:user]
    group node[:couchpotato][:group]
  end
end

git node[:couchpotato][:install_dir] do
  repository node[:couchpotato][:git_url]
  reference node[:couchpotato][:git_ref]
  action :checkout
  checkout_branch(node[:couchpotato][:git_ref]) unless node[:couchpotato][:git_ref] == 'master'
  enable_checkout node[:couchpotato][:git_ref] != 'master'
  user node[:couchpotato][:user]
  group node[:couchpotato][:group]
  notifies :restart, 'service[couchpotato]'
end

template ::File.join(node[:couchpotato][:config_dir], 'settings.conf') do
  source 'settings.conf.erb'
  owner node[:couchpotato][:user]
  group node[:couchpotato][:group]
  variables(
    api_key: node[:couchpotato][:settings][:api_key],
    blackhole_enabled: node[:couchpotato][:settings][:blackhole_enabled],
    directory: node[:couchpotato][:settings][:directory],
    ignored_words: node[:couchpotato][:settings][:ignored_words],
    imdb_watchlist: node[:couchpotato][:settings][:imdb_watchlist],
    library: node[:couchpotato][:settings][:library],
    nzbs_api_key: node[:couchpotato][:settings][:nzbs_api_key],
    password: node[:couchpotato][:settings][:password],
    plex_enabled: node[:couchpotato][:settings][:plex_enabled],
    port: node[:couchpotato][:settings][:port],
    preferred_words: node[:couchpotato][:settings][:preferred_words],
    sabnzbd_api_key: node[:couchpotato][:settings][:sabnzbd_api_key],
    sabnzbd_url: node[:couchpotato][:settings][:sabnzbd_url],
    sabnzbd_ssl: node[:couchpotato][:settings][:sabnzbd_ssl],
    ssl_cert: node[:couchpotato][:settings][:ssl_cert],
    ssl_key: node[:couchpotato][:settings][:ssl_key],
    suggestion_enabled: node[:couchpotato][:settings][:suggestion_enabled],
    themoviedb_api_key: node[:couchpotato][:settings][:themoviedb_api_key],
    transmission_enabled: node[:couchpotato][:settings][:transmission_enabled],
    transmission_password: node[:couchpotato][:settings][:transmission_password],
    transmission_url: node[:couchpotato][:settings][:transmission_url],
    transmission_username: node[:couchpotato][:settings][:transmission_username],
    twitter_access_token_key: node[:couchpotato][:settings][:twitter_access_token_key],
    twitter_access_token_secret: node[:couchpotato][:settings][:twitter_access_token_secret],
    twitter_enabled: node[:couchpotato][:settings][:twitter_enabled],
    twitter_username: node[:couchpotato][:settings][:twitter_username],
    url_base: node[:couchpotato][:settings][:url_base],
    username: node[:couchpotato][:settings][:username]
  )
  notifies :restart, 'service[couchpotato]'
end

link '/etc/init.d/couchpotato' do
  to ::File.join(node[:couchpotato][:install_dir], 'init/ubuntu')
  notifies :run, 'execute[couchpotato rc.d]'
end

template '/etc/default/couchpotato' do
  source 'default.erb'
  variables(
    user: node[:couchpotato][:user],
    home: node[:couchpotato][:install_dir],
    data: node[:couchpotato][:config_dir]
  )
  notifies :restart, 'service[couchpotato]'
end

execute 'couchpotato rc.d' do
  command 'update-rc.d couchpotato defaults'
  not_if { 'update-rc.d -n couchpotato defaults | grep "already existd"' }
end
