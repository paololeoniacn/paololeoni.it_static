# 🧠 The CV Orchestrator

Un architettura a due livelli per la gestione e la visualizzazione del Portfolio e del CV in modo statico e resiliente, alimentata da una singola sorgente di verità JSON.

---

## 🏗️ Architettura del Progetto

Il progetto è strutturato in conformità al **Protocollo Cerniera** per garantire modularità, sicurezza e manutenibilità:

- **Area Admin (`/admin/`):** Backend statico per l'editing dei dati, la validazione e l'esportazione dinamica del CV (HTML/PDF). Progettato per essere protetto da ZeroTrust.
- **Frontend Pubblico (`/public/`):** Landing page ad alte prestazioni che carica dinamicamente i dati dal JSON centrale, mantenendo l'estetica premium originale.
- **Database (`/data/`):** Contiene `resumeData.json`, la sorgente di verità di tutto l'ecosistema.
- **Protocollo (`/docs/V1/`):** Documentazione tecnica, mappe di sviluppo e linee guida comportamentali per lo sviluppo assistito da AI.

---

## 🚀 Come Iniziare

### Sviluppo Locale
Poiché il progetto utilizza `fetch` per caricare i dati JSON, è necessario servirlo tramite un web server locale per evitare restrizioni CORS. È possibile utilizzare Python:

```bash
# Avvia il server dalla root
python3 -m http.server 8000
```
- Vai su `http://localhost:8000/public/` per vedere il sito pubblico.
- Vai su `http://localhost:8000/admin/` per accedere all'area editor.

### Deploy su Cloudflare Pages
Il progetto è configurato per il deploy tramite **Cloudflare Pages**. 
- Collegare il repository GitHub alla dashboard di Cloudflare.
- Impostare la directory di output su `.` (root) o configurare il routing per puntare a `/public/`.

---

## 🛠️ Governance e Automazione (`handle_project.sh`)

Il progetto include uno script di gestione centralizzata in conformità alla **Regola 8** del Protocollo Cerniera.

### Comandi Disponibili:
- `./handle_project.sh install`: Inizializza l'ambiente virtuale Python isolato (`.venv`) e le dipendenze.
- `./handle_project.sh status`: Verifica lo stato dei dati JSON e l'integrità delle directory.
- `./handle_project.sh backup`: Crea un archivio ZIP dei dati (`/data`) e della documentazione (`/docs`).
- `./handle_project.sh deploy`: Esegue il deploy su Cloudflare Pages (richiede wrangler).
- `./handle_project.sh clean`: Ripulisce l'ambiente locale (venv e cache).


---

## 🛠️ Modello Shared Services
Ogni modifica al progetto deve seguire la logica dei **4 Motori**:
1. **Extraction:** Caricamento e mapping dei dati (JS Fetch).
2. **Validation:** Controlli di integrità degli input nell'Admin area.
3. **Writer:** Salvataggio modifiche e generazione output PDF/HTML.
4. **Audit:** Tracciabilità delle modifiche apportate.

---

## 📁 Struttura Directory
Vedere [Guida Master](docs/V1/project_guide.md) per i dettagli sulla roadmap e l'organizzazione dei file.

---
**Powered by Antigravity AI — In conformità al Protocollo Cerniera V1.1**
