# Master Guide: The CV Orchestrator Project 🚀

## 1. Visione del Progetto
L'obiettivo è trasformare il portfolio personale da un monolite React (`paololeoni.it-old`) a un ecosistema a due livelli:
- **Backend (Admin):** Area privata per l'editing, la validazione e l'arricchimento dei dati.
- **Frontend (Public):** Sito statico ad alte prestazioni, con estetica premium, ottimizzato per i recruiter.

## 2. Architettura del Sistema
Il progetto segue il **Protocollo Cerniera** e si divide in moduli logici (Shared Services):

### A. Shared.Extraction (Data Ingestion)
- **Input:** `data/resumeData.json` (db iniziale).
- **Funzione:** Parsing e mapping dei dati per l'uso sia nell'Editor che nel sito pubblico.
- **Evoluzione:** Passaggio a database D1 (Cloudflare) per persistenza strutturata.

### B. Shared.Validation (Business Logic)
- **Funzione:** Verifica della coerenza dei dati (es. validità degli URL, formattazione date, sanitizzazione input).
- **Regola:** Impedire che un errore di editing nel backend rompa il layout del frontend pubblico.

### C. Shared.Writer (Output Generation)
- **Funzione 1:** Salvataggio dei dati arricchiti nel backend.
- **Funzione 2:** Generazione "on demand" del CV in formato HTML o PDF (basato sul motore `cv_editor_6.html`).

### D. Shared.AuditTrail (Governance)
- **Funzione:** Logging semplice delle modifiche effettuate nel backend per tracciabilità (Compliance SOA-like).

## 3. Struttura delle Directory
```text
/
├── admin/            # Backend: Editor Admin (Evoluzione di cv_editor_6)
├── public/           # Frontend: Sito statico (Estetica paololeoni.it-old)
│   ├── assets/       # CSS, Immagini, Font (IBM Plex / Montserrat)
│   └── js/           # Moduli rendering statico
├── data/             # Database JSON (resumeData.json)
├── scripts/          # Utility automazione Python
├── docs/V1/          # Documentazione e report analisi (Protocollo Cerniera)
└── wrangler.toml     # Configurazione Deploy (Cloudflare Pages)
```

## 4. Esperienza Utente (UX)
### Recruiter (User)
- Viene accolto da un sito veloce e professionale (Frontend).
- Può navigare le sezioni (Work, Skills, Portfolio) senza caricamenti pesanti.
- Scarica il CV aggiornato con un click (HTML/PDF).

### Owner (Admin)
- Accede tramite path protetto (es. `/admin` o tramite ZeroTrust).
- Modifica sezioni in tempo reale con preview immediata.
- Propone modifiche -> Valida -> Registra (Salva).

## 5. Roadmap di Sviluppo
1.  **Phase I: Backend Focus** (DONE)
2.  **Phase II: Data Migration** (DONE)
3.  **Phase III: Frontend Reveal** (DONE)
4.  **Phase IV: Unified R2 Persistence & ZeroTrust** (ACTIVE 🚀)
    *   Sorgente di verità spostata sul Bucket R2: `paololeoni-orchestrator`.
    *   Area `/admin` protetta da Cloudflare Zero Trust (Email OTP/GitHub SSO).
    *   Separazione totale tra codice statico e database dinamico.

---
**Stato:** Progetto in configurazione nativa Cloud (R2 + Workers + Zero Trust).
