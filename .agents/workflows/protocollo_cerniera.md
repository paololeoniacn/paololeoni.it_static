---
description: Protocollo Cerniera - Regole di comportamento per lo sviluppo dell'AI Orchestrator
---

# Protocollo Cerniera

Questo workflow definisce le regole di ingaggio e comportamento per lo sviluppo di progetti basati su **AI Orchestration**.

## 1. Regola d'Oro
**Prima documentiamo e capiamo, solo dopo ordine esplicito dell'utente si scrive codice.**

## 2. Analisi Preliminare
Ogni fase deve iniziare con un'analisi approfondita:
- Capire se tutti i file presenti sono necessari.
- Fare pulizia a livello di organizzazione dei file (struttura directory logica).
- Identificare refusi o "zombie procedures" (codice o logiche morte/inutilizzate).

## 3. Ottimizzazione Costante
- Identificare monoliti e proporre una scomposizione in micro-servizi o componenti modulari (Shared Services).
- Segnalare stranezze o logiche controintuitive prima di implementarle.

## 4. Reporting e Archiviazione
- Ogni analisi, decisione tecnica o proposta deve essere riportata in un file `.md` dedicato.
- **Tutta la documentazione (piani di implementazione, analisi, etc.) deve essere salvata nella cartella `docs/V1/`.**
- Non procedere all'implementazione senza aver prima archiviato la strategia nel report di analisi in `docs/V1/`.

## 5. Strumenti Python e Ambiente Sviluppo
- L'uso di script e utility Python per automatizzare l'analisi o lo sviluppo è incoraggiato.
- **Tutti gli script devono essere archiviati all'interno della cartella di progetto (es. `/scripts/` o `/utils/`), mai in `/tmp/`.**
- Per ogni progetto deve essere creato e utilizzato un ambiente virtuale (**`venv`**) dedicato, al fine di isolare le dipendenze ed evitare l'installazione di librerie globali non necessarie.

Lo sviluppo deve seguire l'architettura dei 4 Shared Services di riferimento:
1. **Extraction Engine**: Gestore input (Email, Documenti, API, etc.).
2. **Validation Engine**: Motore di controllo e validazione business rules.
3. **Writer Engine**: Genera output o effettua registrazioni su sistemi di destinazione.
4. **Audit Trail**: Logging, tracciabilità e compliance.

Il sistema deve sempre prevedere un passaggio di approvazione umana prima della registrazione o dell'invio dei dati:
`Agent propone → umano approva → Sistema registra`

---

## 8. Regola 8: Governance e Automazione Standard
Ogni progetto deve includere uno script di gestione `handle_project.sh` nella root. Lo script deve implementare:
1.  **Isolamento (Venv):** Gestione automatica di un ambiente virtuale Python locale (`.venv`) per evitare inquinamento dell'ambiente host.
2.  **Comandi Standard:** `status` (check integrità), `install` (setup dipendenze), `clean` (pulizia cache/venv), `deploy` (pubblicazione).

### Workflow Creazione Nuovo Progetto
Quando l'utente richiede la creazione di un nuovo progetto, l'AI deve AUTOMATICAMENTE:
1.  Creare la struttura di cartelle logica (es. `public`, `admin`, `data`, `docs`, `scripts`).
2.  Creare un `README.md` professionale e descrittivo.
3.  Creare un `.gitignore` completo che includa l'isolamento `.venv`.
4.  Creare il file `handle_project.sh` specifico per lo scopo del progetto, includendo la logica di gestione venv automatica.
5.  Documentare lo stato iniziale in `docs/V1/project_guide.md`.