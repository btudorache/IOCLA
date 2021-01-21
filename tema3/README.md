# Tema 2

Să se implementeze o funcție în limbaj de asamblare care efectuează parsarea unei expresii matematice în formă prefixată și construiește un **AST (abstract syntax tree)**. Numerele ce apar în expresie sunt numere întregi cu semn, pe 32 de biți, iar operațiile ce se aplică lor sunt: ```+, -, /, *```. Expresia prefixată va fi primita sub forma unui șir de caractere ce este dat ca parametru funcției, rezultatul fiind un pointer către nodul rădăcină al arborelui, salvat in registrul **EAX**.

## Arbore sintactic abstract

Arborii sintactici abstracți sunt o structură de date cu ajutorul căreia compilatoarele reprezintă structura unui program.

În urma parcurgerii AST-ului, un compilator generează metadatele necesare transformării din cod de nivel înalt în cod assembly. [Mai multe informatii despre AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree).

## Implementare

Programul va folosi ca input un string în care se află parcurgerea preordine a arborelui, în ordinea, **rădăcină, stânga, dreapta**, ce poarta numele de [Forma poloneza prefixată](https://en.wikipedia.org/wiki/Polish_notation). Această expresie trebuie transformată în arbore de către functia: 

```
create_tree(char* token)
```

Mai mult, veți avea de implementat funcția iocla_atoi (in același fișier), care are o funționalitate similară funcției atoi din C:

```
int iocla_atoi(char* token)
```

Detaliile complete se gasesc in [enuntul temei](https://github.com/btudorache/IOCLA/blob/master/tema3/Enunt_IOCLA_Tema3.pdf)