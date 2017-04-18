# Originální zadání

> Navrhněte a implementujte wiki systém s následujícími vlastnostmi.
> Wiki bude podporovat vícero wiki syntaxí (formou modulů); požadované jsou AsciiDoc a Markdown.
> Bude podporovat ploché jmenné prostory a ACL nastavitelné per jmenný prostor.
> Jako jediné úložiště bude využívat sadu Git repositářů, přičemž každý jmenný prostor bude separátní repositář (z důvodu řízení ACL).
> Vedle přímého přístupu přes Git bude poskytovat webové rozhraní umožňující wiki prohlížet, editovat a spravovat.
> Editor bude pracovat s čistým textem v dané syntaxi (tj. žádný WYSIWYG) a poskytovat živý náhled vyrenderovaného dokumentu.
> Wiki systém implementujte v jazyce Rust, JavaScript/Node.js, Lua, Ruby, nebo Python.
> Kód musí být srozumitelný a řádně otestovaný.

# Návrh zadání

>Navrhněte a implementujte wiki systém podporující vícero wiki syntaxí (formou modulů); požadované jsou AsciiDoc a Markdown.
>Systém bude podporovat ploché jmenné prostory a ACL nastavitelné per jmenný prostor.
>Jako jediné úložiště bude využívat sadu Git repositářů, což umožní plnohodnotný přístup přes Git.
>Vedle přímého přístupu přes Git bude poskytovat webové rozhraní umožňující wiki prohlížet, editovat a spravovat.
>Editor bude pracovat s čistým textem v dané syntaxi (tj. žádný WYSIWYG) a poskytovat živý náhled  vykresleného obsahu.
>Systém bude použitelný například pro psaní uživatelských příruček či dokumentací a rozšiřitelný pro psaní odborných textů.
>Při návrhu předpokládejte, že uživatelé znají základy podporované wiki syntaxe.
>Nalzeněte vhodný kompromis, mezi pohodlnou uživatelskou interackí a transparentní sprvou Git repozitárů pro uživatele znalé VCS.
>Wiki systém implementujte v jazyce JavaScript/Node.js.
>Kód musí být srozumitelný a řádně otestovaný.
