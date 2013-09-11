
/* This is a switch file which contains global flags for state machine */


/* Here address is a constant. This constant can be used for determining exact location of the */
addr1 = 0x00000A


/*All states of state machine are just integer values, which have names been declared in .sml file.*/

Global_State @ addr1

/* This form is acceptable for placing variables to some specific location
@ addr1 {
	Global_State
}
*/

/* The number of bytes needed for state count is allocated automatically and
usually it's 2 bytes. */


/* We also can have interrupts, it's a piece of code which can be invoked form
any state and be returned to the same state after finishing interrupt 

Interrupts does not have any specific flags except hardware flags.
But sometimes it's possible to define custom interrupt which can be driven by any
hardware interrupt py polling corresponding flag. In this situation we have to establish connection between flag and State.
*/

Int_T0 @ Interrupt0

Int_I2C @ Interrupt1

Int_RX @ Interrupt2

Int_TX @ Interrupt3


/* Here we have some switches in the state machine where 
one state can resume to more than one state.
This construction it's a generalized switch: case condition, where evaluation of the flag in () is true. Here "TX_BYTE_COUNT" is a flag, usually it's an unsigned  integer number if it's not determined otherwise.

To determine switching condition the test function is(TX_BYTE_COUNT, positive) == TRUE, then switching is done to corresponding state.
The state is always one so, we don't need ";" in the end 
*/

ui4 TX_BYTE_COUNT 

/*It means that it's unsigned int and takes 4 bytes in the memory. But we actually don't need such a big space for it and we could define it like
"ui" or even like "positive|zero" 

positive|zero TX_BYTE_COUNT

The type definition can contain the range of values which is used for validation
during compilation process.

*/



Check_TX_BUF (TX_BYTE_COUNT)
{
	positive: Int_TX
	zero: Int_T0
}

uc RX_BYTE	// This is received byte

/* Here the word "other" means that all other choises are not fit.*/

Check_PACK (RX_PACK)
{
	0x0D: PACK_READY
	other: PACK_IS_NOT_READY
}

uc I2C_STEP

Int_I2C (I2C_STEP)
{
	0: Start_I2C
	1: Write_I2C
	[2..10]: Read_I2C
	other: Stop_I2C
}
