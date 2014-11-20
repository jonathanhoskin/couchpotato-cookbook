default[:couchpotato][:user] = 'couchpotato'
default[:couchpotato][:group] = 'couchpotato'

default[:couchpotato][:install_dir] = '/srv/apps/couchpotato'
default[:couchpotato][:config_dir] = '/etc/couchpotato'

default[:couchpotato][:git_url] = 'https://github.com/RuudBurger/CouchPotatoServer.git'
default[:couchpotato][:git_ref] = 'master'

default[:couchpotato][:settings] = {
  api_key: 'api_key',
  directory: '/usr/data/downloads',
  ignored_words: '',
  imdb_watchlist: 'http://rss.imdb.com/user/urxxx/watchlist',
  library: [],
  nzbs_api_key: 'nzbz_api_key',
  password: 'encrypted-password',
  port: 3002,
  preferred_words: '',
  sabnzbd_api_key: 'sabnzbd_api_key',
  sabnzbd_url: 'https://localhost:9090',
  ssl_cert: '',
  ssl_key: '',
  themoviedb_api_key: 'themoviedb_api_key',
  transmission_url: 'http://localhost:9091',
  twitter_access_token_key: nil,
  twitter_access_token_secret: nil,
  twitter_username: nil,
  username: 'username'
}
