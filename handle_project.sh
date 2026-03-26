#!/bin/bash
# CV Orchestrator - Project Manager
# =============================================================================

set -e

# --- Sposta l'esecuzione sempre nella root ---
cd "$(dirname "$0")"

# --- Configurazione ---
APP_NAME="CV-Orchestrator"
VENV_DIR=".venv"
REQUIREMENTS="requirements.txt"
DATA_SOURCE="web/data/resumeData.json"

# --- Colori ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# --- Helper Functions ---
log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# --- Verifica Python ---
check_python() {
    if ! command -v python3 &> /dev/null; then
        log_error "Python3 non trovato!"
        exit 1
    fi
}

# --- Gestione Venv (Regola 8 Protocollo Cerniera) ---
ensure_venv() {
    if [ ! -d "$VENV_DIR" ]; then
        log_info "Creazione ambiente virtuale in $VENV_DIR..."
        python3 -m venv "$VENV_DIR"
    fi
    
    # Attiva venv
    source "$VENV_DIR/bin/activate"
    
    # Installa dipendenze se necessario
    if [ ! -f "$VENV_DIR/.installed" ] || [ "$REQUIREMENTS" -nt "$VENV_DIR/.installed" ]; then
        log_info "Installazione dipendenze Python..."
        pip install --upgrade pip -q
        if [ -f "$REQUIREMENTS" ]; then
            pip install -r "$REQUIREMENTS" -q
            touch "$VENV_DIR/.installed"
            log_success "Dipendenze installate."
        else
            log_warn "File $REQUIREMENTS non trovato. Salto installazione."
        fi
    fi
}

# --- Comandi ---

cmd_status() {
    echo -e "\n${CYAN}=== RIEPILOGO: ${APP_NAME} ===${NC}"
    
    # Dati
    echo -ne "Sorgente Dati (JSON): "
    if [ -f "$DATA_SOURCE" ]; then
        echo -e "${GREEN}OK${NC} ($(du -h "$DATA_SOURCE" | cut -f1))"
    else
        echo -e "${RED}MANCANTE${NC}"
    fi
    
    # Venv
    echo -ne "Ambiente Python:     "
    if [ -d "$VENV_DIR" ]; then
        echo -e "${GREEN}Attivo${NC} ($VENV_DIR)"
    else
        echo -e "${YELLOW}Non inizializzato${NC}"
    fi

    # Project Folders
    echo -ne "Area Admin:          "
    [ -d "web/admin" ] && echo -e "${GREEN}OK${NC}" || echo -e "${RED}MANCANTE${NC}"
    echo -ne "Area Web:            "
    [ -d "web" ] && echo -e "${GREEN}OK${NC}" || echo -e "${RED}MANCANTE${NC}"
    
    # Cloudflare Setup
    echo -ne "Cloudflare Pages:    "
    if [ -f "wrangler.toml" ]; then
        echo -e "${GREEN}Configurato${NC}"
    else
        echo -e "${YELLOW}Non configurato (wrangler.toml mancante)${NC}"
    fi

    echo -e "${CYAN}======================================${NC}\n"
}

cmd_run() {
    cmd_stop
    log_info "=== AVVIO SERVER LOCALE (Porta 8081) ==="
    log_info "Area Web (Root): http://localhost:8081/"
    log_info "Area Admin:      http://localhost:8081/admin/"
    log_warn "Premi Ctrl+C per fermare il server (o usa stop in un altro terminale)."
    python3 server.py &
    echo $! > .server.pid
    wait $!
}

cmd_stop() {
    log_info "=== ARRESTO SERVER LOCALE ==="
    
    # 1. Tentativo tramite file PID
    if [ -f .server.pid ]; then
        local pid=$(cat .server.pid)
        if ps -p $pid > /dev/null 2>&1; then
            kill -9 $pid > /dev/null 2>&1 && log_success "Server da file PID ($pid) fermato."
        fi
        rm -f .server.pid
    fi

    # 2. Kill chirurgico sulla porta 8081 (Metodo Knight)
    local port_pid=$(lsof -t -i:8081 2>/dev/null)
    if [ -n "$port_pid" ]; then
        kill -9 $port_pid > /dev/null 2>&1
        log_success "Processo sulla porta 8081 (PID $port_pid) terminato."
    fi

    # 3. Fallback per nome processo residuo
    local pids=$(ps aux | grep "[s]erver.py" | awk '{print $2}')
    if [ -n "$pids" ]; then
        kill -9 $pids > /dev/null 2>&1
        log_success "Processi residui terminati."
    fi
}

cmd_deploy() {
    log_info "=== AVVIO DEPLOY SU CLOUDFLARE PAGES ==="
    if command -v npx &> /dev/null; then
        npx wrangler pages deploy web --branch main
    else
        log_error "npx (Node.js) non trovato. Impossibile eseguire wrangler deploy."
        exit 1
    fi
}

cmd_backup() {
    log_info "=== CREAZIONE BACKUP DATI E DOCS ==="
    local timestamp=$(date +"%Y%m%d_%H%M")
    local backup_name="CV_Orchestrator_Backup_${timestamp}.zip"
    
    zip -r "$backup_name" web/ docs/ -x "*.DS_Store"
    log_success "Backup creato: $backup_name"
}

cmd_clean() {
    log_info "=== PULIZIA AMBIENTE ==="
    rm -rf "$VENV_DIR"
    find . -type d -name "__pycache__" -exec rm -rf {} +
    log_success "Ambiente pulito."
}

cmd_help() {
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║      CV Orchestrator - Manager         ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""
    echo "Uso: $0 <comando>"
    echo ""
    echo -e "${YELLOW}Gestione:${NC}"
    echo "  status         Mostra lo stato del progetto e dei dati"
    echo "  install        Inizializza l'ambiente virtuale e le dipendenze"
    echo "  run            Avvia il server locale per visualizzare il sito"
    echo "  stop           Arresta il server locale"
    echo "  backup         Crea un archivio ZIP di dati e configurazioni"
    echo "  clean          Rimuove l'ambiente virtuale e i file temporanei"
    echo ""
    echo -e "${YELLOW}Cloud:${NC}"
    echo "  deploy         Esegue il deploy su Cloudflare Pages (richiede wrangler)"
    echo ""
    echo -e "${BLUE}Supporto:${NC}"
    echo "  Sempre documentare in docs/V1 prima di modifiche strutturali."
}

# --- Main ---
case "$1" in
    status)         cmd_status ;;
    install)        check_python && ensure_venv ;;
    run)            cmd_run ;;
    stop)           cmd_stop ;;
    deploy)         cmd_deploy ;;
    backup)         cmd_backup ;;
    clean)          cmd_clean ;;
    help|--help|-h) cmd_help ;;
    *)              cmd_help ;;
esac