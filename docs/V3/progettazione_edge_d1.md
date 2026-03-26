# Opzione B: Progettazione Architettura V3 (Cloudflare Edge & D1 Database)

## Contesto
Secondo i limiti architetturali attuali (`V2.md`), l'area `/admin/` deployata su Cloudflare Pages è priva di runtime filesystem, rendendo il tasto "Save" inefficace in produzione.

## Obiettivi
Svincolare lo stato applicativo dal disco fisico (file JSON) ed evolvere il sistema applicando pattern architetturali **Serverless Edge**.
- **Cloudflare Worker (FaaS)**: Sviluppare una API esposta edge per gestire le operazioni CRUD create dall'Admin.
- **Cloudflare D1 (SQLite)**: Trasformare la logica del `resumeData.json` mappandola su un database transazionale relazionale ospitato sull'Edge network diffuso.
- **Autenticazione**: Proteggere questi endpoint tramite token autorizzativi, sbloccando finalmente la possibilità di gestire l'orchestrazione online e in mobilità in totale sicurezza.
