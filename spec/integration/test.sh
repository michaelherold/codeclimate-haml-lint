#!/bin/bash

repos=(
  Courseware/coursewa.re
  DarthMax/Motrackt
  DefactoSoftware/Hours
  Gargron/mastodon
  diaspora/diaspora
  JoePym/UndergroundFootball
  KPSU/kpsu.org
  ManageIQ/manageiq-ui-classic
  assemblymade/coderwall
  coderwall/coderwall-next
  comfy/comfortable-mexican-sofa
  gitlabhq/gitlab-ci
  rubycentral/cfp-app
  sunlightlabs/opencongress
  switchboard/switchboard
  teambox/teambox
  thoughtbot/hound
  OakCH/scheduler
  TAnarchy/rubrik
  YouthTree/big-help-mob
  adamklawonn/CityCircles
  afternoonrobot/photographer-io
  alg/family_hut
  amirci/zenboard
  andresmb/reclutamiento
  andrewroth/project_application_tool
  appelier/bigtuna
  arailsdemo/arailsdemo2
  asalant/freehub
  EOL/eol
)

failure () {
  local msg=$1

  printf "\e[31m%s\e[39m\n" "$msg"
}

header () {
  local msg=$1

  printf "\n\e[33m%s\e[39m\n" "$msg"
}

message () {
  local msg=$1

  printf "%s\n" "$msg"
}

success () {
  local msg=$1

  printf "\e[32m%s\e[39m\n" "$msg"
}

test_repository () {
  local repo=$1
  local base
  local dir

  base=$(pwd)
  dir=tmp/$(basename "$repo")

  header "Testing $repo"

  if [ ! -d "$dir" ]; then
    echo -n "  Cloning repository ... "
    (git clone "https://github.com/${repo}.git" "${dir}" >/dev/null 2>&1 && success "Finished!") || failure "Could not clone"
  else
    message "  Repository already exists"
  fi

  cd "${dir}" || return
  write_config_file

  echo -n "  Running engine ... "
  (codeclimate analyze -e sass-lint --dev >/dev/null 2>&1 && success "Passed!") || failure "Failed!"

  cd "${base}" || return
}

write_config_file () {
  if [ ! -f .codeclimate.yml ] || ! grep -q haml-lint .codeclimate.yml; then
    message "  Writing Code Climate configuration"
    cat <<EOF > .codeclimate.yml
engines:
  haml-lint:
    enabled: true
EOF
  else
    message "  Code Climate configuration exists"
  fi
}

trap 'failure "Interrupted!" && exit 0' SIGINT

for repo in "${repos[@]}"; do
  mkdir -p tmp/
  test_repository "$repo"
done
