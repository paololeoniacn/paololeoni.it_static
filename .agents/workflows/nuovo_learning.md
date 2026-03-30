---
description: Nuovo Learning - Protocollo di inserimento e aggiornamento corsi/progressi
---

# Protocollo: Nuovo Learning

Questo workflow gestisce l'inserimento di nuovi corsi o l'aggiornamento di progressi (moduli/certificati) all'interno di `resumeData.json`.

## Regole di Esecuzione
1. **Analisi preliminare**: Controllare la presenza dell'Academy richiesta.
2. **Scelta Slot**:
   - **(1) Nuovo Slot**: Creare un nuovo contenitore per un corso (es. Anthropic Academy).
   - **(2) Inserimento Slot Esistente**: Aggiungere un modulo (certificato, link, immagine) a un'Academy già presente.
3. **Download Asset**: Se vengono forniti link a immagini o PDF, salvarli nelle cartelle appropriate (`web/images/Certifications/` o `web/docs/Certificates/`).
4. **Aggiornamento JSON**: Inserire i dati nella chiave `learning` (o `certifications` a seconda della scelta strutturale condivisa).

## Domande Obbligatorie
- "Stai creando uno slot nuovo (Anthropic Academy) o aggiungendo un modulo a uno esistente?" (1/2)
- "Qual è il titolo del modulo e il link al certificato?"
- "Qual è il link all'immagine o al PDF del certificato?"

## Struttura Dati Obiettivo
```json
{
  "titolo": "Claude Code in Action",
  "data": "March 30, 2026",
  "certificato_id": "a8jqxveos9tg",
  "link": "https://verify.skilljar.com/c/a8jqxveos9tg",
  "immagine": "images/Certifications/Anthropic_ClaudeCodeInAction.png",
  "pdf": "/docs/Certificates/Anthropic_ClaudeCodeInAction.pdf"
}
```

---
// turbo-all
**Utilizzo:**
Quando l'utente richiama "nuovo learning" o "nuovo corso", agire come segue:
1. Leggere questa guida.
2. Formulare la domanda (1/2) ed elaborare la risposta.
3. Eseguire l'operazione in `resumeData.json`.
