#!/usr/bin/env bash

function replace {
  if [ $# -ne 3 ]; then
    echo "Usage: $ replace [directory] [search string] [replacement string]"
    exit 1
  fi

  find $1 -type f -exec sed -i '' "s/$2/$3/g" "{}" +;
}

