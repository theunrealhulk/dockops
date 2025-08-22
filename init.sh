#!/bin/bash

OPTION=$(dialog --title "DocOps" --menu "choose what you need to try from the following list" 0 0 0 1 "API" 2 "Front" 3 "API & Font" 3>&1 1>&2 2>&3 3>&- )
: ${OPTION:?Error: Project type cannot be empty. Aborting.}

if [ "$OPTION" != 1 ]; then
  #front options
  FRONTOPTION=$(dialog --title "DocOps" --menu "what Type Of fronts You need ?" 0 0 0 1 "Web" 2 "Mobile" 3 "Web & Mobile" 3>&1 1>&2 2>&3 3>&- )
  : ${FRONTOPTION:?Error: Project Front OPTION cannot be empty. Aborting.}

  # web front
  if [ "$FRONTOPTION" != 2 ];then
     FRONT_SERVICE=$(dialog --title "DocOps" --checklist "Select FRONT service" 0 0 0 \
    "Angular" "Angular Framework" off \
    "React" "React Framework" off \
    "Vue" "Vue Framework" off \
    "NextJs" "NextJs Framework" off \
    "NuxtJs" "NuxtJs Framework" off \
    "EmberJs" "EmberJs Framework" off \
    "BackboneJs" "BackboneJs Framework" off \
    "SemanticUi" "SemanticUi Framework" off \
    "Foundation" "Foundation Framework" off \
        3>&1 1>&2 2>&3 3>&-)
    : ${FRONT_SERVICE:?Error: at least one must be checked. Aborting.}
  fi

  # web front
  if [ "$FRONTOPTION" != 1 ];then
    MOBILE_SERVICE=$(dialog --title "DocOps" --menu "Select Mobile service ?" 0 0 0 1 "ReactNative" 2 "Flutter" 3>&1 1>&2 2>&3 3>&- )
    : ${MOBILE_SERVICE:?Error: at least one must be checked. Aborting.}
  fi
fi

if [ "$OPTION" != 2 ];then

  API_SERVICE=$(dialog --title "DocOps"  --checklist "select API service " 0 0 0  \
    "Django" "(Python) Django" off \
    "Flask" "(Python) Flask" off \
    "FastAPI" "(Python) FastAPI" off \
    "Spring Boot" "(Java) Spring Boot" off \
    "Laravel" "(PHP) Laravel" off \
    "Rails" "(Ruby) Ruby on Rails" off \
    "Gin" "(Go) Gin" off \
    "dotnet-ASP" "(C#) dotnet-ASP" off \
    "express" "(javascript) express" off \
    "nestJs" "(javascript) nestJs" off \
    "WinterJS" "(javascript) WinterJS" off \
    "Hapi" "(javascript) Hapi" off \
    "Oak" "(javascript) Oak" off \
    "Hono" "(javascript) Hono" off \
    "SailsJs" "(javascript) SailsJs" off \
    "Koa" "(javascript) Koa" off \
    "AdonisJS" "(javascript) AdonisJS" off \
    "Restify" "(javascript) Restify" off \
    "Feathers" "(javascript) Feathers" off \
    3>&1 1>&2 2>&3 3>&-)
   : ${API_SERVICE:?Error: at least one must be checked. Aborting.}

  DB_SERVICE=$(dialog --title "DocOps" --checklist "Select Database service" 0 0 0 \
    "MySQL" "(SQL) MySQL" off \
    "MariaDB" "(SQL) MariaDB" off \
    "PostgreSQL" "(SQL) PostgreSQL" off \
    "SqlServer" "(SQL) SqlServer" off \
    "OracleDB" "(SQL) OracleDB" off \
    "MongoDB" "(Document) MongoDB" off \
    "CouchDB" "(Document) CouchDB" off \
    "Elasticsearch" "(Document) Elasticsearch" off \
    "Neo4j" "(Graph) Neo4j" off \
    "ArangoDB" "(Graph) ArangoDB" off \
    "Redis" "(Caching) ArangoDB" off \
    "Memcached" "(Caching) Memcached" off \
        3>&1 1>&2 2>&3 3>&-)
    : ${DB_SERVICE:?Error: at least one must be checked. Aborting.}

fi

#PROJECTNAME=$(dialog --title "DocOps" --inputbox "Enter your project name" 0 0 3>&1 1>&2 2>&3 3>&- )
#: ${PROJECTNAME:?Error: Project name cannot be empty. Aborting.}


while true; do
  PROJECTNAME=$(dialog --title "DocOps" \
                       --inputbox "Enter your project name" 0 0 \
                       3>&1 1>&2 2>&3 3>&- )

  # check if user pressed cancel
  if [[ $? -ne 0 ]]; then
    echo "Aborted."
    exit 1
  fi

  # validate empty input
  if [[ -z "$PROJECTNAME" ]]; then
    dialog --msgbox "Project name cannot be empty. Try again." 5 40
    continue
  fi

  # check if folder already exists
  if [[ -d "$PROJECTNAME" ]]; then
    dialog --msgbox "Folder '$PROJECTNAME' already exists. Please choose another name." 5 60
    continue
  fi

  # create folder and break out of loop
  mkdir "$PROJECTNAME"
 # make .docOps folder
 # make dockOps.json
  dialog --msgbox "Project folder '$PROJECTNAME' created successfully." 5 50
  break
done



clear

FRONT_SERVICES=($FRONT_SERVICE)
case "$MOBILE_SERVICE" in
  1) MOBILE_S="reactnative" ;;
  2) MOBILE_S="flutter" ;;
esac
API_SERVICES=($API_SERVICE)
DB_SERVICES=($DB_SERVICE)

echo "TOTAL FRONT_SERVICES=${#FRONT_SERVICES[@]} $FRONT_SERVICE"
echo "MOBILE_SERVICE=$MOBILE_S"
echo "TOTAL API_SERVICES=${#API_SERVICES[@]} $API_SERVICE"
echo "TOTAL DB_SERVICES=${#DB_SERVICES[@]} $DB_SERVICE"