[org 0x0100]

jmp start

	;Variables for Title Screen
title: db 'Catch & Score'
titlelength: dw 13
startgame: db 'Hit Enter key to start!'
startgamelength: dw 23
instruction: dw 'Instructions:'
instructionlength: dw 13
instruct1: db '1. Use left & right arrow keys to move'
instruct1len: dw 38
instruct2: db '2. Catch objects to increase score'
instruct2len: dw 34
instruct3: db '3. Avoid bombs'
instruct3len: dw 14
instruct4: db '4. You have only 2 mins'
instruct4len: dw 23
attributecheck: dw 0

	;Variables for Game
scorestring: db 'Score: '
scorelength: dw 7 
timestring: db 'Time: '
timelength: dw 6
colon:	db':'
colonlength: dw 1
bucket: dw '|----------|'
bucketlength: dw 12
oldisr: dd 0
bucketlocationtrack: dw 30
oldtimerisr: dd 0
frequencycounter: dw 17
seconds: dw 0
minute: dw 2
minfrequencycounter: dw 1091
endscreencheck: dw 0
score: dw 0
bombcollision: dw 0
randomcounter: dw 3
	;Variables For BONUS
score5: dw 0
score10: dw 0
score15: dw 0


	;Variables for Endscreen
gameover: db 'G A M E   O V E R !'
gameoverlen: dw 19
scorestr: db 'Your Score is: '
scorelen: dw 15
bombstr: db 'You have encountered a bomb!'
bomblen: dw 28
timestr: db 'Times UP!'
timelen: dw 9
	;Variables For BONUS
picked: db 'You Picked:'
equal: db '='

;Clear Screen Subroutine
clrscr:
	push es
	push ax
	push di
	
	mov ax, 0xb800
	mov es, ax
	mov di, 0

next:
	mov word[es:di], 0x3020
	add di, 2
	cmp di, 4000
	jne next

	mov di ,3520
	mov cx, 80
bucketcolor:	;Changing a color of Bucket row
	mov word[es:di], 0x3120
	add di, 2
	loop bucketcolor


	pop di
	pop ax
	pop es
	ret


;Printing String Subroutine
print:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di

	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte[bp+10]
	add ax, [bp+12]
	shl ax, 1
	mov di, ax
	mov si, [bp+6]
	mov cx, [bp+4]
	mov ah, [bp+8]
	
	cmp word[attributecheck], 0
	je noattribute

nextchar:
	mov al, [si]
	mov [es:di], ax
	add di, 2
	add si, 1
	loop nextchar
	jmp endprint

noattribute:
	mov al, [si]
	mov [es:di], al
	add di, 2
	add si, 1
	loop noattribute	


endprint:
	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 10 

background:
	mov ax, 0xb800
	mov es, ax
	mov di, 670
	mov cx, 4
cloud1:
	mov word[es:di], 0x7720
	add di, 2
	loop cloud1
	
	mov di, 818
	mov cx, 14
cloud2:
	mov word[es:di], 0x7720
	add di, 2
	loop cloud2

	mov di, 976
	mov cx, 14
cloud3:
	mov word[es:di], 0x7720
	add di, 2
	loop cloud3

	mov di, 1142
	mov cx, 8
cloud4:
	mov word[es:di], 0x7720
	add di, 2
	loop cloud4
	
	mov di, 176
	mov cx, 8
sun0:
	mov word[es:di], 0x6020
	add di, 2
	loop sun0
	
	mov di, 670
	mov cx, 8
sun1:
	mov word[es:di], 0x6020
	sub di, 2
	loop sun1

	mov di, 512
	mov cx, 10
sun2:
	mov word[es:di], 0x6020
	sub di, 2
	loop sun2

	mov di, 352
	mov cx, 10
sun3:
	mov word[es:di], 0x6020
	sub di, 2
	loop sun3
	
	mov di, 750
	mov cx, 4
