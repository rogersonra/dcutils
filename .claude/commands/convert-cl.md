Convert the CL program at `$ARGUMENTS` to modern ILE CL (CLLE), then commit and push.

## Steps

1. **Read** the source file at `$ARGUMENTS`.

2. **Derive the output path** by replacing the extension with `.CLLE` (e.g. `QCLSRC/DC080CL.CLP` → `QCLSRC/DC080CL.CLLE`).

3. **Write** the modernised CLLE file applying all rules below.

4. **Commit** the new file with a descriptive message summarising the key changes.

5. **Push** to origin.

---

## Conversion rules

### Structure
- Remove the program label (e.g. `DC080CL:`) that precedes `PGM`
- Replace `PGM` / `ENDPGM` with `Pgm` / `endpgm`
- If no `PGM` statement exists, add one
- Add `DclPrcOpt dftactgrp(*no) actgrp('DCAG')` immediately after `Pgm`
- Lowercase all CL commands and keywords

### Header block
Place this at the top of the file, filled in from the source:
```
/* Programmer.:  Robert Rogerson                                              */
/* Program....:  <program name>                                               */
/* Title......:  <title from PGM comment or purpose>                         */
/* Date.......:  2026                                                         */
/*                                                                            */
/* Description:                                                               */
/*                                                                            */
/*    <one or two sentences describing what the program does>                 */
/*                                                                            */
```

### GOTO
- Replace `GOTO` with structured `IF/ELSE/ENDDO` where possible
- **Exception:** retain `GOTO label` for `RCVF` read loops — this is idiomatic ILE CL
- If a `GOTO` bypasses a block of dead code, remove the dead block entirely and add a one-line comment explaining what was removed and why

### OPNQRYF / OVRDBF
- Retain as-is — do not convert to SQL
- For each `OPNQRYF`, add a comment immediately above it noting the SQL equivalent (e.g. `/* WARNING: OPNQRYF — SQL equivalent is SELECT ... */`)

### Dead code
- Omit commented-out `CALL` statements that have never been re-enabled
- If removing anything non-trivial, add a brief inline note

### Everything else
- Preserve all active business logic exactly — field names, file names, parameter lists, library qualifiers, `MONMSG` handlers
- Do NOT add error handling that wasn't in the original
