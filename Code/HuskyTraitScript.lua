local function GetModLocation()
    -- /Code/HuskyTraitScript.lua = 26
    return debug.getinfo(1, "S").source:sub(2, -26)
end

local function IsTechBreakthrough(tech)
    return tech.field == "Breakthroughs"
end

local function IsSponsorHusky(sponsor)
    return sponsor == "Husky"
end

local function GetFundingPerResearch(sponsor)
    return sponsor.funding_per_tech
end

local function GetFundingPerBreakthrough(sponsor)
    return sponsor.funding_per_breakthrough
end

--function OnMsg.NewHour()

local function ShowResearchFundingNotification(tech, sponsor)
    local this_mod_dir = GetModLocation()

    local funding = GetFundingPerResearch(sponsor) -- .funding_per_tech
    local icon = "funding_research"
    local name = tech.display_name

    if IsTechBreakthrough(tech) then
        funding = GetFundingPerBreakthrough(sponsor)-- .funding_per_breakthrough
        icon = "funding_research_bt"
    end

    AddCustomOnScreenNotification(
        "ResearchFundingReceived", 
        T{917893953988, "Funding received"}, 
        T{917893953989, "$<money>M for discovering <research>"}, 
        this_mod_dir .. "UI/Icons/Notifications/" .. icon .. ".tga", 
        false, 
        {
            research = name, 
            money = funding, 
            expiration = 150000, 
            priority = "Normal", 
        } --, 
    )

end

function OnMsg.TechResearched(tech_id)
    local sponsor = GetMissionSponsor()

    if IsSponsorHusky(sponsor) then
        local tech = TechDef[tech_id]

        ShowResearchFundingNotification(tech, sponsor)
    end
end -- TechResearched
