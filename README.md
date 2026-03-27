(Machine Translation / English below)

1. Beschreibung

R-Skript zur Berechnung der tariflichen Einkommensteuer (§ 32a EStG) und
des Solidaritätszuschlags (§ 4 SolZG) für die Veranlagungszeiträume (VZ)
2008 bis 2020 im Rahmen der Bestimmung der Mindestbesoldung.

Bitte beachten: Ab VZ 2021 gelten durch das Gesetz zur Rückführung des
Solidaritätszuschlags 1995 vom 10. Dezember 2019 (BGBl I S. 2115) stark
erhöhte Freigrenzen und eine neue Milderungszone. Bei Erweiterung dieses
Skripts auf die neue Rechtslage durch den Nutzer ist dies unbedingt zu
berücksichtigen.

2. Funktionen

`calc_est(year, zvE, joint)` | Tarifliche Einkommensteuer nach § 32a EStG |
`calc_soli(est, joint)` | Solidaritätszuschlag nach § 4 SolZG |

`joint = TRUE` (Default) | Splittingtarif (Zusammenveranlagung)
`joint = FALSE`  Grundtarif (Einzelveranlagung)

Der Default ist Zusammenveranlagung, weil das BVerfG im Rahmen der
Mindestbesoldung mit dem Splittingtarif rechnet (s. BVerfGE 155, 1 <66 ff.
Rn. 148 ff.>).

3. Input

Das Skript erwartet eine CSV-Datei `zve_input.csv`:

- Semikolon-getrennt, Dezimalkomma
- Erste Zeile (Header): Jahreszahlen (`2008;2009;...;2020`)
- Folgezeilen: Zu versteuerndes Einkommen (zvE, § 2 Abs. 5 Satz 1 Hs. 1 EStG) in Euro je
  Besoldungsgruppe

Beispiel: [zve_input_beispiel.csv](zve_input_beispiel.csv) 

4. Output

Zwei CSV-Dateien im selben Verzeichnis:

- `ESt.csv` | Tarifliche Einkommensteuer in Euro
- `Soli.csv` | Solidaritätszuschlag in Euro 

5. Ausführen

- `data_dir` im Skript auf das Verzeichnis setzen, in dem `zve_input.csv` liegt
- Skript in R ausführen

6. Voraussetzungen

Voraussetzung: R (≥ 3.0). Keine externen Pakete nötig.

7. Hinweise

Die Ergebnisse sollten in jedem Fall mit dem BMF-Steuerrechner
(https://www.bmf-steuerrechner.de/ekst/eingabeformekst.xhtml) validiert werden.

Der Rechner ersetzt selbstverständlich keine Steuer- oder Rechtsberatung.

Für Code, Beispiel und Ergebnisse wird keinerlei Haftung übernommen.
Die Dateien dienen ausschließlich Informations- und Bildungszwecken. Es wird
keine Gewähr für die Richtigkeit, Vollständigkeit oder Aktualität der Berechnungen
übernommen. Die Nutzung erfolgt auf eigene Verantwortung.

(Machine Translation / deepl.com <free version>)

1. Description

R script for calculating statutory income tax (Section 32a of the Income Tax Act) and
the Solidarity Surtax (Section 4 of the Solidarity Surtax Act) for the assessment periods (VZ)
2008 through 2020 as part of determining the minimum salary.

Please note: Starting with the 2021 assessment period, the Act on the Phasing Out of the
1995 Solidarity Surcharge of December 10, 2019 (BGBl I p. 2115) introduces
significantly increased exemption limits and a new mitigation zone. If the user
extends this script to reflect the new legal situation, this must be
taken into account.

2. Functions

`calc_est(year, zvE, joint)` | Tariff-based income tax pursuant to § 32a EStG |
`calc_soli(est, joint)` | Solidarity surcharge pursuant to § 4 SolZG |

`joint = TRUE` (default) | Splitting rate (joint assessment)
`joint = FALSE`  Basic rate (separate assessment)

The default is joint assessment because the Federal Constitutional Court (BVerfG) uses the
splitting rate in the context of minimum remuneration (see BVerfGE 155, 1 <66 ff.
para. 148 ff.>).

3. Input

The script expects a CSV file `zve_input.csv`:

- Semicolon-separated, decimal point
- First row (header): Years (`2008;2009;...;2020`)
- Subsequent lines: Taxable income (zvE, § 2 (5) sentence 1 clause 1 EStG) in euros per
  pay grade

Example: `zve_input.csv`

4. Output

Two CSV files in the same directory:

- `ESt.csv` | Schedule-based income tax in euros
- `Soli.csv` | Solidarity surcharge in euros 

5. Execution

- Set `data_dir` in the script to the directory where `zve_input.csv` is located
- Script
6. Prerequisites

Prerequisite: R (≥ 3.0). No external packages required.

7. Notes
   

The results should always be verified using the BMF tax calculator (https://www.bmf-steuerrechner.de/ekst/eingabeformekst.xhtml).

Of course, the calculator does not replace tax or legal advice.

No liability is assumed for the code, examples, or results. The files are provided solely for informational and educational purposes. No warranty is given regarding the accuracy, completeness, or timeliness of the calculations. Use is at your own risk.
