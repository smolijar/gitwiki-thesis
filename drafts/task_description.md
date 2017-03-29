# Originální zadání

> Navrhněte a implementujte wiki systém s následujícími vlastnostmi.
> Wiki bude podporovat vícero wiki syntaxí (formou modulů); požadované jsou AsciiDoc a Markdown.
> Bude podporovat ploché jmenné prostory a ACL nastavitelné per jmenný prostor.
> Jako jediné úložiště bude využívat sadu Git repositářů, přičemž každý jmenný prostor bude separátní repositář (z důvodu řízení ACL).
> Vedle přímého přístupu přes Git bude poskytovat webové rozhraní umožňující wiki prohlížet, editovat a spravovat.
> Editor bude pracovat s čistým textem v dané syntaxi (tj. žádný WYSIWYG) a poskytovat živý náhled vyrenderovaného dokumentu.
> Wiki systém implementujte v jazyce Rust, JavaScript/Node.js, Lua, Ruby, nebo Python.
> Kód musí být srozumitelný a řádně otestovaný.

# Návrhy změn

> Navrhněte a implementujte wiki systém s následujícími vlastnostmi.

Sem bych zkusil nějakým způsobem vtěsnat stručně k čemu nebo pro koho ta aplikace je.

> Wiki bude podporovat vícero wiki syntaxí (formou modulů); požadované jsou AsciiDoc a Markdown. Bude podporovat ploché jmenné prostory a ACL nastavitelné per jmenný prostor.

> Jako jediné úložiště bude využívat sadu Git repositářů ~~přičemž každý jmenný prostor bude separátní repositář (z důvodu řízení ACL)~~.

*"přičemž každý jmenný prostor bude separátní repositář"* bych vynechal. Přesto že to bude nejspíš pravda, připadá mi to příliš konkrétní do zadání.

> Vedle přímého přístupu přes Git bude poskytovat webové rozhraní umožňující wiki prohlížet, editovat a spravovat.

> Editor bude pracovat s čistým textem v dané syntaxi (tj. žádný WYSIWYG) a poskytovat živý náhled vyrenderovaného dokumentu.

> Wiki systém implementujte v jazyce Rust, JavaScript/Node.js, Lua, Ruby, nebo Python.

Je zde nějaká konkrétní motivace za výběrem jazyků? Jde o Vaši preferenci nebo mají všechny jakzyky nějaký společný rys, který je činí vhodnými pro implementaci? Znám více znám jen JS a Python, s ostatními jsem jen po málu.

> Kód musí být srozumitelný a řádně otestovaný.
