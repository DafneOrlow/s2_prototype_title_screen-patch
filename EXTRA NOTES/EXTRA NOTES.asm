++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;ADDITIONAL NOTES (Dafne Orlow)

; [1] - SECTION	"TitlePrototypeArt",ROM0
============================================================================================================================================
; Then, add or modify the following small ASM snippet in your disassembly (suggested: create a file Data/TitlePrototypePatch.asm and include it where other data is included).
; This snippet tells the build which art/mapping/palette to use for the title screen.
============================================================================================================================================
; HOW is this a clear, easy to follow instruction? When copying lines 18-33 of this file, particularly "SECTION "TitlePrototypeArt",ROM0"
; AS IT IS SHOWN, to the top of the suggested "Data/TitlePrototypePatch.asm" file
; it produces an error when building the ROM. 

; The error:
; TitlePrototypePatch.asm(1):9: error #1200: unknown instruction
; "TITLEPROTOTYPEART",ROM0
; SECTION "TitlePrototypeArt",ROM0
;         ~~~~~~~~~~~~~~~~~~~~~~~~

; TO FIX the error it needs a "; " before SECTION. Somthing the original uploader fails to mention above.
=================================================================================================================================

;
;
;


; [2] - Missing data files?

; Once you 'fix' the error (above) and include the new file in the main S2.asm file (I placed it just above "; Filler (free space)" towards the very bottom)

; ----------------------------------------------------------------------------------
; TitlePrototypeArt													; NEW

	include	"TitlePrototypePatch.asm"								; NEW
; ----------------------------------------------------------------------------------
; Filler (free space)
; ----------------------------------------------------------------------------------

	
; Make changes to lines in the s2.asm file

	; Load assets while the above text is being displayed.
	move.l	#vdpComm(tiles_to_bytes(ArtTile_ArtNem_Title),VRAM,WRITE),(VDP_control_port).l
	lea	(ArtNem_Title).l,a0
	bsr.w	NemDec
; BECOMES 
	; Load assets while the above text is being displayed.
	move.l	#vdpComm(tiles_to_bytes(ArtTile_ArtNem_Title),VRAM,WRITE),(VDP_control_port).l
	lea	(Art_TitleProto).l,a0
	bsr.w	NemDec 
	
; AND

	; Decompress the second part of the title screen background plane map...
	lea	(Chunk_Table).l,a1
	lea	(MapEng_TitleBack).l,a0
	move.w	#make_art_tile(ArtTile_ArtNem_Title,2,0),d0
	bsr.w	EniDec
; BECOMES
	; Decompress the first part of the title screen background plane map...
	lea	(Chunk_Table).l,a1
	lea	(Map_TitleProto).l,a0
	move.w	#make_art_tile(ArtTile_ArtNem_Title,2,0),d0
	bsr.w	EniDec

; it should produce somthing similar to what you see in the attached screenshots.

Last updated - 4(d)/2(m)/2026(y)