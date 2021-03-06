#version 1
#brief Small Outline w/ Pins, Exposed pad
#note Suitable for SOIC and SSOP parts. With exposed pad.
#pins 9 11 ...
#flags aux-pad(flag,*) rebuild
#param 9 @?PT  1.27 @PP  5.6 @SH  1.75 @PW  0.65 @PL  2.2 @PWA  3.0 @PLA  0.65 @TS  15 @TW \
#      3.6 @BW  PT 1 - 2 / floor 1 - PP * 1.2 + @BL  0.2 @BP  0.2 @STP 25 @PSRA  1.5 @EPDOT
#model SOP
$MODULE {NAME}
AR SOPX
Po 0 0 0 15 00000000 00000000 ~~
Li {NAME}
Cd {DESCR}
Kw {TAGS}
Op 0 0 0
At SMD
#determine text size and visibility from the text parameter(s)
{TS @?TSR   TS ~ @?TSV   "V" "H" TSR 0 >= ? @TRvis   "V" "H" TSV 0 >= ? @TVvis}
{TSR abs @TSR   TSV abs @TSV   TW 100 / TSR * @TRpen   TW 100 / TSV * @TVpen}
#body size is bound to a maximum, because the drawing must not run over the pads
{SH PW - STP 2 * - BW min @BW}
#calculate the position of the (tiny) polarity marker
{BW 6 / 0.1 - 0.3 min @RAD   0.25 @OFFS   RAD BW 2 / - OFFS + @XC   RAD BL 2 / - OFFS + @YC}
#draw labels and body
T0 0 {BL 2 / TSR + ~} {TSR} {TSR} 0 {TRpen} N {TRvis} 21 N "REF**"
T1 0 {BL 2 / TSV +} {TSV} {TSV} 0 {TVpen} N {TVvis} 21 N "VAL**"
T2 {BW 2 / ~ BP 2 * -} {PT 1 - -0.25 * 0.5 + PP * PL - BP -} {BP 2 *} {BP 2 *} 0 {BP 2 /} N V 21 N "○"
DS {BW 2 / ~} {BL 2 / ~} {BW 2 /} {BL 2 / ~} {BP} 21
DS {BW 2 /} {BL 2 / ~} {BW 2 /} {BL 2 /} {BP} 21
DS {BW 2 /} {BL 2 /} {BW 2 / ~} {BL 2 /} {BP} 21
DS {BW 2 / ~} {BL 2 /} {BW 2 / ~} {BL 2 / ~} {BP} 21
DC {XC} {YC} {XC RAD +} {YC} {BP} 21
{PT 1 - @PINS}
$PAD
{?:STDPAD PN PINS <=} #standard pad
Sh "{PN}" O {PW} {PL} 0 0 0
Dr 0 0 0
At SMD N 00888000
Ne 0 ""
{? PN PINS 2 / <=}Po {SH 2 / ~} {PINS -0.25 * 0.5 - PN + PP *}
{? PN PINS 2 / > PN PINS <= &}Po {SH 2 /} {PINS 0.75 * 0.5 + PN - PP *}
:STDPAD
{?:THERMAL PN PINS >} #exposed pad
{PWA EPDOT / floor 1 max @EPCOLS   PLA EPDOT / floor 1 max @EPROWS   PWA EPCOLS / @EPW   PLA EPROWS / @EPL}# slice size & col/row counts
{EPCOLS EPROWS * 1 - @PTA   PN PT - @EPN}#adjust total extra pads, calc slice index (zero-based)
{0.01 0 EPCOLS 1 > ? @EPDX   0.01 0 EPROWS 1 > ? @EPDY}# make slices overlap by making them 0.02 larger
Sh "{PT}" R {EPW EPDX 2 * +} {EPL EPDY 2 * +} 0 0 0
.SolderPasteRatio {PSRA -200 /}
Dr 0 0 0
At SMD N 00888000
Ne 0 ""
{EPN EPCOLS divmod @ROW @COL   EPCOLS 1 - -0.5 * COL + EPW * @EPX   EPROWS 1 - -0.5 * ROW + EPL * @EPY}
{? COL 0 =}{EPX EPDX + @EPX}
{? COL 1 + EPCOLS =}{EPX EPDX - @EPX}
{? ROW 0 =}{EPY EPDY + @EPY}
{? ROW 1 + EPROWS =}{EPY EPDY - @EPY}
Po {EPX} {EPY}
:THERMAL
$EndPAD
$SHAPE3D
Na "{NAME}.wrl"
Sc 0.3937 0.3937 0.3937
Of 0 0 0
Ro 0 0 0
$EndSHAPE3D
$EndMODULE {NAME}
