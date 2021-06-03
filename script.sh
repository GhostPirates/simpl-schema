#!/bin/bash

if [ -d "./lib" ]
then
  echo "Cleaning up old lib folder"
  rm -rf "./lib"
fi

if [ -d "./dist" ]
then
  echo "Cleaning up old dist folder"
  rm -rf "./dist"
fi

if [ -d "./node_modules" ]
then
  echo "Cleaning up old dist folder"
  rm -rf "./node_modules"
fi

if test -f "./package.json"
then
  echo "Cleaning up old package.json"
  rm "./package.json"
fi

if test -f "./package-lock.json"
then
  echo "Cleaning up old package-lock.json"
  rm "./package-lock.json"
fi

if test -f "./.eslintignore"
then
  echo "Cleaning up old .eslintignore"
  rm "./.eslintignore"
fi

if [ -d "./package" ]
then
  echo "Copying files out of package folder"
  cp -r ./package/* ./
fi

if [ -d "./lib" ]
then
  echo "New lib folder found... let's go do the thing!"
  START_CUT_LINE_NUMBER=$(grep -n '\s*this\.\_depsAny\s*\=' ./lib/ValidationContext.js | cut -d: -f 1)
  END_CUT_LINE_NUMBER=$(grep -n '\s*this\.\_deps\[key\]' ./lib/ValidationContext.js | cut -d: -f 1)
  let END_CUT_LINE_NUMBER+=1
  echo "Starting cut from line: $START_CUT_LINE_NUMBER"
  echo "Ending cut at line: $START_CUT_LINE_NUMBER"
  echo "sed command: $START_CUT_LINE_NUMBER,$END_CUT_LINE_NUMBER""d"
  sed -i "$START_CUT_LINE_NUMBER,$END_CUT_LINE_NUMBER""d" ./lib/ValidationContext.js
  sed -i "$START_CUT_LINE_NUMBER""i""\      const addDeps = (schema, keys = []) => {\n        Object.keys(schema).forEach(key => {\n          const schemaElement = schema[key];\n          schemaElement.type.definitions && schemaElement.type.definitions.forEach(def => {\n            if (typeof def.type === 'object') {\n              addDeps(def.type._schema, keys.concat(key));\n            } else {\n              const fullKey = keys.concat(key).join('.');\n              this._deps[fullKey] = new tracker.Dependency();\n            }\n          });\n        });\n      };\n      addDeps(this._schema);" ./lib/ValidationContext.js
fi

if ! command -v npm &> /dev/null
then
    echo "npm command could not be found, exiting!"
    exit
else
  if test -f "./package.json"
  then
    echo "Package.json found, installing node_modules and stuff..."
    npm install
    echo "Running build script and hopefully dumping dist folder..."
    npm run build
    if [ -d "./dist" ]
    then
      echo "Found a dist folder, hooray!"
      if ! command -v git &> /dev/null
      then
          echo "git command could not be found, exiting!"
          exit
      else
        git add .
        git commit -m "auto-bump"
        git push
      fi
    fi
  fi
fi