cloud5:
	mov word[es:di], 0x7720
	add di, 2
	loop cloud5
	
	mov di, 898
	mov cx, 14
cloud6:
	mov word[es:di], 0x7720
	add di, 2
	loop cloud6

	mov di, 1056
	mov cx, 14
cloud7:
	mov word[es:di], 0x7720
	add di, 2
	loop cloud7

	mov di, 1222
	mov cx, 8
cloud8:
	mov word[es:di], 0x7720
	add di, 2
	loop cloud8

	ret

catchscore:
	mov ax, 0xb800
	mov es, ax
	mov di, 490
	mov cx, 3	

c1:	mov word[es:di], 0x04DB
	add di, 160
	loop c1

	mov di, 492
	mov cx, 2
c2:
	mov word[es:di], 0x04DB
	add di, 2
	loop c2
	
	mov di, 970
	mov cx, 3
c3:
	mov word[es:di], 0x04DB
	add di, 2
	loop c3

	mov di, 500
	mov cx, 4

a1:
	mov word[es:di], 0x04DB
	add di, 2
	loop a1
	
	mov cx, 4
a2:
	mov word[es:di], 0x04DB
	add di, 160
	loop a2

	mov di, 500
	mov cx, 4
	
a3:
	mov word[es:di], 0x04DB
	add di, 160
	loop a3

	mov di, 820
	mov cx, 4
a4:
	mov word[es:di], 0x04DB
	add di, 2
	loop a4

	mov di, 514
	mov cx, 4
t1:
	mov word[es:di], 0x04DB
	add di, 2
	loop t1

	mov di, 518
	mov cx, 4
	
t2:
	mov word[es:di], 0x04DB
	add di, 160
	loop t2
	
	mov di, 526
	mov cx, 3

c4:	mov word[es:di], 0x04DB
	add di, 160
	loop c4

	mov di, 528
	mov cx, 2
c5:
	mov word[es:di], 0x04DB
	add di, 2
	loop c5
	
	mov di, 1006
	mov cx, 3
c6:
	mov word[es:di], 0x04DB
	add di, 2
	loop c6

	mov di, 536
	mov cx, 4
	
h1:
	
	mov word[es:di], 0x04DB
	add di, 160
	loop h1

	mov di, 858
	mov cx, 4

h2:
	mov word[es:di], 0x04DB
	add di, 2
	loop h2
	
	mov di, 544
	mov cx, 4

h3:
	mov word[es:di], 0x04DB
	add di, 160
	loop h3

	mov di, 564
	mov cx, 4

s1:
	mov word[es:di], 0x04DB
	sub di, 2
	loop s1
	
	mov cx, 2
s2:
	mov word[es:di], 0x04DB
	add di, 160
	loop s2

	mov cx, 4
s3:
	mov word[es:di], 0x04DB
	add di, 2
	loop s3

	mov cx, 2

s4:
	mov word[es:di], 0x04DB
	add di, 160
	loop s4

	mov cx, 5

s5:
	mov word[es:di], 0x04DB
	sub di, 2
	loop s5

	mov di, 570
	mov cx, 3

c7:	mov word[es:di], 0x04DB
	add di, 160
	loop c7

	mov di, 572
	mov cx, 2
c8:
	mov word[es:di], 0x04DB
	add di, 2
	loop c8
	
	mov di, 1050
	mov cx, 3
c9:
	mov word[es:di], 0x04DB
	add di, 2
	loop c9
		
	mov di, 580
	mov cx, 4

o1:
	mov word[es:di], 0x04DB
	add di, 2
	loop o1

	sub di, 2
	mov cx, 3
	
o2:
	mov word[es:di], 0x04DB
	add di, 160
	loop o2
	
	mov cx, 3

o3:
	mov word[es:di], 0x04DB
	sub di, 2
	loop o3
	
	mov cx, 4	

o4:
	mov word[es:di], 0x04DB
	sub di, 160
	loop o4

	mov di, 592
	mov cx , 3

