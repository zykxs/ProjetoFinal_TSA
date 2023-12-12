#./pwdGen.sh

#!/bin/bash
echo

#Função p gerar password
generate_password() {
    local password=$(tr -dc 'A-Za-z0-9!@#$%^&*()' < /dev/urandom | head -c "$password_length")
    echo "$password"
}

# Main script
read -p "Introduza nº de caractéres: " password_length

password=$(generate_password "$password_length")

echo
echo "Password: $password/n"