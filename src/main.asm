//Adc setup 
.set avcc = 1<<refs0
.set adc_enable = 1<<aden
.set adc_interrupt = 1<<adie
.set prescale_128 = (1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0)

//Timer 0 setup
.set ctc_mode = 1<<wgm02
.set prescale_1024 = (1<<CS02)|(1<<CS00)
.set t0_init_compab = (1<<OCIE0A)|(1<<OCIE0B)
.set sleep_enable = 1<<se

.def adc_value = r18
.def tempurature = r19
.def tens = r20
.def units = r21
.def t_seconds = r25

.cseg
.org 0x00
jmp reset
.org 0x1c
jmp timerA
.org 0x1e
jmp timerB
.org 0x2a
jmp adc_in
.org 0x34

reset:
	;Initializing stack pointer to ramend
	ldi r16, low(ramend)
	out spl, r16
	ldi r16, high(ramend)
	out sph, r16
	
	;ADC initialize
	ldi r16, avcc
	sts admux, r16 
	ldi r16, adc_enable|adc_interrupt|prescale_128
	sts adcsra, r16 
	
	;Timer0 setup 
	ldi r16, ctc_mode|prescale_1024
	out tccr0b, r16
	ldi r16, t0_init_compab
	sts timsk0, r16
	ldi r16, 0xff ;approximately 16ms
	out ocr0a, r16
	ldi r16, 0x7f ;approximately 8ms
	out ocr0b, r16

	;Sleep enable 
	ldi r16, sleep_enable
	out smcr, r16
	
	;Port setup
	ldi r16, 0xff
	out ddrd, r16
	out ddrb, r16
	
	;Load byte address for 7 segment truth table into Z-pointer
	ldi zh, high(seg)<<1
	sei
	clr adc_value

main:
;	Wait for ADC value as well multiplex displays with timer interrupts
	sleep							
	cpi adc_value, 0
	breq main
	ldi r16, 0
	sts adcsra, r16	;disable ADC
	call temp_convert
	clr t_seconds	;t=0
wait:
    sleep			
	cpi t_seconds, 255 ;wait approximately 4 seconds
	brne wait
	ldi r16, adc_enable|adc_interrupt|prescale_128	;re-enable ADC
	sts adcsra, r16 
	clr adc_value
	rjmp main

;----------Conversion algorithm---------------

temp_convert: ;Tempurtaure conversion algorithm 
						
	mov r17, adc_value	;5000/1024*10 = 125/256 
	ldi r16, 125
	fmul r17, r16
	lsr r1				;shift answer once more for 8 bit result 			
	ror r0					
	mov r16, r1
	subi r16, 50		;50 degree C offset
	mov tempurature, r16

extract_digits: ;Seperate the tempurature value into Units and Tens 
	ldi r16, 26
	fmul tempurature, r16
	lsr r1
	ror r0
	mov tens, r1
	ldi r17, 10
	mul r1, r17
	sub tempurature, r0 
	mov units, tempurature

display_digits:
	mov zl, tens
	lpm 
	mov tens, r0 
	mov zl, units
	lpm 
	mov units, r0 
	ret

;--------------INTERUPT HANDLERS-------
adc_in:
	lds adc_value, adcl ;read value 
	lds r17, adch
	reti 

timerA: ;Display units of the tempurature 
	cbi portb, 1
	out portd, units
	sbi portb, 0
	inc t_seconds
	reti
	
timerB: ;Display tens of the tempurature 
	cbi portb, 0
	out portd, tens
	sbi portb, 1
	reti

;7seg truth table 	
.org 0x0100
seg:
.db 0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0xff, 0x6f 
