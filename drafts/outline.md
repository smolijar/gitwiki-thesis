## Úvod

## Analýza

### Obchodní procesy

Vzal bych si jeden nebo dva možné účely použití aplikace (například dokumentace a studentský portál) a sestrojil pro ne několik obchodních procesu nad budoucí aplikaci. Čtenáři bude jasnější k čemu aplikace je a možná se objeví některé potřeby nebo nápady které by nás jen tak při psaní požadavků nenapadly.

### Požadavky

Formální model funkcnich a nefunkčních požadavků

### Případy užití

Formální model případů užití. Hlavním přínosem kromě přesnější definice funkčních požadavků bude vyjasnění přístupu pres SSH vs WUI, což se dá dobře na diagramech ilustrovat. Tabulku pokryti požadavků.

### Definice person

Persóny pro návrh UI a testování použitelnosti.
Zde bude přesněji definován cílový uživatel. Vytvořeno bude více person pro více účelu aplikace a bude přesněji řečeno, co od nich předpokládáme a tak.

## Rešerše

### Hotová řešení

Projít řešení která už existuji, tedy wiki podobné systémy využívající VCS. Shrnout jejich plusy minusy a vyvodit závěry pro návrh/implementaci.

### Wiki

Stejný důvod jako s hotovými řešeními, kladen důraz na UI a editační rozhraní.

Hotových wiki systémů používající Git bude možná nedostatek, takže pokud by výstup předchozí sekce byl příliš chudý, je možné dohnat zde.

### Uživatelské rozhraní

Sumarizace důležitých poznatků ze zkoumaných aplikací. Čistě z pohledu UI.

### Textové editory

Featury embeddovaných editorů, jejich použitelnost. Shrnutí pro návrh editoru.

### Značkovací jazyky

Rozbor jazyku asciidoc a md. Pokud maji tak gramatiky uvést, vybrat dialekty. Porovnat expresivitu jazyku, ev. navrhnout další jazyky, které by bylo vhodné v budoucnu přidat.

### Komunikace s Git

Možnosti komunikace s Git z aplikace, výběr knihovny.

### Řízení přístupu Git

Dtto pro autorizační vrstvu

### Frontend framework

Na serveru bude myslím jen několik menších knihoven. Pro frontend bude asi vhodné zvolit nějaký framework jako React nebo Angular, který bude z velké části strukturu frontendové aplikace definovat. Rozhodnutí bude tedy asi zásadnější.

## Návrh

### Architektura

Popis aplikace jako celku, komunikace jednotlivých částí, definice rozhraní.

### Server

Návrh serverové aplikace. Návrh modulů, API, git.

### Klient

Návrh klientské aplikace - popis a komunikace komponent. Koncepční návrh editoru a jeho modularity.

### UI

Návrh UI. Wireframes. Několik stěžejních snímků aplikace, vyresit navigaci atd. Zejména také textový editor.

## Implementace

Struktura vyplyne z vlastní implementace

## Testování

### Funkční testy

Zřejmě jednotkové testy stejně jako end-to-end/integrační/systémové pro testování API.

### Testy použitelnosti

Rád bych uspořádal lidské testování použitelnosti. Snad půjde spojit s předmětem NUR

## Závěr

