#!/bin/bash


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

  elif [[ "$UNAME" =~ .*"Darwin".* ]]; then
    POWER=$(pmset -g batt)
    PERCENTAGE=$(echo "$POWER" | grep -oE "[0-9]{2,3}%")
    STATE=$(pmset -g batt | grep -q "Battery Power" && echo "$BATTERY" || echo "$CHARGER")
  fi

  if [ -n "$PERCENTAGE" ] && [ -n "$STATE" ]; then
    BATTERY_LOW="#[bg=#e06c75]#[fg=#2a2f39]"
    BATTERY_MED="#[bg=#e5c07b]#[fg=#2a2f39]"
    BATTERY_HIGH="#[bg=#98c379]#[fg=#2a2f39]"
    PLUGGED_IN="#[bg=#fafafa]#[fg=#383a42]"

    case $PERCENTAGE in
      100%|9[0-9]%|8[0-9]%|7[0-9]%) COLOR="$BATTERY_HIGH"
        ;;

      6[0-9]%|5[0-9]%|4[0-9]%|3[0-9]%) COLOR="$BATTERY_MED"
        ;;

      2[0-9]%|1[0-9]%|[0-9]%) COLOR="$BATTERY_LOW"
        ;;
    esac

    printf "%s " "$COLOR $PERCENTAGE $STATE #[default]"
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
  test
  battery

  if type "warp-cli" &> /dev/null; then
    warp_status
  fi

  date_time
}

main
