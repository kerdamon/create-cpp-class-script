#!/bin/bash

#print help
if [[ $1 == "-h" || $1 == "--help" ]]; then
    ./class_create_help.sh
    exit
fi

#taking name of class
CLASS_NAME=
while [[ $1 !=  "" && ${1:0:1} != "-" ]]; do    #takes words, concatonates them, and uppercases first letter of each word until it meets an option
    CLASS_NAME+="${1^}"  #takest first argument, and uppercases it's first letter
    shift
done

#create .cpp and .h files, if name is specified
if [[ $CLASS_NAME !=  "" ]]; then

    if [ ! -f $CLASS_NAME.cpp ]; then       #checks if file exists, if not creates it
        touch $CLASS_NAME.cpp
    else
        echo "$CLASS_NAME.cpp exists, not creating it"
        CPP_EXISTED="TRUE"
    fi
    if [ ! -f $CLASS_NAME.h ]; then
        touch $CLASS_NAME.h
    else
        echo "$CLASS_NAME.h exists, not creating it"
        H_EXISTED="TRUE"
    fi

else

    echo "Aborted: Name of class not specified. At least one argument before options mus be specified for class name"
    exit

fi

#set the variables containing names of functions and variables provided by options from input
PUBLIC_FUNCTIONS_H=
PRIVATE_FUNCTIONS_H=
PUBLIC_FUNCTIONS_CPP=
PRIVATE_FUNCTIONS_CPP=
PUBLIC_VARIABLES=
PRIVATE_VARIABLES=
STATIC_PUBLIC_VARIABLES_H=
STATIC_PUBLIC_VARIABLES_CPP=
STATIC_PRIVATE_VARIABLES_H=
STATIC_PRIVATE_VARIABLES_CPP=
STATIC_PUBLIC_FUNCTIONS_H=
STATIC_PUBLIC_FUNCTIONS_CPP=
STATIC_PRIVATE_FUNCTIONS_H=
STATIC_PRIVATE_FUNCTIONS_CPP=
CONSTRUCTOR_H=
CONSTRUCTOR_CPP=
DESTRUCTOR_H=
DESTRUCTOR_CPP=
INCLUDE_IOSTREAM=
while [ "$1" != "" ]; do
    case $1 in
        -pf | --public-function )   #supports short ang long version of option
                                            PUBLIC_FUNCTIONS_H=$'\t//methods\n'
                                            while [[ $2 != "" && ${2:0:1} != "-" ]]; do     #takes argument as long as it is not another option(which starts with - or --) and writes it to proper name variable
                                                PUBLIC_FUNCTIONS_H+=$'\t '${2^}$'();\n'
                                                PUBLIC_FUNCTIONS_CPP+=" $CLASS_NAME::${2^}"$'(){\n\n}\n\n'
                                                shift
                                            done
                                            PUBLIC_FUNCTIONS_H+=$'\n'
                                            ;;

        -spf | --static-public-function )
                                            STATIC_PUBLIC_FUNCTIONS_H+=$'\t//static public methods\n'
                                            while [[ $2 != "" && ${2:0:1} != "-" ]]; do
                                                STATIC_PUBLIC_FUNCTIONS_H+=$'\tstatic  '${2^}$'();\n'
                                                STATIC_PUBLIC_FUNCTIONS_CPP+=" $CLASS_NAME::${2^}"$'(){\n\n}\n\n'
                                                shift
                                            done
                                            STATIC_PUBLIC_FUNCTIONS_H+=$'\n'
                                            ;;

        -f | --private-function )
                                            PRIVATE_FUNCTIONS_H=$'\t//private methods\n'
                                            while [[ $2 != "" && ${2:0:1} != "-" ]]; do
                                                PRIVATE_FUNCTIONS_H+=$'\t '_${2^}$'();\n'
                                                PRIVATE_FUNCTIONS_CPP+=" $CLASS_NAME::_${2^}"$'(){\n\n}\n\n'
                                                shift
                                            done
                                            PRIVATE_FUNCTIONS_H+=$'\n'
                                            ;;

        -sf | --static-private-function )
                                            STATIC_PRIVATE_FUNCTIONS_H+=$'\t//static private methods\n'
                                            while [[ $2 != "" && ${2:0:1} != "-" ]]; do
                                                STATIC_PRIVATE_FUNCTIONS_H+=$'\tstatic  '${2^}$'();\n'
                                                STATIC_PRIVATE_FUNCTIONS_CPP+=" $CLASS_NAME::${2^}"$'(){\n\n}\n\n'
                                                shift
                                            done
                                            STATIC_PRIVATE_FUNCTIONS_H+=$'\n'
                                            ;;

        -pv | --public-variable )
                                            PUBLIC_VARIABLES+=$'\t//public variables\n'
                                            while [[ $2 != "" && ${2:0:1} != "-" ]]; do
                                                PUBLIC_VARIABLES+=$'\t '${2,}$';\n'
                                                shift
                                            done
                                            PUBLIC_VARIABLES+=$'\n'
                                            ;;

        -spv | --static-public-variable )
                                            STATIC_PUBLIC_VARIABLES_H+=$'\t//static public variables\n'
                                            while [[ $2 != "" && ${2:0:1} != "-" ]]; do
                                                STATIC_PUBLIC_VARIABLES_H+=$'\tstatic  '${2,}$';\n'
                                                STATIC_PUBLIC_VARIABLES_CPP+=" $CLASS_NAME::${2,}"$' = 0;\n'
                                                shift
                                            done
                                            STATIC_PUBLIC_VARIABLES_H+=$'\n'
                                            STATIC_PUBLIC_VARIABLES_CPP+=$'\n'
                                            ;;

        -v | --private-variable )
                                            PRIVATE_VARIABLES=$'\t//variables\n'
                                            while [[ $2 != "" && ${2:0:1} != "-" ]]; do
                                                PRIVATE_VARIABLES+=$'\t _'${2,}$';\n'
                                                shift
                                            done
                                            PRIVATE_VARIABLES+=$'\n'
                                            ;;

        -sv | --static-private-variable )
                                            STATIC_PRIVATE_VARIABLES_H+=$'\t//static private variables\n'
                                            while [[ $2 != "" && ${2:0:1} != "-" ]]; do
                                                STATIC_PRIVATE_VARIABLES_H+=$'\tstatic  _'${2,}$';\n'
                                                STATIC_PRIVATE_VARIABLES_CPP+=" $CLASS_NAME::${2,}"$' = 0;\n'
                                                shift
                                            done
                                            STATIC_PRIVATE_VARIABLES_H+=$'\n'
                                            STATIC_PRIVATE_VARIABLES_CPP+=$'\n'
                                            ;;
        -c | --constructor )
                                            CONSTRUCTOR_H=$'\t//constructors\n'
                                            CONSTRUCTOR_H+=$'\t'$CLASS_NAME$'();\n\n'
                                            CONSTRUCTOR_CPP="$CLASS_NAME::$CLASS_NAME"$'(){\n\n}\n\n'
                                            ;;
        -d | --destructor )
                                            DESTRUCTOR_H=$'\t//destructors\n'
                                            DESTRUCTOR_H+=$'\t~'$CLASS_NAME$'();\n\n'
                                            DESTRUCTOR_CPP="$CLASS_NAME::~$CLASS_NAME"$'(){\n\n}\n\n'
                                            ;;
        -i | --include-iostream )
                                            INCLUDE_IOSTREAM=$'\n#include <iostream>\n\nusing namespace std;'
                                            ;;
    esac
    shift
