" Minimal runtimepath setup for running the envrun tests headless.
" Loads ONLY plenary + this repo's lua/, NOT the full lazy config.
" Paths come from env vars (set by CI) with local fallbacks.
let s:repo    = getenv('ENVRUN_REPO')
let s:plenary = getenv('ENVRUN_PLENARY')
let s:repo    = type(s:repo) == v:t_string && !empty(s:repo) ? s:repo : getenv('HOME') . '/.config/nvim'
let s:plenary = type(s:plenary) == v:t_string && !empty(s:plenary) ? s:plenary : getenv('HOME') . '/.local/share/nvim/lazy/plenary.nvim'
execute 'set runtimepath^=' . s:repo
execute 'set runtimepath^=' . s:plenary
runtime! plugin/plenary.vim