r1:
	mov word[es:di], 0x04DB
	add di, 2
	loop r1

	mov cx, 2
r2:
	mov word[es:di], 0x04DB
	add di, 160
	loop r2

	mov cx, 3
r3:
	mov word[es:di], 0x04DB
	sub di, 2
	loop r3

	add di, 164
	mov word[es:di], 0x04DB
	add di, 162
	mov word[es:di], 0x04DB

	mov di, 590
	mov cx, 4
r4:
	mov word[es:di], 0x04DB
	add di, 160
	loop r4

	mov di, 604
	mov cx, 5
e1:
	mov word[es:di], 0x04DB
	add di, 2
	loop e1

	mov di, 604
	add cx, 4
e2:
	mov word[es:di], 0x04DB
	add di, 160
	loop e2

	mov cx, 5
e3:
	mov word[es:di], 0x04DB
	add di, 2
	loop e3

	mov di, 924
	mov cx, 4
e4:
	mov word[es:di], 0x04DB
	add di, 2
	loop e4

	ret

screenborder:	;BRICK BORDER
	mov ax, 0xb800
	mov es, ax
	mov di, 0
	mov cx, 80
top:
	mov word [es:di], 0x07B0
	add di, 2
	loop top
	mov word [es:di], 0x07B0
	
	mov di, 3840
	mov cx, 80
bottom:
	mov word [es:di], 0x07B0
	add di, 2
	loop bottom
	
	mov di, 318
	mov cx , 23
sides:
	mov word [es:di], 0x07B0
	add di, 2
	mov word [es:di], 0x07B0
	add di, 158
	loop sides
	mov di, 472
	mov word[es:di], 0x3020

	ret

;Number printing subroutine
printnum:
	push bp
	mov bp, sp
	push ax
	push es
	push di
	push bx
	push cx
	push dx

	mov ax, 0xb800
	mov es, ax
	
	mov al, 80
	mul byte[bp+8]
	add ax, [bp+10]
	shl ax, 1
	mov di, ax	;di pointing to required location
	
	mov ax, [bp+4]
	mov bx, 10
	mov cx, 0
	
nextdigit:
	mov dx, 0
	div bx
	add dl, 0x30
	push dx
	inc cx
	cmp ax, 0
	jnz nextdigit

	cmp cx, 1
	jg nextpos
	mov byte[es:di], 0x30
	add di, 2

nextpos:
	pop dx
	mov dh, 0x07
	mov [es:di], dl
	add di, 2
	loop nextpos

	pop dx
	pop cx
	pop bx
	pop di
	pop es
	pop ax
	pop bp

	ret 8

;GROUND Printing
ground:
	push ax
	push es
	push di
	
	mov ax, 0xb800
	mov es, ax
	mov di, 3682
	mov cx, 78

printground:
	mov word[es:di], 0x2020
	add di, 2
	loop printground

	pop di
	pop es
	pop ax
	
	ret

;PRINTING OBJECTS SUBROUTINE
printobj:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di

	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte[bp+6]
	add ax, [bp+8]
	shl ax, 1
	mov di, ax

	;printing obj score 
	mov ax, [bp+8]
	push ax
	mov ax, [bp+6]
	push ax
	mov ax, 0x07
	push ax
	mov ax, [bp+4]
	push ax
	call printnum

	; printing >
	add di, 4
	mov ax, 0x323E
	mov byte[es:di], al

	; printing <
	sub di, 6
	mov ax, 0x323C
	mov byte[es:di], al

	; printing upper border
	sub di, 158
	mov ax, 0x325F
	mov byte[es:di], al
	add di, 2
	mov byte[es:di], al
	
	; printing bottom border
	add di, 318
	mov ax, 0x32DF
	mov byte[es:di], al
	add di, 2
	mov byte[es:di], al

	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 6

