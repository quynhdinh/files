#!/bin/bash

service="$1"
: ${log:="$service.log"}
if [ "$#" -eq 2 ] 
then
	log="$2"
fi

case $service in
	beta10)
		url="http://10.30.36.10/zalo-ads-beta-logs/"
		if [ "$#" -eq 1 ]; then log="advertiser.log"; fi
		;;

	beta18)
		url="http://10.30.36.18/zalo-ads-beta-logs/"
		if [ "$#" -eq 1 ]; then log="advertiser.log"; fi
		;;

	agent)
		url="http://10.30.36.18/zalo-ads-agent-logs/"
		;;

	ws)
		url="http://10.30.36.18/zalo-ads-webservice-logs/"
		;;

	reportapi)
		url="http://10.30.36.10/zalo-ads-reportapi-logs/"
		;;

	accounting)
		url="http://10.30.36.10/zalo-ads-accounting-logs/"
		;;

	internalreport)
		url="http://10.30.36.10/zalo-ads-internalreport-logs/"
		;;

	*)
		echo "Service doesn't exist."
		EXIT
esac

file=$(mktemp)
trap 'rm $file' EXIT

(while true; do
	wget -ca -o /dev/null -O "$file" "$url$log"
	sleep 2
done) &
pid=$!
trap 'kill $pid; rm $file' EXIT


tail -f -c 102400 "$file" | sed -e 's/\(.*WARN.*\|.*ERROR.*\)/\o033[31m\1\o033[39m/' -e 's/\(INFO\)/\o033[32m\1\o033[39m/'
