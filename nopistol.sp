Public OnPluginStart(){
	new weaponIndex = GetPlayerWeaponSlot(client, PLAYER_SLOT_SECONDARY);

	if (weaponIndex > -1) {
		new String:classname[STR_MAX_WPCLASSNAME];
		GetEdictClassname(weaponIndex, classname, sizeof(classname)); 

		if (StrEqual(classname, "weapon_pistol")) {
			RemovePlayerItem(client, weaponIndex);
		}
	}
}









    // if we're playing coop, strip survivor items first
    if (g_bCampaignMode)
    {
        for (new i = PLAYER_SLOT_PRIMARY; i <= PLAYER_SLOT_PILL; i++)
        {
            new weaponIndex = GetPlayerWeaponSlot(client, i);
            if (weaponIndex > -1) {
                RemovePlayerItem(client, weaponIndex);
            }
        }
        GiveItem(client, "weapon_pistol", 0, 0);
    }
	
	    // weapon 'gift':
    // if we're replacing the single pistol, remove it
    
        new weaponIndex = GetPlayerWeaponSlot(client, PLAYER_SLOT_SECONDARY);
        
        if (weaponIndex > -1) {
            new String:classname[STR_MAX_WPCLASSNAME];
            GetEdictClassname(weaponIndex, classname, sizeof(classname)); 
            
            if (StrEqual(classname, "weapon_pistol")) {
                RemovePlayerItem(client, weaponIndex);
            }
        }
    }