path = require 'path'
{exec} = require 'child_process'

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


open_term = (base_dir) ->
  command = 'termite' if is_linux
  command = "open -a Terminal #{base_dir}" if is_mac
  exec command, cwd: base_dir, (err, stdout, stderr) ->
    if stdout then console.log 'stdout:', stdout
    if stderr then console.log 'stderr:', stderr
    if err then console.log 'exec error:', err

atom.commands.add 'atom-workspace',
  'mb:terminal': ->
    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer?.file
    filepath = file?.path
    if filepath
      open_term path.dirname(filepath)

  'mb:root-terminal': ->
    open_term pathname for pathname in atom.project.getPaths()
