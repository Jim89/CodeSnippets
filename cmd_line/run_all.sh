# Simple script to execute all sql files
# usage build.sh <username> <schema>

# check parameters
if [ -z "$1" ]; then
  echo "Please specify a user"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Please specify a schema"
  exit 1
fi

echo "Running as database user: '$1'"
echo "Running on schema: '$2'"

#-----------------------------


echo Logs in logs/log.txt

start_time=$(date +"%y-%d-%m %T")

echo ------------------------------------------
echo "Building and selecting the schema..."

schema="$2"
schema_qry="drop schema if exists ${schema} cascade;
create schema ${schema}; "
psql --quiet -d [database] -U $1 -h [server] -L logs/log.txt -c "${schema_qry}"

echo "done."

for f in $(find . -name '*.sql' -o -name '*.R' | sort)
do
if [[ $f == *".R" ]]
then
  echo Processing $f
  echo -------------------------------------------
  now=$(date +"%y-%d-%m %T")
  echo "Started: $now"
  R CMD BATCH $f
  now=$(date +"%y-%d-%m %T")
  echo "Finished: $now"
else
  echo
  echo Processing $f
  echo -------------------------------------------
  now=$(date +"%y-%d-%m %T")
  echo "Started: $now"
  psql --quiet -U $1 -v schema=$schema -v ON_ERROR_STOP=1 -d [database] -h [server] -f $f -L logs/log.txt || exit 1
  now=$(date +"%y-%d-%m %T")
  echo "Finished: $now"
fi
done

echo
echo ===========================================
echo "Run started:   $start_time"
echo "Run completed: $now"