;PRINTING BOMBS SUBROUTINE
printbomb:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di

	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte[bp+4]
	add ax, [bp+6]
	shl ax, 1
	mov di, ax

	; printing bomb
	mov ax, 0x30E8
	mov byte[es:di], al

	add di, 2
	mov ax, 0x303E
	mov byte[es:di], al

	sub di, 4
	mov ax, 0x303C
	mov byte[es:di], al

	sub di, 158
	mov ax, 0x30C2
	mov byte[es:di], al

	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp

	ret 4

delay:
	push ax
	push cx
	
	mov ax, 1000

outerloop:
	mov cx, 500

innerloop:
	loop innerloop
	dec ax
	jnz outerloop

	pop cx
	pop ax
	ret

;Hooking Left right key interrupt
Movementisr:
	push ax
	push es
	push di
	
	mov ax, 0xb800
	mov es, ax
	
	in al, 0x60		;Getting input from keyboard
	cmp al, 0x4B	;Left arrow key Hex value
	jne nextcmp

	cmp  word[bucketlocationtrack], 1	;Checking to avoid going outside line
	je movleft	;Location is not changed
	sub word[bucketlocationtrack], 1	;To move left 1 location

movleft:	;Moving Bucket to left
	mov ax, [bucketlocationtrack]	; x position
	push ax
	mov ax, 22	; y position
	push ax
	mov ax, 0x35	; attribite(Color)
	push ax
	mov ax, bucket	; bucket String
	push ax
	mov ax, [bucketlength]	; String Length
	push ax
	call print	; calling subroutine print

	;CLEARING old Bucket character
	mov ax, 0xb800
	mov es, ax
	mov di, [bucketlocationtrack]
	shl di, 1
	add di, 24		;Length of bucket
	add di, 3520	;y-axis position of bucket
	mov byte[es:di], 0x20

	jmp endisr

nextcmp:
	cmp al, 0x4D
	jne endisr

	cmp word[bucketlocationtrack], 67	;Checking to avoid going outside line
	je movright	;Without changing location
	add word[bucketlocationtrack], 1	;changing location

movright:	;Moving Bucket to right
	mov ax, [bucketlocationtrack]	; x position
	push ax
	mov ax, 22	; y position
	push ax
	mov ax, 0x31	; attribite(Color)
	push ax
	mov ax, bucket	; bucket String
	push ax
	mov ax, [bucketlength]	; String Length
	push ax
	call print	; calling subroutine print

	;CLEARING old Bucket character
	mov ax, 0xb800
	mov es, ax
	mov di, [bucketlocationtrack]
	shl di, 1
	sub di, 2		;Old character location
	add di, 3520	;y-axis position of bucket
	mov byte[es:di], 0x20

endisr:
	pop di
	pop es
	pop ax
	jmp far[cs:oldisr]	;calling original ISR
	
;HOOKING TIMER Interrupt
timerisr:
	push ax

	cmp word[minute], -1	;Termination condition
	je endtimerisr

		;For seconds
	inc word[frequencycounter]
	cmp word[frequencycounter], 18	;18 cycles per second
	jne updatemin
	mov word[frequencycounter], 0
	dec word[seconds]
	cmp word[seconds], -1
	jne updatesecs
	mov word[seconds], 59

updatesecs:		;UPDATING secs
		
	mov ax, 74	; x position
	push ax
	mov ax, 2	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, [seconds]	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

updatemin:	;For Mins
	inc word[minfrequencycounter]
	cmp word[minfrequencycounter], 1092	;1092 cycles per minute
	jne endtimerisr
	mov word[minfrequencycounter], 0
	dec word[minute]
	cmp word[minute], -1
	jne mins
	mov word[endscreencheck], 1	;End screen check if Time is ended

mins:	;Updating mins
	mov ax, 71	; x position
	push ax
	mov ax, 2	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, [minute]	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

endtimerisr:
	pop ax
	jmp far[cs:oldtimerisr]	; Calling original ISR
	

	;GENERATING RANDOM NUMBERS
