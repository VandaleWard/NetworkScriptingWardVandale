
=====================================================
Welkom bij mijn guide over hoe je mijn terraform en ansible code moet gaan runnen!

run terraform apply [plan]

je zult het gewenste wachtwoord van de vm moeten ingeven.

nadat je terraform gedeployed is, kun je het ansible script gaan runnen.

LET OP!! voor dit script heb je een .vault_pass bestand nodig, de content van die .vault_pass is 123

>>>>>>>> ansible-playbook ansible-config.yaml -i inventory.retry --vault-password-file=.vault_pass

als het commando niet werkt, zou het kunnen zijn dat je eerst eens een SSH-sessie moet openen naar de VM om er voor te zorgen dat de keys aangemaakt zijn.


De inventory en de tfvars zijn upgeload als een .txt bestand, hier moet je gewoon de .txt wegdoen om de juiste bestandsnamen te verkrijgen