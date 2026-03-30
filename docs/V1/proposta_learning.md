# Proposta di Gestione Learning & Corsi in Corso

## Obiettivo
Implementare un sistema strutturato per tracciare i progressi dei corsi (come Anthropic Academy) all'interno di `resumeData.json`.

## Stato Attuale
- `education`: Gradi accademici (Master, Bachelor).
- `certifications`: Certificati singoli con data e link.

## Proposta: Nuova Sezione `learning`
Aggiungere una chiave `learning` o integrare un'estensione a `certifications` che supporti il progresso modulare.

### Struttura Suggerita:
```json
"learning": [
  {
    "corso": "Anthropic Academy",
    "status": "In Corso",
    "url": "https://verify.skilljar.com/",
    "moduli": [
      {
        "titolo": "Claude Code in Action",
        "data": "2026-03-30",
        "certificato_id": "a8jqxveos9tg",
        "link": "https://verify.skilljar.com/c/a8jqxveos9tg",
        "immagine": "images/Certifications/Anthropic_ClaudeCodeInAction.png",
        "pdf": "docs/Certificates/Anthropic_ClaudeCodeInAction.pdf"
      }
    ]
  }
]
```

## Protocollo: `nuovo_learning`
Creato sotto `.agents/workflows/nuovo_learning.md`.
1. **Scelta**: Nuovo Slot (1) o Aggiornamento Esistente (2).
2. **Raccolta Dati**: Input interattivo.
3. **Esecuzione**: Modifica atomica di `resumeData.json`.

## UI Integration
L'interfaccia dovrà essere aggiornata per leggere questa nuova sezione. Si suggerisce una visualizzazione a timeline o accordion per i moduli di una stessa academy.
