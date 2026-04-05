# 🧠 The CV Orchestrator V3 (Unified Cloud)

Un'architettura nativa Cloud per la gestione e la visualizzazione del Portfolio e del CV in modalità "Segregata", alimentata da un **Bucket Cloudflare R2** e protetta da **Zero Trust**.

---

## 🏗️ Architettura del Progetto (V3 Unified)

Il progetto segue rigorosamente il **Protocollo Cerniera** separando l'ambiente statico (Pages) dai dati dinamici (R2):

-   **Backend & Data (Cloudflare R2)**: Sorgente di verità dinamica (`paololeoni-orchestrator/db/resumeData.json`).
-   **Static Bundle (/web/)**: Il codice del sito deployato su Cloudflare Pages.
    -   **Frontend Pubblico**: Carica i dati dall'Edge.
    -   **Area Admin**: Integrazione diretta con R2 + Protezione Zero Trust attiva.

---

## 🚀 Sviluppo e Gestione Locale

### Comandi Disponibili:
-   `./handle_project.sh run`: Server locale classico (file fissi).
-   `./handle_project.sh run-remote`: Server locale collegato al Database R2 online.
-   `./handle_project.sh r2-push`: Sincronizzazione locale -> Cloud.
-   `./handle_project.sh r2-pull`: Sincronizzazione Cloud -> locale.

---

## 🌐 Deploy Online (Cloudflare Pages)

Il deploy carica solo la parte statica delle interfacce. I contenuti sono gestiti dinamicamente via API.

-   **Produzione**: `https://paololeoni.pages.dev/`
-   **Admin**: `https://paololeoni.pages.dev/admin/` (Protetto da Zero Trust)

---

## 📁 Governance Master
Ogni modifica al progetto deve essere documentata in `docs/`. Progetto in configurazione nativa a singola fonte di verità globale.

---
**Powered by Antigravity AI — In conformità al Protocollo Cerniera V3.0**
