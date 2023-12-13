#./pwdGen.sh

#!/bin/bash
echo

# Função p gerar password
generate_password() {
    local password=$(tr -dc 'A-Za-z0-9!@#$%^&*()' < /dev/random | head -c "$chars")
    echo "$password"
}

# Main script
read -p "nº de caractéres: " nChars
read -p "nº de passwords: " nPasswords
echo

    # Ciclo pa gerar n passwords
for ((i = 0; i < $nPasswords; i++)); do
    password=$(generate_password "$nChars")
    echo "Pwd $((i+1)): $password"
done