Randomobjects:		;For Generating objects
	push ax
	push cx

	mov ax, [randomcounter]
	mov cx, 4	;to generate 0-3
	mov dx, 0
	div cx

	pop cx
	pop ax
	ret				;dx will still have same value

Randomlocations:		;For Generating objects
	push ax
	push cx

	mov ah, 00h		;Service for system time
	int 1Ah
	; Now Cx, Dx have Number of clock ticks
	mov ax, dx
	mov cx, 74
	mov dx, 0
	div cx			;Generated number between 0-73 in dx
	
	add dx, 3		;adding to exclude bricks at beginning

	pop cx
	pop ax
	ret				;dx will still have same value

Randomgenerator:		;For Generating objects randomly
	push ax
	push cx

	mov ah, 00h		;Service for system time
	int 1Ah
					; Now Cx, Dx have Number of clock ticks
	mov ax, dx
	mov cx, 10
	mov dx, 0
	div cx			;Generated number between 0-9 in dx

	pop cx
	pop ax
	ret				;dx will still have same value

moveobjsdown:
	push ax
	push bx
	push cx
	push si
	push di
	push es
	push ds

	mov si, 3358	;Calculated Source position
	mov di, si
	add di, 160		; destination is next line of source

	mov ax, 0xb800
	mov es, ax
	mov ds, ax
	mov cx, 1440	;Calculated times of moving characters
	std

loop1:
	movsb	;using byte mov to dont move background with objects
	dec di
	dec si
	loop loop1

	mov di, 482		;pointing to top for clearing the lines
	mov al, 0x20
	mov cx, 78
	cld
loop2:	;clearing 1st line
	stosb
	inc di
	loop loop2

	mov di, 642
	mov al, 0x20
	mov cx, 78
	cld
loop3:	;clearing 2nd line
	stosb
	inc di
	loop loop3

	pop ds
	pop es
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	ret

ScoreUpdate:	;SCORE UPDATING
	push es
	push di
	push ax
	push cx

	mov ax, 0xb800
	mov es, ax

	mov di, 3520	;Bucket row
	mov ax, [bucketlocationtrack] ;Bucket col
	shl ax, 1
	add di, ax
	sub di, 160	;Moving 1 line up
	mov cx, 12	;Length of bucket

	;CHECKS FOR COLLISION OF OBJECTS
check:
	cmp byte[es:di], 0x31 ; 1 ascii
	je addscore10
chk2:
	cmp byte[es:di], 0x35
	je addscore15
chk3:
	cmp byte[es:di], 0xE8
	je bombfound

	add di, 2
	loop check
	jmp terminate

	;ADDING SCORES
addscore10:
	add di, 2
	cmp byte[es:di], 0x30 ; 0 ascii
	jne chk2
	add word[score], 10
	inc word[score10]	;BONUS
	jmp terminate

addscore15:
	sub di, 2
	cmp byte[es:di], 0x31 ; 1 ascii
	jne addscore5
	add word[score], 15
	inc word[score15]	;BONUS
	jmp terminate

addscore5:
	add word[score], 5
	inc word[score5]	;BONUS
	jmp terminate

bombfound:	;BOMB COLLISION CHECK UPDATING
	mov word[bombcollision], 1

terminate:

	pop cx
	pop ax
	pop di
	pop es
	ret

