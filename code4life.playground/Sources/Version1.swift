import Foundation

/*
 1. Molecules
 L: Von jedem zwei Molecules?
 Nein -> Sind benötige Molecules vorhanden?
 Nein -> Beginne Sample Loop
 Ja -> Nehme vorhanden Molecule -> Loop
 Ja -> Kann ein vorhandes Sample Entwickelt werden?
 Nein -> Beginne Sample Loop
 Ja -> Zum Labor
 */

/*
 2. Sample Loop
 L: Sind drei Samples in der Hand?
 Nein -> Gibt es Samples in der Cloud, welche ich entwickeln kann?
 Ja -> Nehm das Sample und Gehe ins Labor
 Nein -> Hole fehlende Samples mit RANK 1 -> Loop
 Ja -> Diagnose Logic
 */

/*
 3. Entwickle Sample
 L: Gibt es unentwickelte Samples?
 Ja -> Entwickle diese -> Loop
 Nein -> Prüfung ob ins Labor
 */

/*
 4. Prüfung ob ins Labor
 L: Kann Sample Entwickelt werden?
 Nein -> Schicke es in die Cloud -> Loop
 Ja -> Zum Labor
 */

/*
 5. Zum Labor
 Kann ein Sample Entwickelt werden?
 Ja -> Entickle Sample -> Loop
 Nein -> Sammle Molecules
 */
