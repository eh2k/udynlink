ENTRY(main)

/* Specify the memory areas */
MEMORY
{
  all                   (RWX) : ORIGIN = 0x00000000, LENGTH = 0xFFFFFFFF
}

/* Define output sections */
SECTIONS
{
  /* The startup code goes first into internal flash */
  .text :
  {
    . = ALIGN(4);
    *(.text)                 /* .text sections (code) */
    *(.text*)                /* .text* sections (code) */
    . = ALIGN(8);
  } > all

  /* constructors : ALIGN(4) SUBALIGN(4)
  {
      PROVIDE(__ctor_array_start = .);
      KEEP(*(SORT(.init_array.*)))
      KEEP(*(.init_array))
      PROVIDE(__ctor_array_end = .);
  } > all

  destructors : ALIGN(4) SUBALIGN(4)
  {
      PROVIDE(__dtor_array_start = .);
      KEEP(*(.fini_array))
      KEEP(*(SORT(.fini_array.*)))
      PROVIDE(__dtor_array_end = .);
  } > all */

  .data :
  {
    . = ALIGN(4);
    *(.data)                 /* .data sections */
    *(.data*)                /* .data* sections */
    *(.rodata)               /* .rodata sections (constants, strings, etc.) */
    *(.rodata*)              /* .rodata* sections (constants, strings, etc.) */
    . = ALIGN(4);
		KEEP(*(.init))
		__preinit_array_start = .;
		KEEP (*(.preinit_array))
		__preinit_array_end = .;
		__init_array_start = .;
		KEEP (*(.init_array))
		__init_array_end = .;
		. = ALIGN(4);
  } > all

  .bss (NOLOAD): ALIGN(4) SUBALIGN(4)
  {
      PROVIDE(_pbss_start = .);        
      sbss = .;
      * (.bss);
      * (.bss*);
      ebss = .;
      PROVIDE(_pbss_end = .);        
  } > all
/* 
  .sdram (NOLOAD): ALIGN(4) SUBALIGN(4)
  {
    *(.sdram*)
  } > all */

  .got :
  {
    *(.got*)
  }

  /DISCARD/ : {
    /* *(.sdram*) */
    *(.boot*) 
    *(.comment) 
  }
}