start:
	call clrscr	;Clearing Screen
	call background
	call catchscore
	call screenborder

	;Printing start line
	mov word[attributecheck], 1	;Updating with attribute
	mov ax, 25	; x position
	push ax
	mov ax, 10	; y position
	push ax
	mov ax, 0xB4	; attribite(Color)
	push ax
	mov ax, startgame	; start String
	push ax
	mov ax, [startgamelength]	; start Length
	push ax
	call print	; calling subroutine print

	
	;Printing instuctions 
	mov ax, 2	; x position
	push ax
	mov ax, 13	; y position
	push ax
	mov ax, 0x70	; attribite(Color)
	push ax
	mov ax, instruction	; instruction String
	push ax
	mov ax, [instructionlength]	; instruction Length
	push ax
	call print	; calling subroutine print

	mov word[attributecheck], 0
	mov ax, 5	; x position
	push ax
	mov ax, 15	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, instruct1	; instruction String
	push ax
	mov ax, [instruct1len]	; instruction Length
	push ax
	call print	; calling subroutine print

	
	mov ax, 5	; x position
	push ax
	mov ax, 16	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, instruct2	; instruction String
	push ax
	mov ax, [instruct2len]	; instruction Length
	push ax
	call print	; calling subroutine print

	mov ax, 5	; x position
	push ax
	mov ax, 17	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, instruct3	; instruction String
	push ax
	mov ax, [instruct3len]	; instruction Length
	push ax
	call print	; calling subroutine print

	mov ax, 5	; x position
	push ax
	mov ax, 18	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, instruct4	; instruction String
	push ax
	mov ax, [instruct4len]	; instruction Length
	push ax
	call print	; calling subroutine print

	mov word[attributecheck], 1

			;FOR 5 score
	mov ax, 10	; x position
	push ax
	mov ax, 21	; y position
	push ax
	mov ax, 5	; Score
	push ax
	call printobj

	mov ax, 14	; x position
	push ax
	mov ax, 21	; y position
	push ax
	mov ax, 0x34	; attribite(Color)
	push ax
	mov ax, equal	; String
	push ax
	mov ax, 1	; Length
	push ax
	call print	; calling subroutine print

	mov ax, 16	; x position
	push ax
	mov ax, 21	; y position
	push ax
	mov ax, 34	; attribite(Color)
	push ax
	mov ax, 5	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

		;For 10 Score
	mov ax, 35	; x position
	push ax
	mov ax, 21	; y position
	push ax
	mov ax, 10	; Score
	push ax
	call printobj

	mov ax, 39	; x position
	push ax
	mov ax, 21	; y position
	push ax
	mov ax, 0x34	; attribute(Color)
	push ax
	mov ax, equal	; String
	push ax
	mov ax, 1	; Length
	push ax
	call print	; calling subroutine print

	mov ax, 41	; x position
	push ax
	mov ax, 21	; y position
	push ax
	mov ax, 34	; attribite(Color)
	push ax
	mov ax, 10	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

			;For 15 Score
	mov ax, 62	; x position
	push ax
	mov ax, 21	; y position
	push ax
	mov ax, 15	; Score
	push ax
	call printobj

	mov ax, 66	; x position
	push ax
	mov ax, 21	; y position
	push ax
	mov ax, 0x34	; attribite(Color)
	push ax
	mov ax, equal	; String
	push ax
	mov ax, 1	; Length
	push ax
	call print	; calling subroutine print

	mov ax, 68	; x position
	push ax
	mov ax, 21	; y position
	push ax
	mov ax, 34	; attribite(Color)
	push ax
	mov ax, 15	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

	mov word[attributecheck], 0

	;Loop till enter key is pressed
waitforEnter:
	mov ah, 0	;getting keystroke
	int 0x16	;BIOS keyboard service

	cmp al, 0x0D	;Enter key value in hex
	jne waitforEnter


