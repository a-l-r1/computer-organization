`ifndef DEBUG_H
`define DEBUG_H

/* The ultimate switch */
`define DEBUG

`ifdef DEBUG
`define debug_write(x) $write("%s", $sformatf A);
`define normal_write(x) $write("[time %d] normal display: %s", $time, $sformatf A);
`else
`define debug_write(x) 
`define normal_write(x) $write("%s", $sformatf A);
`endif /* DEBUG */

`endif /* DEBUG_H */

