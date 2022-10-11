#!/bin/bash

function bar() {
  printf "%s" " | "
}

function battery() {
  BATTERY="🔋️"
  CHARGER="🔌️"
  UNAME=$(uname -a)

  if [[ "$UNAME" =~ .*"Linux".* ]]; then
    UPOWER=$(upower -i `upower -e | grep 'BAT'`)

    function getfield() {
      echo "$UPOWER" | awk -v field="$1" 'match($0, field) { print $2 };'
    }

    PERCENTAGE=$(getfield "percentage")
    STATE=$([[ `getfield "state"` =~ .*"discharging".* ]] \
      && echo "$BATTERY" \
      || echo "$CHARGER")

    printf "%s %s" "$PERCENTAGE" "$STATE"
  fi
}

function warp_status() {
  if ! type "warp-cli" &> /dev/null; then return; fi
  if [[ "$(warp-cli status)" =~ .*"Connected".* ]]; then
    printf "%s" "Warp: ✅️"
  else
    printf "%s" "Warp: ❌️"
  fi
}

function date_time() {
  printf "%s" "$(date +'%a %b %d %I:%M %p') "
}

function main() {
  bar
  battery

  if type "warp-cli" &> /dev/null; then
    bar
    warp_status
  fi

  bar
  date_time
}

main
