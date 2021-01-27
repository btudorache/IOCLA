# Tema 4 - Exploit ELFs

Respectand traditia, Moș Crăciun s-a hotărât să împartă binare copiilor din satul UPB. Deoarece nu poate vedea în viitor, Moșul a scris 2 binare per persoană - unul pentru cazul în care am fost cuminți, iar altul pentru cazul în care am fost pe naughty list. Din pacate, curierii mosului au fost ocupati si au reusit abia acum sa livreze “cadourile”.

## Spargerea binarului nice

Pentru acest task, trebuie sa identificati vulnerabilitatea binarului sa generați un payload (va fi citit de la stdin) care va face programul să printeze un flag de forma: **NICE_FLAG{<sir_de_caractere>}**.

## Spargerea binarului naughty

Acelasi lucru ca si pentru binarul *nice*, sa se afle vulnerabilitatea si sa se genereze un payload care va face programul sa printeze un flag de forma **NAUGHTY_FLAG{<sir_de_caractere>}**.

## Shellcode

Generați un payload astfel încât să obțineți un shell folosind binarul *naughty*. Payloadul va fi consumat de la stdin. 
In esenta, trebuie sa se injecteze un [shellcode](https://en.wikipedia.org/wiki/Shellcode) in program.

Detaliile complete se gasesc in [enuntul temei](https://github.com/btudorache/IOCLA/blob/master/tema2/Enunt_IOCLA_Tema4.pdf)

Spargerea fiecarui binar in parte este explicata in *old_README*


