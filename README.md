couchpotato Cookbook
===================
Installs [couchpotato](https://couchpota.to) and its required dependencies.

Requirements
------------
#### python
Python is required. It is set up as a dependency of this cookbook so it will be handled automatically.

#### git
The code is being synced from github. Git is required for checking out the code.

Attributes
----------
#### couchpotato::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['couchpotato']['user']</tt></td>
    <td>String</td>
    <td>User which couchpotato will be ran as</td>
    <td>couchpotato</td>
  </tr>
  <tr>
    <td><tt>['couchpotato']['group']</tt></td>
    <td>String</td>
    <td>Group which owns the couchpotato installation</td>
    <td>couchpotato</td>
  </tr>
  <tr>
    <td><tt>['couchpotato']['install_dir']</tt></td>
    <td>String</td>
    <td>Directory where couchpotato will be installed</td>
    <td>/srv/apps/couchpotato</td>
  </tr>
  <tr>
    <td><tt>['couchpotato']['config_dir']</tt></td>
    <td>String</td>
    <td>Configuration directory</td>
    <td>/etc/couchpotato</td>
  </tr>
  <tr>
    <td><tt>['couchpotato']['git_url']</tt></td>
    <td>String</td>
    <td>Git repository which will be checked out</td>
    <td>https://github.com/RuudBurger/CouchPotatoServer.git</td>
  </tr>
  <tr>
    <td><tt>['couchpotato']['git_ref']</tt></td>
    <td>String</td>
    <td>Git branch which will be checked out</td>
    <td>master</td>
  </tr>
  <tr>
    <td><tt>['couchpotato']['settings']</tt></td>
    <td>Hash</td>
    <td>Configuration options. Feel free to create a pull request for more custom options.</td>
    <td>
      <ul>
        <li><tt>api_key</tt></li>
        <li><tt>directory</tt></li>
        <li><tt>ignored_words</tt></li>
        <li><tt>imdb_watchlist</tt></li>
        <li><tt>library</tt></li>
        <li><tt>nzbs_api_key</tt></li>
        <li><tt>password</tt></li>
        <li><tt>port</tt></li>
        <li><tt>preferred_words</tt></li>
        <li><tt>sabnzbd_api_key</tt></li>
        <li><tt>sabnzbd_url</tt></li>
        <li><tt>ssl_cert</tt></li>
        <li><tt>ssl_key</tt></li>
        <li><tt>themoviedb_api_key</tt></li>
        <li><tt>transmission_url</tt></li>
        <li><tt>twitter_access_token_key</tt></li>
        <li><tt>twitter_access_token_secret</tt></li>
        <li><tt>twitter_username</tt></li>
        <li><tt>username</tt> </li>
      </ul>
    </td>
  </tr>
</table>

Usage
-----
#### couchpotato::default

It installs couchpotato by checking it out from source.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
