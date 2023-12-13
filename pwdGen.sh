#./pwdGen.sh

#!/bin/bash
echo

# Função p gerar password
generate_password() {
    local password=$(tr -dc 'A-Za-z0-9!@#$%^&*()' < /dev/random | head -c "$n_chars")
    echo "$password"
}

# Main script
read -p "nº de caractéres: " n_chars
read -p "nº de passwords: " n_passwords
echo

    # Ciclo pa gerar n passwords
for ((i = 0; i < $n_passwords; i++)); do
    password=$(generate_password "$n_chars")
    echo "Pwd $((i+1)): $password"
done