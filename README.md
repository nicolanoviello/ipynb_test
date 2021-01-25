# ipynb_test
Utilizzo
- Clonare la repository da testare
- Spostare i file requirements.txt e script.sh nella directory con la repository
- Eseguire il comando "sh script.sh"

Il risultato sarà composto da due file:
- lista.txt / Contenente tutte le versioni di un branch della repo
- report.txt / Contiene il report dell'analisi statica per gli .ipynb presenti in ogni versione

Per la creazione di un report sintetico è possibile eseguire il comando
$ sed '/^output/d' report.txt > report_clean.txt
