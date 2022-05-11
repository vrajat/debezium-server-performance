#!/bin/bash
set -x
set -e 

FILE=$PWD/settings.env

if test -f "$FILE"; then
    export $(grep -v '^#' $FILE | xargs)
fi

export PATH=$PATH:$YBPATH

ysqlsh -f ysql_drop_tables.sql
yb-admin --master_addresses $MASTER_ADDRESSES delete_change_data_stream $CDC_SDK_STREAM_ID

ysqlsh -f ysql_schema.sql 
yb-admin create_change_data_stream ysql.yugabyte --master_addresses $MASTER_ADDRESSES

