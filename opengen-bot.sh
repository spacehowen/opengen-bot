#!/bin/bash

openGenBot_results=()
totalAccounts=0

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[0;33m'
NC='\033[0m'

grab() {
    local accountType="$1"
    local maxAccounts="$2"

    echo -e "Obteniendo cuentas de ${AMARILLO}$accountType${NC}."

    while ((totalAccounts < maxAccounts)); do
        local response=$(curl -s "https://opengen.dpkghub.com/api/generate.php?type=$accountType")

        if [[ " ${openGenBot_results[@]} " =~ " $response " ]]; then
            echo -e "${ROJO}No se pudo obtener la cuenta de $accountType debido a duplicados/error.${NC}"
            echo -e "Reintentando..."
        else
            openGenBot_results+=("$response")
            echo -e "Cuenta ${VERDE}($((totalAccounts + 1))/${maxAccounts})${NC}: ${VERDE}$response${NC}"
            totalAccounts=$((totalAccounts + 1))
        fi
    done
}

showMenu() {
    totalAccounts=0
    printf "\n"
    echo -e "\033[95m"
    figlet -c -f small -l OPENGEN-BOT
    echo -e "\n${VERDE}---------- Menú Principal ----------${NC}"

    echo -e "1. ${AMARILLO}Netflix${NC}"
    echo -e "2. ${AMARILLO}Spotify${NC}"
    echo -e "3. ${AMARILLO}Spotify Family${NC}"
    echo -e "4. ${AMARILLO}NordVPN${NC}"
    echo -e "5. ${AMARILLO}Disney${NC}"
    echo -e "6. ${AMARILLO}Minecraft${NC}"
    echo -e "7. ${AMARILLO}ExpressVPN${NC}"
    echo -e "8. ${ROJO}Salir${NC}"
    read -p "Cuenta: " accountTypeNum

    case $accountTypeNum in
        1)
            accountType="Netflix"
            ;;
        2)
            accountType="Spotify"
            ;;
        3)
            accountType="SpotifyFamily"
            ;;
        4)
            accountType="NordVPN"
            ;;
        5)
            accountType="Disney"
            ;;
        6)
            accountType="Minecraft"
            ;;
        7)
            accountType="ExpressVPN"
            ;;
        8)
            echo -e "${AMARILLO}Gracias por usar el script. ¡Hasta luego!${NC}"
            exit 0
            ;;
        *)
            echo -e "${ROJO}Selección inválida.${NC}"
            showMenu
            ;;
    esac

    read -p "Ingresa la cantidad de cuentas que deseas mostrar: " numAccounts

    grab "$accountType" "$numAccounts"

    showMenu
}

showMenu
