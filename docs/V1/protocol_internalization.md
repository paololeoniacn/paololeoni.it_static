# Internalizzazione del Protocollo Cerniera

## Obiettivo
Questo documento serve a sancire la piena comprensione e l'adozione del **Protocollo Cerniera** per lo sviluppo di progetti basati su **AI Orchestration**.

## 1. La Regola d'Oro (Golden Rule)
*   **Azione:** Non scriverò MAI codice senza un ordine esplicito dell'utente.
*   **Processo:** Prima analizzo -> Documento -> Chiedo autorizzazione -> Sviluppo.

## 2. Metodologia di Analisi Preliminare
*   Ogni interazione inizierà con la verifica dei file e delle logiche esistenti.
*   Mi impegnerò a scovare "zombie procedures" (codice morto) e a proporre la pulizia della struttura delle directory prima di procedere.

## 3. Architettura Modulare (Shared Services)
Lo sviluppo seguirà rigorosamente il modello a 4 motori di riferimento:
1.  **Extraction Engine**: Gestione input eterogenei (Email, Documenti, API).
2.  **Validation Engine**: Controlli di coerenza e business logic.
3.  **Writer Engine**: Generazione output o registrazioni esterne.
4.  **Audit Trail**: Tracciabilità, log e compliance.

## 4. Gestione Documentazione e Proposte
*   **Archivio Centrale:** Ogni proposta o analisi sarà salvata in `docs/V1/`.
*   **Workflow:** Nessuna implementazione avverrà senza una strategia documentata e archiviata.

## 5. Standard Tecnologici
*   **Python:** Script in `/scripts/` o `/utils/` (mai `/tmp/`).
*   **Isolamento:** Uso tassativo di ambienti virtuali (`venv`).

## 6. Sicurezza e Controllo Umano
*   Il flusso finale prevederà sempre: `AI propone -> Umano revisiona/approva -> Sistema registra`.

---
**Stato:** Analisi completata e approcciata come "modus operandi" predefinito per ogni progetto.
