# ProjetoFinal_TSA

Repositório para Projeto Final da UC de Tecnologias de Scripting e Automação

Aluno: André Ferreira (220001208)

## Tema: 
Gerador/Gestor de Passwords

## Descrição e Objetivos

Este projeto serve para criar um gerador/gestor de passwords de acordo com os standards de segurança atuais, tais como:
- Password com pelo menos 16 caractéres
- Pelo menos 1 caracter dos seguintes conjuntos de caractéres:
  - Maiúsculas;
  - Minúsculas;
  - Dígitos;
  - Caracteres Especiais.

Dito isto, este projeto terá como objetivos:
- Gerar X passwords com Y (min. 16) caracteres. X e Y são recebidos como inputs.
  - Escolher os caractéres de forma aleatória:
    - Maiúsculas;
    - Minúsculas;
    - Dígitos;
    - Caractéres Especiais.
 - Guardar as passwords em dois ficheiros:
    - ficheiro pwd.txt, contém as passwords em cleartext;
    - ficheiro shadow.txt, contém as passwords em hash SHA-256.