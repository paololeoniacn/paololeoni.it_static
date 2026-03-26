# Opzione C: Design System e Componentizzazione Frontend

## Contesto
L'estetica dell'applicazione (front e back) è curatissima, utilizzando stili complessi (Glassmorphism dinamico, layout a griglie con Neon-animations categorizzati) attualmente codificati "in-page".

## Obiettivi
Istituire un **Design System** formale per garantire coerenza, solidità operativa e manutenibilità estrema.
- Mappatura delle variabili `ROOT` CSS (tipografia `Outfit`/`IBM Plex`, scalatura cromatica e variabili `--glass`).
- Standardizzazione dei pattern UI/UX usati per la dashboard Admin (`.editor-container`, `.entry-card`) e nel sito Public (le "bin cards", micro-animazioni come `.wave`).
- Creazione di una Style Guide tecnica da cui attingere in futuro in caso di scale-up (es. migrazione a framework come React/Next.js mantenendo le stesse primitive architetturali visive, o rilascio di una sezione Blog).
