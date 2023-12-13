#!/bin/bash
#./pwdGen.sh
echo 

# Função p gerar a password
generate_password() {
    local password=$(tr -dc 'A-Za-z0-9!@#$%^&*()' < /dev/random | head -c "$nChars")
    echo "$password"
}

# Main script
while true; do
    read -p "Nº Caractéres: " nChars
    # Condição que força pelo menos 16 caractéres
    if [ "$nChars" -ge 16 ]; then
        break
    else
        echo -e "Introduza um valor igual ou superior a 16.\n"
    fi
done

read -p "Nº Passwords: " nPwds
echo

    # Ciclo p gerar n passwords
    # Criar ficheiro txt com as passwords
    # Mostrar o txt
    # Copiar para a home do user e apagar txt residual

echo -e "Passwords\n" > passwords.txt
for ((i = 0; i < $nPwds; i++)); do
    password=$(generate_password "$nChars")
    echo "Password $((i+1)): $password" >> passwords.txt 
done

cat passwords.txt
cp passwords.txt ~
rm passwords.txt