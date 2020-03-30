#!/bin/sh

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "Setting user in /etc/passwd..."
    echo "${USER_NAME:-git}:x:$(id -u):0:${USER_NAME:-git} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

id
whoami
