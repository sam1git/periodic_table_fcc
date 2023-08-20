#!/bin/bash
PSQL="psql -U freecodecamp -d periodic_table --tuples-only --no-align -c "

if [[ $# > 1 ]]
then echo "Please only provide one argument."
else
  if [[ $1 ]]
  then
    #fetch element data
    if [[ $1 =~ [0-9]+ ]]; then
      #fetch and print element details
      ELEMENT_ATOMIC_NUMBER="$1"
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
      if [[ -z $ELEMENT_NAME ]]
      then
        echo "I could not find that element in the database."
      else
        ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        echo -e "The element with atomic number $1 is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MP celsius and a boiling point of $ELEMENT_BP celsius."        
      fi
    elif [[ ${#1} < 4 ]]; then
      #fetch and print element details
      ELEMENT_SYMBOL="$1"
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$ELEMENT_SYMBOL'")
      if [[ -z $ELEMENT_NAME ]]
      then
        echo "I could not find that element in the database."
      else
        ELEMENT_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ELEMENT_SYMBOL'")
        ELEMENT_TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        echo -e "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($1). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MP celsius and a boiling point of $ELEMENT_BP celsius."        
      fi
    else
      #fetch and print element details
      ELEMENT_NAME="$1"
      ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$ELEMENT_NAME'")
      if [[ -z $ELEMENT_SYMBOL ]]
      then
        echo "I could not find that element in the database."
      else
        ELEMENT_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ELEMENT_SYMBOL'")
        ELEMENT_TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types USING(type_id) WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        ELEMENT_BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")
        echo -e "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $1 ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $1 has a melting point of $ELEMENT_MP celsius and a boiling point of $ELEMENT_BP celsius."        
      fi
    fi
  else
    echo "Please provide an element as an argument."
  fi
fi