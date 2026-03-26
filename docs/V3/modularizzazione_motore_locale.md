# Opzione A: Modularizzazione del Motore Locale (Strict Protocollo Cerniera)

## Contesto
Attualmente `server.py` funge da monolite: riceve un JSON tramite POST e lo scrive direttamente su disco senza validazioni o tracciamento avanzato. 

## Obiettivi (Shared Services)
Applicare rigorosamente le regole del **Protocollo Cerniera** trasformando `server.py` in un Orchestratore strutturato, dividendolo nei 4 layer previsti:
1. **Extraction Engine**: Endpoint API e parsing sicuro del backend locale.
2. **Validation Engine**: Validazione stretta dei tipi di dato e integrità semantica (es. URL corretti, limitazione campi obbligatori) per evitare che un errore in Admin corrompa la Single Source of Truth.
3. **Writer Engine**: Il dumper JSON, arricchito con gestione automatica di logica di backup pre-scrittura.
4. **Audit Trail**: Sistema di logging strutturato per tracciare orari, timestamp e differenze delle modifiche applicate ("diff") su un logger apposito.
