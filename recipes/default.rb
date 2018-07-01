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
    debug: node[:couchpotato][:settings][:debug],
    directory: node[:couchpotato][:settings][:directory],
    ignored_words: node[:couchpotato][:settings][:ignored_words],
    imdb_automation_enabled: node[:couchpotato][:settings][:imdb_automation_enabled],
    imdb_automation_urls_use: node[:couchpotato][:settings][:imdb_automation_urls_use],
    imdb_watchlist: node[:couchpotato][:settings][:imdb_watchlist],
    library: node[:couchpotato][:settings][:library],
    newznab_enabled: node[:couchpotato][:settings][:newznab_enabled],
    newznab_api_key: node[:couchpotato][:settings][:newznab_api_key],
    newznab_host: node[:couchpotato][:settings][:newznab_host],
    password: node[:couchpotato][:settings][:password],
    permission_file: node[:couchpotato][:settings][:permission_file],
    permission_folder: node[:couchpotato][:settings][:permission_folder],
    plex_auth_token: node[:couchpotato][:settings][:plex_auth_token],
    plex_enabled: node[:couchpotato][:settings][:plex_enabled],
    plex_password: node[:couchpotato][:settings][:plex_password],
    plex_username: node[:couchpotato][:settings][:plex_username],
    port: node[:couchpotato][:settings][:port],
    preferred_words: node[:couchpotato][:settings][:preferred_words],
    rarbg_enabled: node[:couchpotato][:settings][:rarbg_enabled],
    rarbg_min_seeders: node[:couchpotato][:settings][:rarbg_min_seeders],
    renamer_nfo_name: node[:couchpotato][:settings][:renamer_nfo_name],
    renamer_from: node[:couchpotato][:settings][:renamer_from],
    renamer_file_name: node[:couchpotato][:settings][:renamer_file_name],
    renamer_enabled: node[:couchpotato][:settings][:renamer_enabled],
    renamer_to: node[:couchpotato][:settings][:renamer_to],
    renamer_rename_nfo: node[:couchpotato][:settings][:renamer_rename_nfo],
    renamer_cleanup: node[:couchpotato][:settings][:renamer_cleanup],
    renamer_separator: node[:couchpotato][:settings][:renamer_separator],
    renamer_folder_name: node[:couchpotato][:settings][:renamer_folder_name],
    renamer_foldersep: node[:couchpotato][:settings][:renamer_foldersep],
    sabnzbd_api_key: node[:couchpotato][:settings][:sabnzbd_api_key],
    sabnzbd_remove_complete: node[:couchpotato][:settings][:sabnzbd_remove_complete],
    sabnzbd_url: node[:couchpotato][:settings][:sabnzbd_url],
    sabnzbd_ssl: node[:couchpotato][:settings][:sabnzbd_ssl],
    searcher_preferred_method: node[:couchpotato][:settings][:searcher_preferred_method],
    smtp_enabled: node[:couchpotato][:settings][:smtp_enabled],
    smtp_from: node[:couchpotato][:settings][:smtp_from],
    smtp_to: node[:couchpotato][:settings][:smtp_to],
    smtp_server: node[:couchpotato][:settings][:smtp_server],
    smtp_user: node[:couchpotato][:settings][:smtp_user],
    smtp_pass: node[:couchpotato][:settings][:smtp_pass],
    smtp_port: node[:couchpotato][:settings][:smtp_port],
    subtitle_enabled: node[:couchpotato][:settings][:subtitle_enabled],
    subtitle_force: node[:couchpotato][:settings][:subtitle_force],
    subtitle_languages: node[:couchpotato][:settings][:subtitle_languages],
    ssl_cert: node[:couchpotato][:settings][:ssl_cert],
    ssl_key: node[:couchpotato][:settings][:ssl_key],
    suggestion_enabled: node[:couchpotato][:settings][:suggestion_enabled],
    themoviedb_api_key: node[:couchpotato][:settings][:themoviedb_api_key],
    transmission_directory: node[:couchpotato][:settings][:transmission_directory],
    transmission_enabled: node[:couchpotato][:settings][:transmission_enabled],
    transmission_password: node[:couchpotato][:settings][:transmission_password],
    transmission_url: node[:couchpotato][:settings][:transmission_url],
    transmission_username: node[:couchpotato][:settings][:transmission_username],
    twitter_access_token_key: node[:couchpotato][:settings][:twitter_access_token_key],
    twitter_access_token_secret: node[:couchpotato][:settings][:twitter_access_token_secret],
    twitter_enabled: node[:couchpotato][:settings][:twitter_enabled],
    twitter_username: node[:couchpotato][:settings][:twitter_username],
    url_base: node[:couchpotato][:settings][:url_base],
    username: node[:couchpotato][:settings][:username],
    webhook_enabled: node[:couchpotato][:settings][:webhook_enabled],
    webhook_on_snatch: node[:couchpotato][:settings][:webhook_on_snatch],
    webhook_url: node[:couchpotato][:settings][:webhook_url]
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
