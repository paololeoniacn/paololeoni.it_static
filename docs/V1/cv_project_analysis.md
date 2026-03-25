# Analisi Progetto: Transizione da React Portfolio a Static CV Orchestrator

## 1. Stato Attuale (Legacy: `paololeoni.it-old`)
- **Framework:** React 16.2.
- **Data Source:** `public/resumeData.json` (JSON strutturato con info personali, skills, esperienze, portfolio e testimonianze).
- **Architettura:** Monolite React con componenti divisi in `containers` (sezioni della pagina) e `components` (UI atomica).
- **Stile:** Basato su template Legacy Portfolio (probabilmente Ceevee), con uso intensivo di jQuery e librerie esterne per animazioni.
- **Zombie Logic identified:** Presenza di script PowerShell (.ps1) per build Windows rari in questo contesto, diversi componenti non utilizzati nelle rotte principali.

## 2. Modello di Riferimento (Target: `cv_editor_leoni (6).html`)
- **Tecnologia:** HTML5/CSS3/Vanilla JS (Single File).
- **Paradigma:** Editor + Live Preview.
- **Estetica:** Moderna, tema scuro (Ink/Paper/Accent), font IBM Plex, design minimalista e professionale.
- **Funzionalità core:** 
    - Caricamento dati da `localStorage` o default.
    - Interfaccia tabbed per editing sezioni.
    - Preview responsive immediata.
    - Export HTML (statico).

## 3. Obiettivo Trasformazione
Replicare lo scopo e l'estetica del CV Editor, rendendolo però il "front-end" statico principale del sito, alimentato dal `resumeData.json` esistente.

### Struttura Logica Proposta
1.  **Data Layer:** Integrazione del `resumeData.json` come sorgente di verità iniziale. 
2.  **Logic Layer (JS):** 
    - `Shared.Extraction`: Script per caricare il JSON e mappare i campi nel formato atteso dall'editor.
    - `Shared.Validation`: Sanitizzazione dei dati e regole di business (es. date, link social).
    - `Shared.View`: Motore di rendering (DOM Manipulation) per la preview e il sito pubblico.
3.  **Presentation Layer (HTML/CSS):** 
    - Unico file `index.html` per il sito statico.
    - CSS modulare basato sui token definiti nel CV Editor (IBM Plex, palette scura).

## 4. Prossimi Passi (Previa Approvazione)
- Creazione struttura directory `static/` (o root se preferito).
- Mapping dei campi tra `resumeData.json` (vecchio) e `DEFAULT_DATA` (nuovo editor).
- Implementazione del caricamento dinamico del JSON.
- Generazione della versione HTML statica finale.

---
**Documento redatto in conformità al Protocollo Cerniera (V1.1).**
