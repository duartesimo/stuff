#!/usr/bin/env bash
HOST=${1:-127.0.0.1}
PORT=${2:-6667}
PASS=${3:-mypass}
TARGET=${4:-alice}

if nc -h 2>&1 | grep -q -- '-q'; then
  CLOSE="-q 0"
elif nc -h 2>&1 | grep -q -- '-N'; then
  CLOSE="-N"
else
  CLOSE=""
fi

{
	printf 'PASS %s\r\n' "$PASS"
	sleep 0.2
	printf 'NICK partial\r\n'
	sleep 0.2
	printf 'USER partial 0 * :Partial Tester\r\n'
	sleep 0.5

	printf 'PRIVMSG %s' "$TARGET"
	sleep 0.5
	printf ' :hello'
	sleep 0.5
	printf ' there from partial test\r\n'
	sleep 0.5
} | nc $CLOSE "$HOST" "$PORT"
