# Stručný popis z různých pohledů

1. Aplikace zprostředkovává přístup k jednotlivým, obecně nesouvisejícím, odděleným obsahům (jednotlivým *wiki*). 
2. Veškerý datový obsah je uložený v git repozitářích.
3. Aplikace je určená pro technicky zaměřené uživatele. Předpokládá se užovatelksá znalost alespoň jedné podporované wiki sytaxe a je nežádoucí skrývat všechny technické stránky aplikace. Například nabízet editaci skrze wysiwyg editor je nevhodné, protože uživatel syntaxi zná. Aplikace by měla poskytovat pohodlné uživatelské rozhraní, ale také by měla být pro technicky zdatné uživatele zcela transparentní. Uživatel, který zná git na uživatelské úrovni, by měl snadno vědět, co aplikace provádí za kroky s repozitáři.

### Uživatelé a rozhraní a interakce

1. Uživatel může spravovat wiki skrze přímý přístup přes git pomocí SSH nebo přes webové rozhraní (podobně jako u služeb GitHub, GitLab, Bitbucket, ...). Narozdíl od těchto služeb, je však v aplikaci akcentováno použití webového rozhraní pro plnohodnotné rozhraní pro editaci. Zmíněné služby totiž často nabízejí editaci obsahu skrz webové rozhraní, ale v například v omezené míře (editace README), předpokládá se webové rozhraní spíše pro čtení a sledování historie repozitáře.
2. Před použitím si musí užiatel vytvořit účet přes webové rozhraní. Po přihlášení do aplikace může spravovat wiki přes toto rozhraní, nebo uložit veřejný klíč pro autentizaci SSH přístupu.
3. Při přímém přístupu přes git je uživatel plně zodpovědný za změny, které provede a aplikace provádí pouze kontrolu autorizace vůči repozitáři.

### ACL

Pro každou jednotlivou wiki, je možné nastavit práva existujícím uživatelům pro čtení a zápis zvlášť. Aplikace kontroluje přístup přes SSH tak přes webové rozhraní.

Data potřebná k autentizaci i autorizaci uživatelů jsou verozvána v git repozitáři. Je tedy možné je editovat ACL přes SSH.

### Příklady použití

#### Studijní materiály

Několik studentů si spustí vlastní server. Každý předmět má jeden repozitář (vlastní wiki), který spravuje jeden student a dává přístupy kolegům. Studenti přispívají svými poznámkami, které následně spolu s moderátory daných předmětů popřípadě agregují do tématických celků, tvořících ucelený přehled dané látky.

```
PA1/
	Lecture/1/
		Notes.md
	Lab/1/
		HelloWorld.c
		comment.md
	Misc/
		Recursion.txt
ZMA/
	...
```

#### Dokumentace

Acme provozuje technickou podporu pro aplikace Foo, Bar a Baz, pro které každý týden aktualizuje uživatelské manuály. Manuály jsou strojově zpracovány do výsledného dokumentu.

```
Foo/
	Install/
		Requirements.md
	Usage/
		...
	FAQ/
Bar/
	...
Baz/
	...
```

S aplikací se správci manuálů nemusí starat o verzovaní manuálů. Stačí pouze na daný comit ve wiki např. zavěsti tag.

#### Odborné články

Univerzita Qux umožňuje studentům a zaměstnancm využití aplikace pro psaní odborných textů. Pomocí vlastního skriptu generují z LML[^lml] souborů jednotné sazby textů a tak se autoři mohou starat pouze o obsah.

[^lml]: lightweright markup language

#### Veřejná služba

Veřejný server s aplikací umožňuje libovolným nesouvisejícím uživatelům spravovat vlastní repozitáře. Samotné repozitáře mají tedy zcela heterogenní strukturu a slouží individuálním potřebám každého užviatele, například včetně i výše zmíněným příkladům užití.