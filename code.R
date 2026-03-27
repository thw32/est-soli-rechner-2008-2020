# Einkommensteuer & Solidaritaetszuschlag 2008 bis 2020 zum Zwecke der Berechnung der Mindestbesoldung
# Rechtliche Grundlagen: § 32a EStG und § 4 SolZG in den jeweils anwendbaren Fassungen
# Bei einer Erweiterung auf Zeiträume nach 2020 sind insbesondere die Änderungen des Gesetzes 
# zur Rückführung des Solidaritätszuschlags 1995 vom 10. Dezember 2019 (BGBl I S. 2115) zu beachten

# Tarifparameter § 32a EStG geordnet nach Veranlagungsjahr
# gf=Grundfreibetrag, z2/z3/z4=Progressionszonengrenzen,
# a2/b2=Koeffizienten Progressionszone2, a3/b3/c3=Progressionszone3, k4/k5=Abzuege Progressionszone4/5

est_params <- data.frame(
    year = 2008:2020,
    gf   = c(7664, 7834, 8004, 8004, 8004, 8130, 8354, 8472, 8652, 8820, 9000, 9168, 9408),
    z2   = c(12739, 13139, 13469, 13469, 13469, 13469, 13469, 13469, 13669, 13769, 13996, 14254, 14532),
    z3   = c(52151, 52551, 52881, 52881, 52881, 52881, 52881, 52881, 53665, 54057, 54949, 55960, 57051),
    z4   = c(250000, 250400, 250730, 250730, 250730, 250730, 250730, 250730, 254446, 256303, 260532, 265326, 270500),
    a2   = c(883.74, 939.68, 912.17, 912.17, 912.17, 933.70, 974.58, 997.60, 993.62, 1007.27, 997.80, 980.14, 972.87),
    b2   = c(1500, 1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400),
    a3   = c(228.74, 228.74, 228.74, 228.74, 228.74, 228.74, 228.74, 228.74, 225.40, 223.76, 220.13, 216.16, 212.02),
    b3   = c(2397, 2397, 2397, 2397, 2397, 2397, 2397, 2397, 2397, 2397, 2397, 2397, 2397),
    c3   = c(989, 1007, 1038, 1038, 1038, 1014, 971, 948.68, 952.48, 939.57, 948.49, 965.58, 972.79),
    k4   = c(7914, 8064, 8172, 8172, 8172, 8196, 8239, 8261.29, 8394.14, 8475.44, 8621.75, 8780.90, 8963.74),
    k5   = c(15414, 15576, 15694, 15694, 15694, 15718, 15761, 15783.19, 16027.52, 16164.53, 16437.70, 16740.68, 17078.74)
  )

# Einkommensteuer-Grundtarif (5 Progressionszonen)

calc_est_single <- function(zvE, p) {
  zvE <- floor(zvE)  # § 32a Abs. 1 S. 2 EStG: auf vollen Euro abrunden
  if (zvE < 1) return(0)
  if (zvE <= p$gf) return(0)
  if (zvE <= p$z2) { y <- (zvE - p$gf) / 1e4; return(floor((p$a2 * y + p$b2) * y)) }
  if (zvE <= p$z3) { z <- (zvE - p$z2) / 1e4; return(floor((p$a3 * z + p$b3) * z + p$c3)) }
  if (zvE <= p$z4) return(floor(0.42 * zvE - p$k4))
  floor(0.45 * zvE - p$k5)
}


# Ehegattensplitting: zvE halbieren, Einkommensteuer verdoppeln
# Abwahl gemeinsamer Veranlagung durch joint=FALSE

calc_est <- function(year, zvE, joint = TRUE) {
  p <- est_params[est_params$year == year, ]
  if (nrow(p) == 0) stop(paste("Kein Tarif fuer", year))
  if (joint) return(2 * calc_est_single(zvE / 2, p))
  calc_est_single(zvE, p)
}

# Solidaritaetszuschlag (§ 4 SolZG in den bis zum 13. Dezember 2019 anwendbaren Fassungen)
# Freigrenze + Milderungszone (Kappung auf 20% der Differenz zur Freigrenze)
# Abwahl gemeinsamer Veranlagung durch joint=FALSE

calc_soli <- function(est, joint = TRUE) {
  fg <- if (joint) 1944 else 972
  if (est <= fg) return(0)
  floor(min(est * 0.055, 0.20 * (est - fg)) * 100) / 100
}

# INput-CSV einlesen, berechnen, Output-CSVs ausgeben
# Abwahl gemeinsamer Veranlagung durch joint=FALSE

data_dir <- "." # Verzeichnis der Input-CSV und Schreibverzeichnis für Output-CSV notieren
df <- read.csv2(file.path(data_dir, "zve_input.csv"), check.names = FALSE)
years <- as.integer(colnames(df))

df_est  <- df
df_soli <- df

for (i in seq_len(nrow(df))) {
  for (j in seq_along(years)) {
    zve_ij <- df[i, j]
    if (!is.na(zve_ij) && zve_ij > 0) {
      est_ij <- calc_est(years[j], zve_ij, joint = TRUE)
      df_est[i, j]  <- est_ij
      df_soli[i, j] <- calc_soli(est_ij, joint = TRUE)
    }
  }
}

write.csv2(df_est,  file.path(data_dir, "ESt.csv"),  row.names = FALSE)
write.csv2(df_soli, file.path(data_dir, "Soli.csv"), row.names = FALSE)