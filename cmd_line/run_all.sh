# Simple script to execute all sql files
# usage build.sh <username> <schema> <folder>

# check parameters
if [ -z "$1" ]; then
  echo "Please specify a user"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Please specify a schema"
  exit 1
fi

if [ -z "$3" ]; then
  build_folder="./build"
else
  build_folder=$3  
fi

echo "Running as database user: '$1'"
echo "Running on schema: '$2'"
echo "Running folder: '$build_folder'"

#-----------------------------

log_date=$(date +"%Y-%m-%d_%H%M%S")
log_path=logs/"$log_date"-log.txt
echo SQL logs in $log_path

start_time=$(date +"%y-%d-%m %T")

echo ------------------------------------------
echo "Building and selecting the schema..."

for f in $(find $build_folder -not -path "*/000-s0/*" -name '*.sql' -o -name '*.R' | sort)
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
  psql --quiet -U $1 -v schema=$schema -v ON_ERROR_STOP=1 -d <database> -h <host> -f $f -L $log_path || exit 1
  now=$(date +"%y-%d-%m %T")
  echo "Finished: $now"
fi
done

echo
echo ===========================================
echo "Run started:   $start_time"
echo "Run completed: $now"
