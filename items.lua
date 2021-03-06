return {
    PlaceObj('ModItemCode', {
        'name', "HuskyResearchFundingScript", 
        'comment', "igrgurina", 
        'FileName', "Code/HuskyResearchFundingScript.lua", 
    }), 
    PlaceObj('ModItemCode', {
        'name', "HuskyTimeScript", 
        'comment', "igrgurina", 
        'FileName', "Code/HuskyTimeScript.lua", 
    }), 
    PlaceObj('ModItemCommanderProfile', {
        'name', "Husky", 
        'comment', "igrgurina", 
        'display_name', T{315637784763, --[[ModItemCommanderProfile Husky display_name]] "Husky"}, 
        'challenge_mod', 10, 
        'effect', T{439641132159, --[[ModItemCommanderProfile Husky effect]] "- Husky wag tail (<color 250 236 208>Breakthrough Anomalies</color> are more common)<newline>- Husky paw paw (start with extra <color 250 236 208>Rocket</color>)<newline>- Husky woof woof (bonus Tech: <color 250 236 208>Autonomous Hubs</color> (Drone Hubs no longer require Power or maintenance))"}, 
        'anomaly_bonus_breakthrough', range(2, 94), 
        'bonus_rockets', 1, 
        'game_apply', function (self, city)
            GrantTech("AutonomousHubs") -- woof woof
            -- AddCustomOnScreenNotification("Research","Breakthrough", "Researched " .. tech)
            GrantTech("SuperconductingComputing") -- woof woof 
            GrantTech("AutonomousSensors") -- sniff sniff
            GrantTech("DeepScanning") -- dig
            GrantTech("AtomicAccumulator") -- energetic
            CreateLabelModifier("HuskyCommander", "FusionReactor", "electricity_production", 0, 50)
            CreateLabelModifier("HuskyCommander", "AtomicBattery", "max_electricity_charge", 0, 100)
            CreateLabelModifier("HuskyCommander", "WasteRockDumpSite", "max_amount_WasteRock", 0, 100)
        end, 
    }), 
    PlaceObj('ModItemDecalEntity', {
        'name', "HuskyLogoDecal", 
        'comment', "igrgurina", 
        'entity_name', "Husky_Decal_Logo", 
        'display_name', "Husky", 
        'filename', "C:/Users/Ivan Grgurina/AppData/Roaming/Surviving Mars/Mods/Husky_ Mission Logo/Husky.png", 
    }), 
    PlaceObj('ModItemDecalEntity', {
        'name', "RainbowLogoDecal", 
        'comment', "igrgurina", 
        'entity_name', "Rainbow_Decal_Logo", 
        'display_name', "Rainbow", 
        'filename', "C:/Users/Ivan Grgurina/Documents/Surviving Mars/Mods/Husky_ Mission Logo/Rainbow.png", 
    }), 
    PlaceObj('ModItemGameValue', {
        'name', "CheaperBreakthroughs", 
        'comment', "igrgurina", 
        'category', "Research", 
        'id', "BreakThroughTechCostMod", 
        'percent', -20, 
    }), 
    PlaceObj('ModItemMissionLogo', {
        'name', "HuskyLogo", 
        'comment', "igrgurina", 
        'entity_name', "Husky_Decal_Logo", 
        'decal_entity', "Husky_Decal_Logo", 
        'image', "UI/Husky_Decal_LogoUI.tga", 
        'display_name', T{826256311916, --[[ModItemMissionLogo HuskyLogo display_name]] "Home in the stars"}, 
    }), 
    PlaceObj('ModItemMissionLogo', {
        'name', "RainbowLogo", 
        'comment', "igrgurina", 
        'entity_name', "Rainbow_Decal_Logo", 
        'decal_entity', "Rainbow_Decal_Logo", 
        'image', "UI/Rainbow_Decal_LogoUI.tga", 
        'display_name', T{884322788512, --[[ModItemMissionLogo RainbowLogo display_name]] "Love in the stars"}, 
    }), 
    PlaceObj('ModItemMissionSponsor', {
        'name', "Husky", 
        'comment', "igrgurina", 
        'display_name', T{724239729160, --[[ModItemMissionSponsor Husky display_name]] "Northern Lights"}, 
        'challenge_mod', 250, 
        'funding', 15000, 
        'funding_per_tech', 150, 
        'funding_per_breakthrough', 300, 
        'applicants_per_breakthrough', 50, 
        'cargo', 150000, 
        'initial_rockets', 1, 
        'rocket_price', 850000000000, 
        'applicants_price', 50000000, 
        'initial_techs_unlocked', 2, 
        'trait', "HuskyTrait", 
        'anomaly_bonus_breakthrough', range(4, 96), 
        'effect', T{411167707559, --[[ModItemMissionSponsor Husky effect]] "Difficulty: <em>Normal</em><newline><newline>Funding: $<funding> M<newline>Research per Sol: <research(SponsorResearch)><newline>Rare Metals price: $<ExportPricePreciousMetals> M<newline>Starting Applicants: <ApplicantsPoolStartingSize><newline><newline>- 5 extra starting technologies, but no sponsored research <em>(drawback)</em><newline>- Discover more Breakthrough Anomalies<newline>- Gain Funding every time a tech is researched. Gain double if it's a Breakthrough tech<newline>- Researching a Breakthrough Tech grants Applicants and you can buy additional Applicants with funding<newline>- Can only have <em>Husky</em> Colonists <em>(drawback)</em><newline>- Extra Starting Rockets with Large payload (<cargo> kg), but Additional Rockets cannot be bought <em>(drawback)</em>"}, 
        'flavor', T{822144428938, --[[ModItemMissionSponsor Husky flavor]] "Game doesn't allow me to forbid buying rockets, so instead I've made them really expensive to discourage such behaviour."}, 
        'default_skin', "Star", 
        'game_apply', function (self, city)
            GrantTech("SuperiorCables") -- protection from husky
            GrantTech("SuperiorPipes") -- protection from husky
            GrantTech("ExtractorAI") -- dig
            CreateGameTimeThread(function()
                Sleep(1000) --Wait until applicants generation has completed
                g_ApplicantPoolFilter.HuskyTrait = nil
                WaitPopupNotification(false, {
                    title = T{"About Husky"}, 
                    text = T{"This mod enables you to play with all things husky. Try to survive by using some unorthodox methods and never-seen-before play style. <newline><newline><em>HINT:</em> Spend initial sponsor money to invest in outsourcing research."}, 
                    choice1 = T{"Woof woof"}, 
                    image = "UI/Messages/alleys.tga", 
                }) 
            end)
        end, 
        'goal', "MG_Anomalies", 
        'sponsor_nation_name1', "Russian", 
        'sponsor_nation_percent1', 60, 
        'sponsor_nation_name2', "American", 
        'sponsor_nation_percent2', 20, 
        'sponsor_nation_name3', "Japanese", 
        'sponsor_nation_percent3', 5, 
        'sponsor_nation_name4', "Chinese", 
        'sponsor_nation_percent4', 5, 
        'sponsor_nation_name5', "Swedish", 
        'sponsor_nation_percent5', 5, 
        'sponsor_nation_name6', "Brazilian", 
        'sponsor_nation_percent6', 5, 
        'RCRover', 1, 
        'ExplorerRover', 1, 
        'RCTransport', 1, 
        'Drone', 50, 
        'Polymers', 30, 
        'MachineParts', 25, 
        'Electronics', 30, 
        'DroneHub', 1, 
        'MoistureVaporator', 1, 
        'FuelFactory', 1, 
        'StirlingGenerator', 5, 
        'OrbitalProbe', 10, 
        }, {
        PlaceObj('TechEffect_ModifyLabel', {
            'Label', "Consts", 
            'Prop', "SponsorResearch", 
            'Percent', -100, 
        }), 
    }), 
    PlaceObj('ModItemRadioStation', {
        'name', "HuskyMusic", 
        'comment', "igrgurina", 
        'display_name', T{472768075585, --[[ModItemRadioStation HuskyMusic display_name]] "Woof Woof"}, 
        'folder', "Music/Husky", 
        'silence', 1, 
    }), 
    PlaceObj('ModItemTrait', {
        'name', "HuskyTrait", 
        'comment', "igrgurina", 
        'display_name', T{694409617122, --[[ModItemTrait HuskyTrait display_name]] "Husky"}, 
        'category', "other", 
        'description', T{836563932929, --[[ModItemTrait HuskyTrait description]] "Raises the Morale of all Adult people in the Dome. Benefits stack with each additional Husky."}, 
        'param', 10, 
        'apply_func', function (colonist, trait, init) end, 
        'modify_target', "dome colonists", 
        'modify_trait', "Adult", 
        'modify_property', "base_morale", 
        'modify_amount', 10, 
        'infopanel_effect_text', T{227855381787, --[[ModItemTrait HuskyTrait infopanel_effect_text]] "Husky wag tail +<amount> times"}, 
    }), 
}
