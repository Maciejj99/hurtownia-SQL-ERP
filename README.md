# System ERP do Zarządzania Hurtownią (MySQL)

## Opis Projektu

Projekt ma na celu stworzenie systemu zarządzania hurtownią, który pozwala na zarządzanie danymi o produktach, klientach i zamówieniach. Użytkownicy mogą korzystać z systemu do śledzenia stanu magazynowego, generowania raportów sprzedaży oraz monitorowania historii transakcji. System został zbudowany z wykorzystaniem bazy danych MySQL oraz zapytań SQL do analizy danych.

## Projekt obejmuje:
- Strukturę bazy danych z tabelami dla produktów, klientów, zamówień itd.
- Przykładowe dane testowe do testowania systemu.
- Zapytania SQL do generowania raportów, np. sprzedaży miesięcznej, stanu magazynowego itp.

## Struktura Bazy Danych
Baza danych składa się z następujących tabel:
- Klienci: Przechowuje informacje o klientach.
- Dostawcy: Zarządza danymi dostawców.
- Produkty: Zawiera dane o produktach.
- Magazyn: Śledzi dostępny stan magazynowy.
- Zamówienia: Zarządza zamówieniami klientów.
- Pozycje Zamówienia: Przechowuje pozycje zamówień.
- Pracownicy: Zawiera dane o pracownikach.

## Diagram ERD
[Klienci] ----< [Zamówienia] ----< [Pozycje Zamówienia] >---- [Produkty] >---- [Dostawcy]
                      │
                  [Pracownicy]
                      │
                 [Magazyn]


## Przykładowe zapytania SQL

```sql
-- Wyświetlenie wszystkich klientów
SELECT * FROM Klienci;

-- Wyświetlenie zrealizowanych zamówień
SELECT * FROM Zamowienia WHERE status_zamowienia = 'Zrealizowane';

-- Stan magazynowy dla produktu o ID 1
SELECT * FROM Magazyn WHERE ID_Produktu = 1;
```
## Raporty 
```sql
-- Stan magazynowy 
SELECT p.nazwa AS produkt,
       m.ilosc_dostepna AS stan_magazynowy,
       m.lokalizacja
FROM Magazyn m
JOIN Produkty p ON m.ID_Produktu = p.ID
ORDER BY p.nazwa;
```
![image](https://github.com/user-attachments/assets/f1822937-a46e-4456-994a-0c2e297b437d)
```sql
-- Sprzedaż miesięczna
SELECT DATE_FORMAT(data_zamowienia, '%Y-%m') AS miesiac,
       SUM(pz.ilosc * pz.cena) AS suma_sprzedazy
FROM Zamowienia z
JOIN Pozycje_Zamowienia pz ON z.ID = pz.ID_Zamowienia
WHERE status_zamowienia = 'Zrealizowane'
GROUP BY miesiac;
```
![image](https://github.com/user-attachments/assets/f9799e5f-e929-4354-a7c1-f1554983cf16)
```sql
-- Klienci z największą liczbą zamówień
SELECT k.nazwa AS klient,
       COUNT(z.ID) AS liczba_zamowien
FROM Klienci k
JOIN Zamowienia z ON k.ID = z.ID_Klienta
GROUP BY k.nazwa
ORDER BY liczba_zamowien DESC
LIMIT 10;
```
![image](https://github.com/user-attachments/assets/cd6fecb3-d671-4027-8889-7af02facee51)
```sql
-- Produkty, które nigdy nie były zamawiane
SELECT p.ID AS id_produktu,
       p.nazwa AS produkt
FROM Produkty p
LEFT JOIN Pozycje_Zamowienia pz ON p.ID = pz.ID_Produktu
WHERE pz.ID_Produktu IS NULL;
```
![image](https://github.com/user-attachments/assets/b280f9c3-27f4-422c-b5ef-a845fe25ec08)
```sql
-- Najczęściej zamawiane produkty
SELECT p.nazwa AS produkt,
       SUM(pz.ilosc) AS laczna_ilosc
FROM Pozycje_Zamowienia pz
JOIN Produkty p ON pz.ID_Produktu = p.ID
GROUP BY p.nazwa
ORDER BY laczna_ilosc DESC
LIMIT 5;
```
![image](https://github.com/user-attachments/assets/5fb0c7fc-62cf-49dd-87ca-fec75a7f539c)