;**********GAME SCREEN***********

	call clrscr
	call background
	call screenborder
	call ground

	;Printing Score string
	mov ax, 5	; x position
	push ax
	mov ax, 2	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, scorestring	; Score String
	push ax
	mov ax, [scorelength]	; String Length
	push ax
	call print	; calling subroutine print

	;Printing time string
	mov ax, 65	; x position
	push ax
	mov ax, 2	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, timestring	; Score String
	push ax
	mov ax, [timelength]	; String Length
	push ax
	call print	; calling subroutine print

	;Printing Colon for time
	mov ax, 73	; x position
	push ax
	mov ax, 2	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, colon	; Score String
	push ax
	mov ax, [colonlength]	; String Length
	push ax
	call print	; calling subroutine print

	;Printing Bucket
	mov ax, 30	; x position
	push ax
	mov ax, 22	; y position
	push ax
	mov ax, 0x35	; attribite(Color)
	push ax
	mov ax, bucket	; bucket String
	push ax
	mov ax, [bucketlength]	; String Length
	push ax
	call print	; calling subroutine print

	;Movement of BUCKET
		;saving old IREQ-01 ISR
	mov ax, 0
	mov es, ax
	mov ax, [es:9*4]
	mov [oldisr], ax
	mov ax, [es:9*4+2]
	mov [oldisr+2], ax

		;Saving timer(IREQ-0) old ISR
	mov ax, 0
	mov es, ax
	mov ax, [es:8*4]
	mov [oldtimerisr], ax
	mov ax, [es:8*4+2]
	mov [oldtimerisr+2], ax

		;Hooking Timer Interrupt
	cli
	mov word [es:8*4], timerisr
	mov word [es:8*4+2], cs

		;Hooking Keyboard Interrupt
	mov word[es:9*4], Movementisr
	mov [es:9*4+2], cs
	sti

l1:		;Loop of running program
	;printing Random Objects
	inc word[randomcounter]	;Random counter to increase seed after every loop

	call moveobjsdown
	call screenborder

	;IF COLLIDE
	call ScoreUpdate
	
	;Updating Score
	mov ax, 12	; x position
	push ax
	mov ax, 2	; y position
	push ax
	mov ax, 0x07	; attribite(Color)
	push ax
	mov ax, [score]	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

	call Randomgenerator	;Generator to Sometimes generate objs & sometime doesnt
	cmp dx, 1
	jne Nogeneration

	call Randomlocations
	mov cx, dx				;storing random location in cx

	call Randomobjects		;Random obj generator

	cmp dx, 0
	je print5scoreobj
	cmp dx, 1
	je print10scoreobj
	cmp dx, 2
	je print15scoreobj
	cmp dx, 3
	je printingbomb
	jmp Nogeneration

call background

print5scoreobj:	;Printing 5 score object
	mov ax, cx	; x position
	push ax
	mov ax, 5	; y position
	push ax
	mov ax, 5	; Score
	push ax
	call printobj
	jmp Nogeneration

print10scoreobj:	;Printing 10 score object
	mov ax, cx	; x position
	push ax
	mov ax, 5	; y position
	push ax
	mov ax, 10	; Score
	push ax
	call printobj
	jmp Nogeneration

print15scoreobj:	;Printing 15 score object
	mov ax, cx	; x position
	push ax
	mov ax, 5	; y position
	push ax
	mov ax, 15	; Score
	push ax
	call printobj
	jmp Nogeneration

printingbomb:	;Printing Bomb
	mov ax, cx	; x position
	push ax
	mov ax, 5	; y position
	push ax
	call printbomb

Nogeneration:	;In case of Nogeneration
	cmp word[bombcollision], 1	;CHECKING BOMB COLLISIONS
	je EndScreen
	cmp word[seconds], 0		;COMPARING TIME if secs 0 then checking Minute if 0 then display endscreen
	je checktime
continue:
	call delay	;to slow down movement of falling objs
	jmp l1
checktime:
	cmp word[minute], 0			;Comparing minute
	jne continue

