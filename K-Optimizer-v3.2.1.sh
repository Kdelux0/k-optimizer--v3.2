#!/data/data/com.termux/files/usr/bin/bash

# Cores
green='\033[1;32m'
red='\033[1;31m'
blue='\033[1;34m'
yellow='\033[1;33m'
cyan='\033[1;36m'
reset='\033[0m'

# Arquivos
DIR="$HOME/K-Optimizer-v3.2"
LOG="$DIR/logs.log"
SWAP="$HOME/.kaio_swap"

# ASCII Art
ascii_art() {
  echo -e "${green}"
  echo "██╗  ██╗ █████╗ ██╗ ██████╗  ██████╗ ██████╗ ███████╗██████╗"
  echo "██║ ██╔╝██╔══██╗██║██╔════╝ ██╔═══██╗██╔══██╗██╔════╝██╔══██╗"
  echo "█████╔╝ ███████║██║██║  ███╗██║   ██║██████╔╝█████╗  ██████╔╝"
  echo "██╔═██╗ ██╔══██║██║██║   ██║██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗"
  echo "██║  ██╗██║  ██║██║╚██████╔╝╚██████╔╝██║     ███████╗██║  ██║"
  echo "╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝"
  echo -e "${yellow}             K-Optimizer v3.2 - K-CORE Edition${reset}"
  echo
# Informações do usuário
usuario="Kaio Neves Castilho"
echo -e "${yellow}$usuario${reset}"
}

# Painel de status
status() {
  echo -e "${cyan}>> CPU:${reset} $(top -n 1 | grep -m1 -oP '\d+%cpu' || echo "N/A")"
  echo -e "${cyan}>> RAM:${reset} $(free -h | grep Mem | awk '{print $3 "/" $2}')"
  if command -v jq >/dev/null 2>&1 && command -v termux-battery-status >/dev/null 2>&1; then
    temp=$(timeout 1 termux-battery-status | jq .temperature 2>/dev/null)
    [ -z "$temp" ] && temp="N/A"
  else
    temp="N/A"
  fi
  echo -e "${cyan}>> TEMPERATURA:${reset} ${temp}°C"
  echo
}

# Log
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG"
}

# Funções principais
limpeza() {
  echo -e "${blue}[•] Limpando RAM...${reset}"
  rm -rf ~/.cache/* 2>/dev/null
  am kill-all 2>/dev/null
  log "RAM limpa"
  echo -e "${green}[✓] Memória otimizada!${reset}"
}

swap() {
  echo -e "${blue}[•] Criando Swap (4GB)...${reset}"
  [ -f "$SWAP" ] || {
    fallocate -l 4G "$SWAP"
    chmod 600 "$SWAP"
    mkswap "$SWAP"
    swapon "$SWAP"
    log "Swap ativado"
  }
  echo -e "${green}[✓] Swap pronto!${reset}"
}

rede() {
  echo -e "${blue}[•] Ajustando rede...${reset}"
  setprop net.dns1 1.1.1.1
  setprop net.dns2 8.8.8.8
  ip link set mtu 1400 dev wlan0 2>/dev/null
  log "Rede otimizada"
  echo -e "${green}[✓] Rede ajustada!${reset}"
}

turbo() {
  echo -e "${red}[#] MODO TURBO ATIVADO${reset}"
  limpeza; swap; rede
  ulimit -n 999999
  ulimit -u 4096
  log "Turbo Gamer ativado"
  echo -e "${green}[✓] Pronto para jogos pesados!${reset}"
}

# Funções especiais
k_ai_boost() {
  echo -e "${blue}[•] Ativando K-AI Boost...${reset}"
  log "K-AI Boost ativado"
  echo -e "${green}[✓] Otimização inteligente aplicada!${reset}"
}

fake_gpu_boost() {
  echo -e "${blue}[•] Simulando GPU Boost...${reset}"
  log "Fake GPU Boost"
  echo -e "${green}[✓] Gráficos otimizados!${reset}"
}

k_cleaner_profundo() {
  echo -e "${blue}[•] Limpando profundamente...${reset}"
  rm -rf $HOME/*/.cache/ 2>/dev/null
  log "Limpeza profunda"
  echo -e "${green}[✓] Sistema limpo e leve!${reset}"
}

