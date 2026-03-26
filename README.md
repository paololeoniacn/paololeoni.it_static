# 🧠 The CV Orchestrator V2

Un'architettura a due livelli per la gestione e la visualizzazione del Portfolio e del CV in modalità "Segregata", alimentata da una singola sorgente di verità JSON e ottimizzata per il deploy professionale su Cloudflare Pages.

---

## 🏗️ Architettura del Progetto (V2 Segregated)

Il progetto segue rigorosamente il **Protocollo Cerniera** per garantire sicurezza, separando l'ambiente di sviluppo e gestione dall'ambiente di produzione pubblico:

- **Directory di Deploy (`/web/`):** L'unica cartella caricata online. Contiene:
    - **Frontend Pubblico (`/web/index.html`):** Landing page dinamica ad alte prestazioni.
    - **Area Admin (`/web/admin/`):** Pannello statico per l'editing e l'esportazione PDF/HTML.
    - **Database (`/web/data/`):** `resumeData.json`, la "Single Source of Truth".
- **Ambiente di Gestione (Root - OFFLINE):** File protetti che non vengono mai caricati online:
    - **Orchestration Server (`server.py`):** Gestisce il salvataggio dei dati in locale.
    - **Manager script (`handle_project.sh`):** Automazione di tutte le operazioni di ciclo vita.
    - **Documentation (`/docs/`):** Roadmap V3, schemi architetturali e linee guida.

---

## 🚀 Sviluppo e Gestione Locale

In conformità alla **Regola 8** del Protocollo Cerniera, tutte le operazioni sono centralizzate nello script di gestione.

### Comandi Disponibili:
- `./handle_project.sh install`: Inizializza l'ambiente virtuale Python isolato (`.venv`) e le dipendenze.
- `./handle_project.sh run`: Avvia il server locale sulla porta **8081**. 
    - Vai su `http://localhost:8081/web/` per il sito pubblico.
    - Vai su `http://localhost:8081/web/admin/` per l'area editor.
- `./handle_project.sh status`: Verifica l'integrità dei dati JSON e della struttura `web/`.
- `./handle_project.sh backup`: Crea un archivio ZIP della cartella `web/` e della documentazione `docs/`.
- `./handle_project.sh stop`: Arresta in sicurezza il server locale.
- `./handle_project.sh clean`: Rimuove l'ambiente virtuale e i file temporanei.

---

## 🌐 Deploy Online (Cloudflare Pages)

Il deploy è automatizzato e sicuro grazie a **Wrangler**.

### Comando:
```bash
./handle_project.sh deploy
```

### Cosa Aspettarsi:
1. **Segregazione**: Lo script carica **solo** la cartella `web/`. File come `server.py` o i tuoi script di gestione rimangono invisibili all'esterno.
2. **URL di Produzione**: Il sito sarà ospitato su `https://paololeoni.pages.dev/`.
3. **Zero Trust Ready**: La directory `/web/admin/` è pronta per essere protetta da una policy di accesso Cloudflare Zero Trust (Email OTP o GitHub SSO).

---

## 📁 Governance Master
Ogni modifica al progetto deve essere documentata in `docs/V2/` prima dell'implementazione. Consulta i piani per la **V3 (Edge Database & Zero Trust)** per i futuri step evolutivi.

---
**Powered by Antigravity AI — In conformità al Protocollo Cerniera V2.0**
