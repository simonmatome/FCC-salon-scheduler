#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

MAIN_MENU(){
  echo -e "\n~~~~ MY SALON ~~~~\n"

  #Main menu greetings
  if [[ $1 ]]
  then
    echo -e "$1\n"
  else
    echo -e "Welcome to My Salon, How can I help you?\n"
  fi

  #Service options
  SERVICES=$($PSQL "SELECT * FROM services")
  echo "$SERVICES" | while IFS='|' read SERVICE_ID NAME
  do
    echo $SERVICE_ID\) $NAME
  done
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1|2|3|4|5|6)
      SERVICE_WORKER $SERVICE_ID_SELECTED
      ;;
    *)
      MAIN_MENU "I could not find that service. What would you like today?"
  esac
}

SERVICE_WORKER(){
  echo -e "\n~~~~ MY SALON ~~~~\n"

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $1")
  echo -e "You want to book $SERVICE_NAME service. What is your phone number?\n"
  read CUSTOMER_PHONE

  #check if phone number exists
  CUSTOMER_PHONE_RESULT=$($PSQL "SELECT phone FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  
  if [[ -z $CUSTOMER_PHONE_RESULT ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?\n"
    read CUSTOMER_NAME
    
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")

    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?\n"
    read SERVICE_TIME

    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $1)")

    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME.\n"
  else 
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME

    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $1)")
    
    if [[ $INSERT_APPOINTMENT_RESULT == 'INSERT 1 0' ]]
    then
      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
}

MAIN_MENU
