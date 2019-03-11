# Set up parameter for the folder to run.
# This can be used when running the build:
# .\run-build.ps1 -dir '\path\to\the\folder\you\want\to\run'
# Defaults to the entire build (all code in src)
param([string]$dir= "[CODE FOLDER HERE]")

#Provide SQLServerName
$SQLServer ="[SERVER NAME HERE]"

#Provide Database Name
$DatabaseName ="[DB NAME HERE]"

#Loop through the .sql files and run them
foreach ($filename in get-childitem -path $dir -filter "*.sql" -Recurse | Sort-Object Directory, Name | Resolve-Path -Relative)
{
#Print file name which is executed
echo 'Executing: ' $filename

# Execute the file
sqlcmd -S $SQLServer -d $DatabaseName -i $filename
}