done

#create actual file using variables created above
    if [ ! "$H_EXISTED" == "TRUE" ]; then
        echo $'#pragma once\n\nclass '"$CLASS_NAME"$'{\npublic:\n\n'"$CONSTRUCTOR_H$DESTRUCTOR_H$STATIC_PUBLIC_FUNCTIONS_H$PUBLIC_FUNCTIONS_H$STATIC_PUBLIC_VARIABLES_H$PUBLIC_VARIABLES"$'private:\n\n'"$STATIC_PRIVATE_FUNCTIONS_H$PRIVATE_FUNCTIONS_H$STATIC_PRIVATE_VARIABLES_H$PRIVATE_VARIABLES"$'};' >> $CLASS_NAME.h
    fi
    
    if [ ! "$CPP_EXISTED" == "TRUE" ]; then
        echo $'#include \"'"$CLASS_NAME"$'.h\"'"$INCLUDE_IOSTREAM"$'\n\n'"$STATIC_PUBLIC_VARIABLES_CPP$STATIC_PRIVATE_VARIABLES_CPP$CONSTRUCTOR_CPP$DESTRUCTOR_CPP$PUBLIC_FUNCTIONS_CPP$PRIVATE_FUNCTIONS_CPP" >> $CLASS_NAME.cpp
    fi

exit 0