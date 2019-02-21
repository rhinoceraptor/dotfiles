#!/bin/sh

date +%I%M
date +%I%M | awk '
  ($1 < 1230)  && ($1 > 1200) { print "🕛" }
  ($1 < 100)   && ($1 > 30)   { print "🕧" }
  ($1 < 130)   && ($1 > 100)  { print "🕐" }
  ($1 < 200)   && ($1 > 130)  { print "🕜" }
  ($1 < 230)   && ($1 > 200)  { print "🕑" }
  ($1 < 300)   && ($1 > 230)  { print "🕝" }
  ($1 < 330)   && ($1 > 300)  { print "🕒" }
  ($1 < 400)   && ($1 > 330)  { print "🕞" }
  ($1 < 430)   && ($1 > 400)  { print "🕓" }
  ($1 < 500)   && ($1 > 430)  { print "🕟" }
  ($1 < 530)   && ($1 > 500)  { print "🕔" }
  ($1 < 600)   && ($1 > 530)  { print "🕠" }
  ($1 < 630)   && ($1 > 600)  { print "🕕" }
  ($1 < 700)   && ($1 > 630)  { print "🕡" }
  ($1 < 730)   && ($1 > 700)  { print "🕖" }
  ($1 < 800)   && ($1 > 730)  { print "🕢" }
  ($1 < 830)   && ($1 > 800)  { print "🕗" }
  ($1 < 900)   && ($1 > 830)  { print "🕣" }
  ($1 < 930)   && ($1 > 900)  { print "🕘" }
  ($1 < 1000)  && ($1 > 930)  { print "🕤" }
  ($1 < 1030)  && ($1 > 1000) { print "🕙" }
  ($1 < 1100)  && ($1 > 1030) { print "🕥" }
  ($1 < 1130)  && ($1 > 1100) { print "🕚" }
  ($1 <= 1139) && ($1 > 1130) { print "🕦" }'
