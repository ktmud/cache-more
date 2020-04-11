#!/bin/bash
# -----------------------------------------------
# Predefined command shortcuts
# -----------------------------------------------
bashSource=${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]:-${(%):-%x}}
cacheScript="$(dirname $(dirname $(dirname $bashSource)))/dist/scripts/cache"

print-cachescript-path() {
  echo $cacheScript
}

cache-save() {
  node $cacheScript restore $1
}

cache-restore() {
  node $cacheScript save $1
}

# install python packages
pip-install() {
  cache-restore pip
  pip install -r requirements*.txt
  cache-save pip
}

# install npm packages
npm-install() {
  echo "npm: $(npm --version)"
  echo "node: $(node --version)"
  cache-restore npm
  npm ci
  cache-save npm
}

# default setup will install both pip and npm pacakges at the same time
default-setup-command() {
  pip-install & npm-install
}
