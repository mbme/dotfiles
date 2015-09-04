path = require 'path'

ATOM_HOME = path.dirname atom.config.getUserConfigPath()

is_platform = (name) -> document.body.classList.contains("platform-#{name}")

is_linux = is_platform 'linux'
is_mac = is_platform 'darwin'
is_win = is_platform 'win32'

MAC_CONFIG =
  editor:
    fontFamily: 'Menlo'

local_config_set = (key, val, scopeSelector = '*') ->
  atom.config.set key, val,
  source: path.join(ATOM_HOME, 'local-config.cson')
  scopeSelector: scopeSelector

apply_config = (config) ->
  for own namespace, namespace_config of config
    for own key, value of namespace_config
      local_config_set "#{namespace}.#{key}", value

if is_mac
  apply_config MAC_CONFIG
