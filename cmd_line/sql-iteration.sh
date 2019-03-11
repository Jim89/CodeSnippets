# Simple script to execute all sql files
# usage build.sh <username> <schema>

# check parameters
if [ -z "$1" ]; then
  echo "Please specify a user"
  exit 1
fi

echo "Running as database user: '$1'"

#-----------------------------


log_date=$(date +"%Y-%m-%d_%H%M%S")
log_path=[LOG FOLDER PATH]/"$log_date"-log.txt
echo Logs in $log_path

start_time=$(date +"%y-%d-%m %T")

for f in $(find [FOLDER PATH] -name '*.sql' | sort)
do
echo
echo Processing $f
echo -------------------------------------------
now=$(date +"%y-%d-%m %T")
echo "Started: $now"
psql --quiet -U $1 -v ON_ERROR_STOP=1 -d [DATABASE NAME] -h [HOST / SERVERNAME] -f $f -L $log_path || exit 1
now=$(date +"%y-%d-%m %T")
echo "Finished: $now"
done

echo
echo ===========================================
echo "Run started:   $start_time"
echo "Run completed: $now"
