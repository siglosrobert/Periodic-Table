#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Check if there is argument
# If no argument
if [[ -z $1 ]]
then
  #echo provide argument
  echo -e "Please provide an element as an argument."
# if argument found
else
  # check if argument is numeric
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # check if in database
    # get atomic number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")
    # if not found
    if [[ -z $ATOMIC_NUMBER ]]
    then
      # echo could not find
      echo I could not find that element in the database.
    # if found
    else
      # get info via sql
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      SYMBOL=$($PSQL "SELECT symbol FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      TYPE=$($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      # echo final message
      echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  # if not numeric
  else
    # check if in database
    # get atomic number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1';")
    # if not found
    if [[ -z $ATOMIC_NUMBER ]]
    then
      # echo could not find
      echo I could not find that element in the database.
    else
      # if found
      # get info via sql
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      SYMBOL=$($PSQL "SELECT symbol FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      TYPE=$($PSQL "SELECT type FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;")
      # echo final message
      echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  fi
fi


