`include "debug/debug.h"

module debug_print_test(
);

initial begin
	$write("debug printing test begin\n");

	/* one argument */
	`debug_write("42");
	$write("\n");

	/* two arguments */
	`debug_write("%d", 2 + 2);
	$write("\n");

	/* two arguments w/ a string formatted */
	`debug_write("%s", "aaa");
	$write("\n");

	/* three arguments */
	`debug_write("%d + %d = 5", 2, 2);
	$write("\n");
end

endmodule

