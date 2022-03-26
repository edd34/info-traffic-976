```
graph TD
    A[Ouverture app] -->|Initialisation et MAJ carte| B(Accueil : Affichage carte incident)
    B --> C{Décision}
    C -->|Ajouter alerte| E{Est connecté}
    G --> |Formulaire complet| I[Ajout Alerte] --> K["Confirmation localisation (après)"] --> L[Ajout rapport et description lieux] --> J
    C -->|Rafraichir incident| D[Rafraichissement manuel] --> |Fait| B
    G --> |Formulaire rapide| H[Ajout alerte] --> J[Validation] --> B
    E --> |Non| F[Page se connecter ou s'inscrire] --> |Fait| B
    E --> |Oui| G{Décision}
```

[![](https://mermaid.ink/img/pako:eNp1kttum0AQhl9ltDdxJOcFuIiED0njHlK1VW8gF6NlsCeFXbSHKJXx-9TP4RfLwBLXFy1XaPj5-L9Z9krbilSmtg67HfxYlQbkyovH-EIuREeAXfcENze3_YPhwNiwx8DWAAX4nG9AowvUw2KWax2JG8ggr2vWO9xSeghsNFdkwnWCLwYaLPer01GzF9QhzZfjV_JnGwM5wIZG8Hq_9gG0NYZ0OB2n7P3I6O-sa2ODLDW1bbuGQg8PxYiAfASM1eFjUaqlNTW7NpVvrP5rMsPOnf7461Kl9KeJICvprAuDaUVeO-7Su0zxNSU3l82_Ye1QxNmdjXtYFeex99TKDFo0kZqnyQBZUov_WUkFAfXwYaqEF1Kb4qc4VKNDmkyYdcJ8saaHu-LrcBCe3lcoq7UR_BWbwcjRv3pMgMfIPdxfnJOaq5ZkhVzJH7MfsqUKO7EqVSa3FbpfpSrHXOykGK0rDtaprMbG01xhDPb7b6NVFlyk99CKUf6-dkod3gBxod6y)](https://mermaid-js.github.io/mermaid-live-editor/edit#pako:eNp1kttum0AQhl9ltDdxJOcFuIiED0njHlK1VW8gF6NlsCeFXbSHKJXx-9TP4RfLwBLXFy1XaPj5-L9Z9krbilSmtg67HfxYlQbkyovH-EIuREeAXfcENze3_YPhwNiwx8DWAAX4nG9AowvUw2KWax2JG8ggr2vWO9xSeghsNFdkwnWCLwYaLPer01GzF9QhzZfjV_JnGwM5wIZG8Hq_9gG0NYZ0OB2n7P3I6O-sa2ODLDW1bbuGQg8PxYiAfASM1eFjUaqlNTW7NpVvrP5rMsPOnf7461Kl9KeJICvprAuDaUVeO-7Su0zxNSU3l82_Ye1QxNmdjXtYFeex99TKDFo0kZqnyQBZUov_WUkFAfXwYaqEF1Kb4qc4VKNDmkyYdcJ8saaHu-LrcBCe3lcoq7UR_BWbwcjRv3pMgMfIPdxfnJOaq5ZkhVzJH7MfsqUKO7EqVSa3FbpfpSrHXOykGK0rDtaprMbG01xhDPb7b6NVFlyk99CKUf6-dkod3gBxod6y)