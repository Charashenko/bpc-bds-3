#!/bin/bash
curDate=`date +'%d-%m-%Y'`
pg_dump -d bds -Fd -f backups/$curDate
