#!/bin/bash
# ./pwdGen.sh
echo

# Função para gerar a password
    # Gera pelo menos um caracter de cada grupo ao obter um byte pseudoaleatório de /dev/urandom
    # Subtrai à variável nChars os 4 caracteres gerados e guarda na variavel rChars
    # Com a variavel rChars, gera uma cadeia de caracteres aleatória ao obter bytes pseudoaleatórios de /dev/urandom
    # Filtra caracteres indesejados usando tr e, em seguida, seleciona um número específico de caracteres usando head -c
    # Pega em  todos os caracteres gerados e dá um shuffle
    # O número de caracteres a gerar é determinado pela variável $nChars definida mais tarde
generate_password() {
    local upper=$(tr -dc 'A-Z' < /dev/urandom | head -c 1)
    local lower=$(tr -dc 'a-z' < /dev/urandom | head -c 1)
    local digits=$(tr -dc '0-9' < /dev/urandom | head -c 1)
    local specials=$(tr -dc '!@#$%^&*()' < /dev/urandom | head -c 1)
    local rChars=$((nChars-4))
    local password=$(tr -dc 'A-Za-z0-9!@#$%^&*()' < /dev/urandom | head -c "$rChars" )
    echo "${upper}${lower}${digits}${specials}${password}" | shuf
}

# Função para hash de password usando SHA-256
    # Faz um eco do primeiro argumento (neste caso, a password) sem uma nova linha
    # Calcula o hash SHA-256
    # Extrai o valor do hash
hash_password() {
    local hashed_password=$(echo -n "$1" | sha256sum | awk '{print $1}')
    echo "$hashed_password"
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
echo -e "Passwords geradas:" > shadow.txt
for ((i = 0; i < $nPwds; i++)); do
    password=$(generate_password)
    hash=$(hash_password "$password")
    echo "$((i+1)). $password" >> pwd.txt
    echo "$((i+1)). $hash" >> shadow.txt
done

# Pergunta ao user se quer guardar as suas passwords
counter=1
while true; do
    read -p "Deseja guardar as suas próprias passwords? [S/N]: " SavePass
    echo

    if [ "$SavePass" == "S" ] || [ "$SavePass" == "s" ]; then
        echo "" >> pwd.txt
        echo "" >> shadow.txt
        echo -e "Passwords do utilizador:" >> pwd.txt
        echo -e "Passwords do utilizador:" >> shadow.txt
        while [ "$userPass" != "Q" ]; do
            read -p "Introduza a sua password (Q para sair): " userPass
            if [ "$userPass" != "Q" ]; then
                userHash=$(hash_password "$userPass")
                echo "$counter. $userPass" >> pwd.txt
                echo "$counter. $userHash" >> shadow.txt
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

# Copiar ficheiros para a home do utilizador
# Apagar ficheiros residuais
# Mostrar ficheiros com as passwords
cp pwd.txt ~
rm pwd.txt
cat ~/pwd.txt
echo
cp shadow.txt ~
rm shadow.txt
cat ~/shadow.txt