# Tema 1 - printf

```printf``` este o funcție din biblioteca standard C care afișeaza la ```stdout``` datele primite ca argumente formatate după un anumit șablon, primit de asemenea ca prim argument. Semnătura acestei funcții este:

```
int printf(const char *format, ...);
```

Primul parametru al funcției se numește format string și este cel care determină ce afișează ```printf```. Acesta este un șir de caractere format din zero sau mai multe directive:

* caractere obișnuite (cu excepția lui ```%```), care sunt afișate neschimbate la output;

* specificații de conversie, care rezultă în consumarea a zero sau mai multe argumente;

Specificatorii ce vor fi implementați sunt următorii:

* ```%d``` întreg, convertit la reprezentare zecimală, cu semn;

* ```%u``` întreg, convertit la reprezentare zecimală, fara semn;

* ```%x``` întreg, convertit la reprezentare hexazecimală, fara semn;

* ```%c``` caracter, convertit la reprezentarea ASCII;

* ```%s``` pointer la un șir de caractere, ce va fi afișat neschimbat;

Detaliile complete se gasesc in [enuntul problemei](https://github.com/btudorache/IOCLA/blob/master/tema1/Enunt_IOCLA_Tema1.pdf)