`ifndef DEBUG_H
`define DEBUG_H

/* The ultimate switch */
/* WARNING: use `undef to turn off debugging properly */

`undef DEBUG

/* Force override debugging */
`ifdef NODEBUG
/* Add tab (literally) for preventing tools/debug-control.py from griefing */
`undef	DEBUG
`endif

/* Default PART_NAME */

`ifndef PART_NAME
`define PART_NAME "debug"
`endif

/* Mind the brackets! */

`ifdef DEBUG
/* PART_NAME will be defined by the using part */
/* the default PART_NAME is defined above for safety */
`define debug_write(A) $write("[time %0d] ", $time); $write(`PART_NAME); $write(": "); $write A 
`define normal_write(A) $write("[time %0d] [normal display] ", $time); $write A 
`else
/* effectively no-op */
`define debug_write(A) 
`define normal_write(A) $write A 
`endif /* DEBUG */

`ifdef DEBUG
`define debug_display(A) `debug_write(A); $write("\n")
`define normal_display(A) `normal_write(A); $write("\n")
`else
`define debug_display(A) 
`define normal_display(A) `normal_write(A); $write("\n")
`endif /* DEBUG */

`endif /* DEBUG_H */

