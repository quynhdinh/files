RED='\033[0;31m'
NC='\033[0m' # No Color

log=1
if [ "$#" -eq 1 ]
then
        log="$1"
fi
curl http://10.30.36.10/zalo-ads-beta-logs/ -s | grep -o -P 'advertiser.out.{0,20}' | sort --unique | tail -"${log}"
echo ''
filename=$(curl http://10.30.36.10/zalo-ads-beta-logs/ -s | grep -o -P 'advertiser.out.{0,20}' | sort --unique | tail -"${log}" | head -1)
echo -e "${RED}$filename ${NC}"

curl -s "http://10.30.36.10/zalo-ads-beta-logs/$filename" | egrep --color=always '^|git.commit'