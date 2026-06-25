#!/bin/bash

export PATH=/opt/mssql-tools18/bin:${PATH}

export RETCODE=0
export WARNING_MSG="WARNING - "
export CRITICAL_MSG="CRITICAL - "
export OK_MSG="OK - "

#DEFAULT EXIT CODE
export STATE_OK=0
export STATE_CRITICAL=2
export STATE_WARNING=1

#DEFAULT THRESHOLD
export WARNING_THRESHOLD=80
export CRITICAL_THRESHOLD=90


while getopts :m:h:u:p:w:c: OPTION
        do
         case "$OPTION" in
          m) export MODE=$OPTARG
             ;;
          h) export HOST_NAME_TO_CHECK=$OPTARG
             ;;
          u) export USERNAME=$OPTARG
             ;;
          p) export PASSWORD=$OPTARG
             ;;
	  w) export WARNING_THRESHOLD=$OPTARG
             ;;
          c) export CRITICAL_THRESHOLD=$OPTARG
             ;;
          :) echo "$0: $OPTARG option missing argument!"
             exit 2 ;;
          ?)  echo Invalid Option $"Usage: "
              echo "-m check_connect -h HOSTNAME -u USERNAME -p PASSWORD"
              echo "-m check_database_online -h HOSTNAME -u USERNAME -p PASSWORD"
              echo "-m check_database_sqlexpress_space_used -h HOSTNAME -u USERNAME -p PASSWORD -w WARNING MB -c WARNING MB"
              exit 1
         esac
done

fct_check_connect(){
RESULT=`sqlcmd -U ${USERNAME} -S ${HOST_NAME_TO_CHECK} -P ${PASSWORD} -C -Q "select 'OK'" -h-1 -W -w 999 -s"," | grep -v "affected"`
if [ `echo ${RESULT} | grep "OK" | wc -l` -eq 1 ]
	then
           echo "OK - Success to connect over ${HOST_NAME_TO_CHECK}"
		   exit ${STATE_OK}
		else
            echo "CRITICAL - Failed to connect over ${HOST_NAME_TO_CHECK}"
            exit ${STATE_CRITICAL}
fi
}

fct_check_database_online(){
RESULT=`sqlcmd -U ${USERNAME} -S ${HOST_NAME_TO_CHECK} -P ${PASSWORD} -C -Q "select 'FAILED',name,state_desc from sys.databases where state_desc<>'ONLINE'" -h-1 -W -w 999 -s"," | grep -v "affected"`
if [ `echo ${RESULT} | grep "FAILED" | wc -l` -eq 0 ]
        then
           echo "OK - All MSSQL databases from ${HOST_NAME_TO_CHECK} was ONLINE"
                   exit ${STATE_OK}
                else
            echo "CRITICAL - Databases Offline Detected from ${HOST_NAME_TO_CHECK} 
	    `sqlcmd -U ${USERNAME} -S ${HOST_NAME_TO_CHECK} -P ${PASSWORD} -C -Q "select name,state_desc from sys.databases where state_desc<>'ONLINE'" -h-1 -W -w 999 -s"," | grep -v "affected"`"
            exit ${STATE_CRITICAL}
fi
}

fct_check_database_sqlexpress_space_used(){
RESULT=`sqlcmd -U ${USERNAME} -S ${HOST_NAME_TO_CHECK} -P ${PASSWORD} -C -Q "
DECLARE @command varchar(1000)
SELECT @command = 'USE [?]
SELECT  ''DBNAME'' + SD.name,
CONVERT(decimal(10), (CAST(FILEPROPERTY(DF.name, ''SpaceUsed'') AS INT)/128.0 ) ) AS UsedSpaceMB
FROM sys.master_files MF JOIN sys.databases SD
ON SD.database_id = MF.database_id
JOIN sys.database_files DF
ON DF.physical_name COLLATE French_CI_AS = MF.physical_name COLLATE French_CI_AS
WHERE MF.type = 0'
EXEC sp_MSforeachdb @command
" -h-1 -W -w 999 -s"," | egrep -v "affected|master|tempdb|model|msdb"`

for line in `echo $RESULT | sed 's|DBNAME|\n|'`
do
        export DBNAME=`echo $line | cut -d "," -f1`
        export SIZE_USED=`echo $line | cut -d "," -f2`
        PERF=`echo ${PERF} \'${DBNAME}\'=${SIZE_USED}MB`


        if [[ "${SIZE_USED}" -gt "$CRITICAL_THRESHOLD" ]]; then
			echo $SIZE_USED $CRITICAL_THRESHOLD CRITICAL
                        DB_CRITICAL=`echo ${DB_CRITICAL} ${line}MB /`
                elif [[ "${SIZE_USED}" -gt "$WARNING_THRESHOLD" ]]; then
			echo $SIZE_USED  $WARNING_THRESHOLD WARNING
                        DB_WARNING=`echo ${DB_WARNING} ${line}MB /`
                else
                        DB_OK=`echo ${TBS_OK} ${line} /`
        fi
done


if [ ! -z "${DB_CRITICAL}" ]
then
        echo "CRITICAL - Database usage critical: ${DB_CRITICAL} Warning:${DB_WARNING} |${PERF};"
        exit $STATE_CRITICAL
        else
                if [ -z "${DB_WARNING}" ]
                        then
                                echo "OK - Database usage ok |${PERF};"
                                exit $STATE_OK
                        else
                                echo "WARNING - Database usage warning: ${DB_WARNING} |${PERF};"
                                exit $STATE_WARNING
                fi
fi

}


case "${MODE}" in
        check_connect)
                fct_check_connect
                ;;
        check_database_online)
                fct_check_database_online
                ;;
	check_database_sqlexpress_space_used)
                fct_check_database_sqlexpress_space_used
                ;;
        *)
                echo Invalid Option $"Usage: "
		echo "-m check_connect -h HOSTNAME -u USERNAME -p PASSWORD"
                echo "-m check_database_online -h HOSTNAME -u USERNAME -p PASSWORD"
                echo "-m check_database_sqlexpress_space_used -h HOSTNAME -u USERNAME -p PASSWORD -w WARNING MB -c WARNING MB"
                exit 1
esac
