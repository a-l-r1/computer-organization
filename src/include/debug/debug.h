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

/* Hack */

function void _debug_print(string s);
	$display("%s", s);
endfunction

`define DEBUG_PRINT_TRAP

/* TODO: nest it deeper when this hack works */

`define DEBUG_PRINT(p0, p1=EBUG_PRINT_TRAP, p2=EBUG_PRINT_TRAP) \
	`ifdef D``p1 \ 
		_debug_print($sprintf(p0)); \
	`else \
		`ifdef D``p2 \ 
			_debug_print($sprintf(p0, p1)); \
		`else \
			_debug_print($sprintf(p0, p1, p2)); \
		`endif \
	`endif


`endif /* DEBUG_H */

