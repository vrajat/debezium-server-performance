#!/bin/bash
set -x
set -e 

FILE=$PWD/settings.env

if test -f "$FILE"; then
    export $(grep -v '^#' $FILE | xargs)
fi

export PATH=$PATH:$YBPATH

ysqlsh -f ysql_schema.sql 
yb-admin create_change_data_stream ysql.yugabyte --master_addresses $PGHOST:7100