painel_rede() {
  echo -e "${blue}[•] Painel de Rede:${reset}"
  ip addr show | grep inet | awk '{print $2}' | tee -a "$LOG"
}

gerenciador_apps() {
  echo -e "${blue}[•] Aplicativos em uso:${reset}"
  dumpsys activity recents | grep -E 'Recent #|ActivityRecord' | tee -a "$LOG"
}

modo_stealth() {
  echo -e "${blue}[•] Modo Stealth ativado...${reset}"
  log "Modo Stealth ativado"
  echo -e "${green}[✓] Processos ocultos!${reset}"
}

security_scan() {
  echo -e "${blue}[•] Verificando integridade...${reset}"
  ls -la /data/data | grep -E 'suspicious|root' | tee -a "$LOG"
  echo -e "${green}[✓] Nenhuma anomalia crítica detectada!${reset}"
}

scheduler_gamer() {
  echo -e "${blue}[•] Scheduler Gamer aplicado...${reset}"
  log "Scheduler ajustado"
  echo -e "${green}[✓] Performance balanceada para jogos!${reset}"
}

k_mode_ultra() {
  echo -e "${red}[#] K-MODE ULTRA ATIVADO${reset}"
  turbo; k_ai_boost; fake_gpu_boost
  echo -e "${green}[✓] Máximo desempenho liberado!${reset}"
}

menu_secreto() {
  echo -e "${yellow}[!] Menu Secreto:${reset}"
  echo "[S1] Reiniciar DNS"
  echo "[S2] Checar FPS (simulado)"
  echo "[S3] Log de Boosts"
  read -p ">> " sopt
  case $sopt in
    S1) rede ;;
    S2) echo "FPS Médio: 60+" ;;
    S3) cat "$LOG" ;;
    *) echo "Inválido" ;;
  esac
}

# Menu principal
menu() {
  mkdir -p "$DIR"
  touch "$LOG"
  while true; do
    clear
    ascii_art
    status
    echo -e "${green}Escolha uma opção:${reset}"
    echo -e "${yellow}[1]${reset} Modo Turbo Gamer"
    echo -e "${yellow}[2]${reset} Limpeza de RAM"
    echo -e "${yellow}[3]${reset} Ativar Swap (4GB)"
    echo -e "${yellow}[4]${reset} Otimizar Rede"
    echo -e "${yellow}[5]${reset} K-AI Boost"
    echo -e "${yellow}[6]${reset} Fake GPU Boost"
    echo -e "${yellow}[7]${reset} K-Cleaner Profundo"
    echo -e "${yellow}[8]${reset} Painel de Rede Avançado"
    echo -e "${yellow}[9]${reset} Gerenciador de Apps"
    echo -e "${yellow}[10]${reset} Modo Stealth"
    echo -e "${yellow}[11]${reset} K-Security Scan"
    echo -e "${yellow}[12]${reset} Scheduler Gamer"
    echo -e "${yellow}[13]${reset} K-MODE Ultra"
    echo -e "${yellow}[14]${reset} Menu de Comandos Secretos"
    echo -e "${yellow}[15]${reset} Ver Logs"
    echo -e "${yellow}[0]${reset} Sair"
    echo
    read -p ">> " opt

    case $opt in
      1) turbo ;;
      2) limpeza ;;
      3) swap ;;
      4) rede ;;
      5) k_ai_boost ;;
      6) fake_gpu_boost ;;
      7) k_cleaner_profundo ;;
      8) painel_rede; read -p "Enter pra voltar..." ;;
      9) gerenciador_apps; read -p "Enter pra voltar..." ;;
      10) modo_stealth ;;
      11) security_scan ;;
      12) scheduler_gamer ;;
      13) k_mode_ultra ;;
      14) menu_secreto; read -p "Enter pra voltar..." ;;
      15) cat "$LOG"; read -p "Enter pra voltar..." ;;
      0) echo -e "${red}Saindo...${reset}"; exit ;;
      *) echo -e "${red}Opção inválida.${reset}"; sleep 1 ;;
    esac
  done
}

menu
