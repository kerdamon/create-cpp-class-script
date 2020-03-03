#!/bin/bash

echo \
$'Script written in bash for creating C++ class .h and .cpp files.

SYNOPSIS

    class_create \e[3mfile\e[0m [\e[1m-f|-pf|-pv|-v|-sv|-spv|-spf|-sf|-i|-c|-d\e[0m \e[3mname\e[0m...]...
    
OPTIONS:
    -pf | --public-function
        Script will create public functions in proper place. You do not need to write (); at the end, only name of a function.
        Example: -pf public_function1 public_function2

    -f | --private-function
        Script will create private functions in proper place. You do not need to write (); at the end, only name of a function.
        Example: -f private_function1 private_function2
        
    -pv | --public-variable
        Script will create public variables in proper place. You do not need to write ; at the end, only name of a variable.
        Example: -pv public_variable1 public_variable2
        
    -v | --private-variable
        Script will create private variables in proper place. You do not need to write ; at the end, only name of a variable.
        Example: -v private_variable1 private_variable2
        
    -spv | --static-public-variable
        Script will create static public variables in proper place. You do not need to write ; at the end, only name of a variable.
        Example: -spv static_public_variable1 static_public_variable2
        
    -spf | --static-public-function
        Script will create static public functions in proper place. You do not need to write (); at the end, only name of a function.
        Example: -spf static_public_function1 static_public_function2
        
    -sf | --static-private-function 
        Script will create static private functions in proper place. You do not need to write (); at the end, only name of a function.
        Example: -sf static_private_function1 static_private_function2
        
    -sv | --static-private-variable
        Script will create static private variables in proper place. You do not need to write ; at the end, only name of a variable.
        Example: -sv static_private_variable1 static_private_variable2
        
    -i | --include-iostream
        Script will #include <iostream> in the .cpp file.
        Example: -i does_not_matter_it_will_be_ignored1 does_not_matter_it_will_be_ignored2
        
    -c | --constructor 
        Script will create basic constructor in .h file.
        Example: -c does_not_matter_it_will_be_ignored1 does_not_matter_it_will_be_ignored2
        
    -d | --destructor 
        Script will create destructor in .h file.
        Example: -d does_not_matter_it_will_be_ignored1 does_not_matter_it_will_be_ignored2'

exit