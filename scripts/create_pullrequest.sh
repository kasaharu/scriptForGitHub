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
TMP_FILE=~/.gh_message_templates/pull_request_temp.txt
sed -e "s/ticket-no/$ticket_number/g" ~/.gh_message_templates/pull_request.txt > $TMP_FILE

echo 'Exec Pull Request'
hub pull-request --browse -F $TMP_FILE -b kasaharu:master -h kasaharu:$(git rev-parse --abbrev-ref HEAD)

echo 'Delete temporary format file.'
rm $TMP_FILE