EndScreen:
		;Giving back controls to original ISRs
	mov ax, [oldisr]
	mov bx, [oldisr+2]
	cli
	mov [es:9*4], ax
	mov [es:9*4+2], bx
	sti
	mov ax, [oldtimerisr]
	mov bx, [oldtimerisr+2]
	cli
	mov [es:8*4], ax
	mov [es:8*4+2], bx
	sti

	call clrscr
	call background
	call screenborder
	call ground

		;Printing GAME OVER
	mov word[attributecheck], 1
	mov ax, 26	; x position
	push ax
	mov ax, 5	; y position
	push ax
	mov ax, 0x34	; attribite(Color)
	push ax
	mov ax, gameover	; String
	push ax
	mov ax, [gameoverlen]	; Length
	push ax
	call print	; calling subroutine print

		;Printing Score
	mov ax, 27	; x position
	push ax
	mov ax, 12	; y position
	push ax
	mov ax, 0x3A	; attribite(Color)
	push ax
	mov ax, scorestr	; String
	push ax
	mov ax, [scorelen]	; Length
	push ax
	call print	; calling subroutine print

	mov ax, 42	; x position
	push ax
	mov ax, 12	; y position
	push ax
	mov ax, 0x30	; attribite(Color)
	push ax
	mov ax, [score]	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

	cmp word[bombcollision], 1
	je endduetobomb

				;Printing Message of Game Over due to Time Over
	mov ax, 30	; x position
	push ax
	mov ax, 9	; y position
	push ax
	mov ax, 0x34	; attribite(Color)
	push ax
	mov ax, timestr	; String
	push ax
	mov ax, [timelen]	; Length
	push ax
	call print	; calling subroutine print
	call bonus

endduetobomb:
			;Printing Message of Game Over due to bomb collision
	mov ax, 23	; x position
	push ax
	mov ax, 9	; y position
	push ax
	mov ax, 0x34	; attribite(Color)
	push ax
	mov ax, bombstr	; String
	push ax
	mov ax, [bomblen]	; Length
	push ax
	call print	; calling subroutine print
bonus:		;BONUS
	mov ax, 30	; x position
	push ax
	mov ax, 16	; y position
	push ax
	mov ax, 0x31	; attribite(Color)
	push ax
	mov ax, picked	; String
	push ax
	mov ax, 11	; Length
	push ax
	call print	; calling subroutine print

		;FOR 5 score
	mov ax, 10	; x position
	push ax
	mov ax, 19	; y position
	push ax
	mov ax, 5	; Score
	push ax
	call printobj

	mov ax, 14	; x position
	push ax
	mov ax, 19	; y position
	push ax
	mov ax, 0x34	; attribite(Color)
	push ax
	mov ax, equal	; String
	push ax
	mov ax, 1	; Length
	push ax
	call print	; calling subroutine print

	mov ax, 16	; x position
	push ax
	mov ax, 19	; y position
	push ax
	mov ax, 34	; attribite(Color)
	push ax
	mov ax, [score5]	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

		;For 10 Score
	mov ax, 35	; x position
	push ax
	mov ax, 19	; y position
	push ax
	mov ax, 10	; Score
	push ax
	call printobj

	mov ax, 39	; x position
	push ax
	mov ax, 19	; y position
	push ax
	mov ax, 0x34	; attribite(Color)
	push ax
	mov ax, equal	; String
	push ax
	mov ax, 1	; Length
	push ax
	call print	; calling subroutine print

	mov ax, 41	; x position
	push ax
	mov ax, 19	; y position
	push ax
	mov ax, 34	; attribite(Color)
	push ax
	mov ax, [score10]	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

			;For 15 Score
	mov ax, 62	; x position
	push ax
	mov ax, 19	; y position
	push ax
	mov ax, 15	; Score
	push ax
	call printobj

	mov ax, 66	; x position
	push ax
	mov ax, 19	; y position
	push ax
	mov ax, 0x34	; attribite(Color)
	push ax
	mov ax, equal	; String
	push ax
	mov ax, 1	; Length
	push ax
	call print	; calling subroutine print

	mov ax, 68	; x position
	push ax
	mov ax, 19	; y position
	push ax
	mov ax, 34	; attribite(Color)
	push ax
	mov ax, [score15]	; Number to be printed
	push ax
	call printnum	; calling subroutine printnum

l2:
	mov ah, 0
	int 0x16

	cmp al, 27	;Esc key
	jne l2


mov ax, 0x4c00
int 21h