#!/bin/sh

ticket_number=$1

if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。"
  echo "引数にチケット番号を渡してください。"
  exit 1
fi

if expr "$ticket_number" : '[0-9]*' > /dev/null ; then
  echo "チケット番号 $ticket_number の Pull Request を作成します。"
else
  echo "チケット番号が不正です。数値を入力してください。"
  exit 1
fi


echo 'Create temporary format file.'
sed -e "s/ticket-no/$ticket_number/g" ~/.pullreqmessage.txt > ~/.pullreqmessage_temp.txt

echo 'Exec Pull Request'
hub pull-request --browse -F ~/.pullreqmessage_temp.txt -b kasaharu:master -h kasaharu:$(git rev-parse --abbrev-ref HEAD)

echo 'Delete temporary format file.'
rm ~/.pullreqmessage_temp.txt

