`ifndef DEBUG_H
`define DEBUG_H

/* The ultimate switch */
`define DEBUG

`ifdef DEBUG
`define debug_display display
`define normal_display normal_display_wrapped
`else
`define debug_display do_nothing
`define normal_display display
`endif /* DEBUG */

`endif /* DEBUG_H */

