#!/bin/bash

which docker || exit 1

function event_loop () {
  while read line; do
    container_id="$(echo $line | sed -e 's/^.*] \(\w*\): .*$/\1/g')"
    event="$(echo $line | sed -e 's/^.* \(\w*\)$/\1/g')"
    case "$event" in
      start)
        container_name="$(docker inspect -f '{{.Name}}' "$container_id" 2> /dev/null)"
        container_ip="$(docker inspect -f '{{.NetworkSettings.IPAddress}}' "$container_id" 2> /dev/null)"
        container_start
        ;;
      destroy)
        container_stop
        ;;
    esac
  done
}

function container_start () {
  echo "$container_id: started as $container_name at $container_ip"
}

function container_stop () {
  echo "$container_id: stopped"
}

docker events "$@" | event_loop
