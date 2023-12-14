#!/bin/bash
# ./pwdGen.sh
echo

# Função para gerar a password
# Gera uma cadeia de caracteres aleatória ao obter bytes pseudoaleatórios de /dev/urandom
# Filtra caracteres indesejados usando tr e, em seguida, seleciona um número específico de caracteres usando head -c.
# O número de caracteres a gerar é determinado pela variável $nChars definida mais tarde.
generate_password() {
    local password=$(tr -dc 'A-Za-z0-9!@#$%^&*()' < /dev/urandom | head -c "$nChars")
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

# Ciclo para gerar n passwords
echo -e "Passwords geradas:" > pwd.txt
for ((i = 0; i < $nPwds; i++)); do
    password=$(generate_password)
    echo "$((i+1)). $password" >> pwd.txt
done

# Pergunta ao user se quer guardar as suas passwords
counter=1
while true; do
    read -p "Deseja guardar as suas próprias passwords? [S/N]: " SavePass
    echo

    if [ "$SavePass" == "S" ] || [ "$SavePass" == "s" ]; then
        echo "" >> pwd.txt
        echo -e "Passwords do utilizador:" >> pwd.txt
        userPass=""
        while [ "$userPass" != "Q" ]; do
            read -p "Introduza a sua password (Q para sair): " userPass
            if [ "$userPass" != "Q" ]; then
                echo "$counter. $userPass" >> pwd.txt
                ((counter++))
            fi
        done
        echo
        break
    elif [ "$SavePass" == "N" ] || [ "$SavePass" == "n" ]; then
        break
    else
        echo -e "Opção Inválida. Introduza S ou N.\n"
    fi
done

# Copiar ficheiro para a home do utilizador
# Apagar ficheiro residual
# Mostrar ficheiro com as passwords

cp pwd.txt ~
rm pwd.txt
cat ~/pwd.txt