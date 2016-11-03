#!/bin/bash

set -e

if [ -z "$BAYES_ADDRESS" ]; then
  echo "Bayes Database address was not set."
  echo "Set Bayes address to \"BayesDatabase\"."
  BAYES_ADDRESS=BayesDatabase
fi

if [ -z "$BAYES_USER" ]; then
  echo "Bayes Database user was not set."
  exit 1
fi

if [ -z "$BAYES_PASSWORD" ]; then
  echo "Bayes Database password was not set."
  exit 1
fi

if [ -z "$ALLOWED_IP_RANGES" ]; then
  echo "Specify comma seperated authorized networks."
  exit 1
fi

cat <<EOT > /etc/spamassassin/local.cf

required_score 10.0

use_pyzor 1

pyzor_path /usr/bin/pyzor
pyzor_timeout 10

use_bayes 1

bayes_auto_learn 1

#       Set Bayesian store module
bayes_store_module      Mail::SpamAssassin::BayesStore::MySQL
bayes_sql_dsn           DBI:mysql:bayes:$BAYES_ADDRESS:3306

bayes_sql_username      $BAYES_USER
bayes_sql_password      $BAYES_PASSWORD

bayes_sql_override_username bayes

skip_rbl_checks 1
EOT

exec /usr/sbin/spamd \
--ipv4 --allowed-ips=$ALLOWED_IP_RANGES --listen-ip \
--min-children=$MIN_CHILDREN --max-children=$MAX_CHILDREN \
--min-spare=$MIN_SPARE --max-spare=$MAX_SPARE \
--nouser-config --helper-home-dir --syslog-socket=none
