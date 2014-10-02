#!/bin/bash

which docker || exit 1

docker events "$@" | while read line
do
  container_id="$(echo $line | sed -e 's/^.*] \(\w*\): .*$/\1/g')"
  event="$(echo $line | sed -e 's/^.* \(\w*\)$/\1/g')"
  case "$event" in
    start)
      container_name="$(docker inspect -f '{{.Name}}' "$container_id" 2> /dev/null)"
      container_ip="$(docker inspect -f '{{.NetworkSettings.IPAddress}}' "$container_id" 2> /dev/null)"
      echo "$container_id: started as $container_name at $container_ip"
      ;;
    destroy)
      echo "$container_id: stopped"
      ;;
  esac
done
