/*    
		Witchflip

   by purpletreefactory
   Credit for the idea goes to Fig
   This version was made out of convenience
   
 */
 
#include <sourcemod>
#include <sdktools>

new result_int;
new String:client_name[32]; // Used to store the client_name of the player who calls coinflip
new previous_timeC = 0; // Used for coinflip
new current_timeC = 0; // Used for coinflip
new previous_timeN = 0; // Used for picknumber
new current_timeN = 0; // Used for picknumber
new Handle:delay_time; // Handle for the coinflip_delay cvar
new number_max = 20; // Default maximum bound for picknumber

public Plugin:myinfo =
{
	name = "Teamflip",
	author = "purpletreefactory, epilimic",
	description = "epilimic's version of coinflip for picking teams",
	version = "1.0.1.0.1",
	url = "http://www.sourcemod.net/"
}
 
public OnPluginStart()
{
	delay_time = CreateConVar("coinflip_delay","-1", "Time delay in seconds between allowed coinflips. Set at -1 if no delay at all is desired.");

	RegConsoleCmd("sm_teamflip", Command_Coinflip);
	RegConsoleCmd("sm_tf", Command_Coinflip);
	RegConsoleCmd("sm_coinflip", Command_Coinflip);
	RegConsoleCmd("sm_cf", Command_Coinflip);
	RegConsoleCmd("sm_buttsecs", Command_Coinflip);
	RegConsoleCmd("sm_roll", Command_Picknumber);
	RegConsoleCmd("sm_picknumber", Command_Picknumber);
}

public Action:Command_Coinflip(client, args)
{
		result_int = GetURandomInt() % 2; // Gets a random integer and checks to see whether it's odd or even
		GetClientName(client, client_name, sizeof(client_name)); // Gets the client_name of the person using the command
		
		if(result_int == 0)
			PrintToChatAll("\x05%s \x01flipped a coin and it landed on \x05Survivor\x01!", client_name);
		else
			PrintToChatAll("\x05%s \x01flipped a coin and it landed on \x05Infected\x01!", client_name);

	return Plugin_Handled;
}

public Action:Command_Picknumber(client, args)
{
	current_timeN = GetTime();
	
	if((current_timeN - previous_timeN) > GetConVarInt(delay_time)) // Only perform a numberpick if enough time has passed since the last one.
	{
		GetClientName(client, client_name, sizeof(client_name)); // Gets the client_name of the person using the command
		
		if(GetCmdArgs() == 0)
		{
			result_int = GetURandomInt() % (number_max); // Generates a random number within the default range
			
			PrintToChatAll("\x05%s \x01rolled a \x04%d \x01sided die!\nIt's \x04%d\x01!", client_name, number_max, result_int + 1);
		}
		else
		{
			new String:arg[32];
			new max;
			
			GetCmdArg(1, arg, sizeof(arg)); // Get the command argument
			max = StringToInt(arg);
			
			result_int = GetURandomInt() % (max); // Generates a random number within the specified range
			PrintToChatAll("\x05%s \x01rolled a \x04%d \x01sided die!\nIt's \x04%d\x01!", client_name, max, result_int + 1);
		}
		
		previous_timeN = current_timeN; // Update the previous time
	}
	else
	{
		PrintToConsole(client, "[Teamflip] Whoa there buddy, slow down. Wait at least %d seconds.", GetConVarInt(delay_time));
	}
}