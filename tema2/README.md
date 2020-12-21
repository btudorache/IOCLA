# Tema 2 - strings

Tema consta in implementarea mai multor algoritmi de criptare si alte functii auxiliare in **Assembly Intel x86**.

## One Time Pad

Prima oara, Gigel dorește să implementeze One Time Pad. Algoritmul constă in efectuarea operţiei **XOR** între un mesaj(plain) şi o cheie(key), de aceeaşi lungime cu mesajul, astfel:

```
 cipher[i] = plain[i] ^ key[i] 
```

Antetul funcţiei, în C, este:

```
void otp(char *ciphertext, char *plaintext, char *key, int length)
```

## Caesar Cipher

Cifrul primeşte un mesaj şi o cheie, reprezentată de un număr, şi **deplasează circular** fiecare literă din mesaj cu valoarea specificată de cheie. Prin deplasare circulară se înţelege că literele mici vor rămâne, după deplasare, litere mici, iar literele mari vor rămane litere mari.

Exemplu de criptare, pentru mesajul **“Azazel”**, folosind cheile 0, 1, 2, 3:

| Cheie         | Codificare    |
| :-----------: |:-------------:|
| 0             | Azazel        |
| 1             | Babafm        |
| 2             | Cbcbgn        |
| 3             | Dcdcho        |

Antetul funcţiei, în C, este:

```
void caesar(char *ciphertext, char *plaintext, int key, int length)
```

## Vigenere Cipher

Cifrul primeşte mesajul ce urmeaza să fie criptat şi o cheie, reprezentată de un şir de majuscule. În cazul în care cheia este mai scurtă decât mesajul, aceasta **se extinde la lungimea mesajului**, prin repetarea cheii initiale. Apoi, fiecare literă din mesaj este **deplasată circular la dreapta** de un număr de ori egal cu poziţia în alfabet (începând de la poziţia 0) a literei corespunzătoare din cheie.

Exemplu de criptare:

```
Mesaj:         Donald Trump
Cheie:         BIDEN
Cheie extinsă: BIDENB IDENBI
Mesaj criptat: Ewqeye Buyzq
```

Antetul funcţiei, în C, este:

```
void vigenere(char *ciphertext, char *plaintext, int plaintext_len, char *key, int key_len)
```

## StrStr

SrtStr este o funcție ce găsește prima apariție a unui subșir intr-un șir sursă. Se cere implementarea sa in assembley.

Antetul funcţiei, în C, este:

```
void my_strstr(int *substr_index, char *haystack, char *needle, int haystack_len, int needle_len);
```

## Binary to Hexadecimal

Se cere implementarea unei funcții ce va trece numerele din baza 2 in baza 16 in assembly.

Antetul funcţiei, în C, este:

```
void bin_to_hex(char *hexa_value, char *bin_sequence, int length);
```

Detaliile complete se gasesc in [enuntul temei](https://github.com/btudorache/IOCLA/blob/master/tema2/Enunt_IOCLA_Tema2.pdf)
