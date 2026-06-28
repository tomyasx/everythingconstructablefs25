ECConfig = {}

ECConfig.DURATION_THRESHOLDS = {
    { maxPrice = 10000, months = 1 },
    { maxPrice = 50000, months = 2 },
    { maxPrice = 100000, months = 3 },
    { maxPrice = 250000, months = 4 },
    { maxPrice = 500000, months = 6 },
    { maxPrice = 1000000, months = 7 },
    { maxPrice = math.huge, months = 8 },
}

ECConfig.PLACEABLE_EXEMPTIONS = {
    "data/placeables/brandless/animalHusbandries/chickenBarnSmall/chickenBarnSmall.xml",
    "data/placeables/brandless/animalHusbandries/sheepBarnSmall/sheepBarnSmall.xml",
    "data/placeables/brandless/animalHusbandries/pigBarnSmall/pigBarnSmall.xml",
    "data/placeables/brandless/animalHusbandries/horseBarnSmall/horseBarnSmall.xml",
    "data/placeables/brandless/animalHusbandries/cowBarnSmall/cowBarnSmall.xml",
    { modName = "FS25_FencelessPastures", path = "xml/caprines00.xml" },
    { modName = "FS25_FencelessPastures", path = "xml/caprines01.xml" },
    { modName = "FS25_FencelessPastures", path = "xml/chicken01.xml" },
    { modName = "FS25_FencelessPastures", path = "xml/cow00.xml" },
    { modName = "FS25_FencelessPastures", path = "xml/cow01.xml" },
    { modName = "FS25_FencelessPastures", path = "xml/grass.xml" },
    { modName = "FS25_FencelessPastures", path = "xml/horse00.xml" },
    { modName = "FS25_FencelessPastures", path = "xml/horse01.xml" },
    { modName = "FS25_FencelessPastures", path = "xml/pig00.xml" },
    { modName = "FS25_FencelessPastures", path = "xml/pig01.xml" },
}

ECConfig.DEPOSIT_FRACTION = 0.10

-- Ordered list of fill types used for material generation; weights come from ECSettings
ECConfig.RESOURCE_FILL_TYPES = {
    "BOARDS", "PLANKS", "WOODBEAM", "CEMENT", "PREFABWALL", "CEMENTBRICKS", "ROOFPLATES",
    "WATER", "CONSTRUCTIONGRAVEL", "GRAVEL", "CRUSHEDSTONE", "STONE",
}

-- Alternative internal names used by some maps / filltype packs.
-- The setting key stays the first value above, but the delivered material uses the first fillType that exists in the savegame.
ECConfig.RESOURCE_FILL_TYPE_ALIASES = {
    -- Additional Filltypes / gravel packs can use either compact names or names with underscores.
    CONSTRUCTIONGRAVEL = {
        "CONSTRUCTIONGRAVEL", "CONSTRUCTION_GRAVEL",
        "CONSTRUCTIONGRAVEL_16_30", "CONSTRUCTION_GRAVEL_16_30",
        "GRAVEL_COARSE"
    },
    GRAVEL = { "GRAVEL", "GRAVEL_8_16", "COARSEGRAVEL", "COARSE_GRAVEL", "GRAVEL_FINE" },
    CRUSHEDSTONE = {
        "CRUSHEDSTONE", "CRUSHED_STONE", "CRUSHEDSTONES", "CRUSHED_STONES",
        "MIXEDGRAVEL", "MIXED_GRAVEL", "GRAVEL_MIXED"
    },
    STONE = { "STONE", "STONES" },
}

-- Fallback prices are used only if a valid fillType exists but the map/mod reports pricePerLiter as 0.
-- This keeps water and construction bulk materials usable as requirements instead of being silently ignored.
ECConfig.RESOURCE_PRICE_FALLBACKS = {
    WATER = 0.02,
    CONSTRUCTIONGRAVEL = 0.06,
    CONSTRUCTION_GRAVEL = 0.06,
    CONSTRUCTIONGRAVEL_16_30 = 0.06,
    CONSTRUCTION_GRAVEL_16_30 = 0.06,
    GRAVEL_COARSE = 0.06,
    GRAVEL = 0.05,
    GRAVEL_8_16 = 0.05,
    COARSEGRAVEL = 0.05,
    COARSE_GRAVEL = 0.05,
    GRAVEL_FINE = 0.05,
    CRUSHEDSTONE = 0.04,
    CRUSHED_STONE = 0.04,
    CRUSHEDSTONES = 0.04,
    CRUSHED_STONES = 0.04,
    MIXEDGRAVEL = 0.04,
    MIXED_GRAVEL = 0.04,
    GRAVEL_MIXED = 0.04,
    STONE = 0.04,
    STONES = 0.04,
}

-- Material names shown in the construction dialog.
-- Some fillType mods do not provide Czech/Slovak labels, so the dialog prefers these translations over fillType.title.
ECConfig.RESOURCE_DISPLAY_L10N_KEYS = {
    BOARDS = "ec_fillType_BOARDS",
    PLANKS = "ec_fillType_PLANKS",
    ROOFPLATES = "ec_fillType_ROOFPLATES",
    WATER = "ec_fillType_WATER",
    CONSTRUCTIONGRAVEL = "ec_fillType_CONSTRUCTIONGRAVEL",
    CONSTRUCTION_GRAVEL = "ec_fillType_CONSTRUCTIONGRAVEL",
    CONSTRUCTIONGRAVEL_16_30 = "ec_fillType_CONSTRUCTIONGRAVEL",
    CONSTRUCTION_GRAVEL_16_30 = "ec_fillType_CONSTRUCTIONGRAVEL",
    GRAVEL_COARSE = "ec_fillType_CONSTRUCTIONGRAVEL",
    GRAVEL = "ec_fillType_GRAVEL",
    GRAVEL_8_16 = "ec_fillType_GRAVEL",
    COARSEGRAVEL = "ec_fillType_GRAVEL",
    COARSE_GRAVEL = "ec_fillType_GRAVEL",
    GRAVEL_FINE = "ec_fillType_GRAVEL",
    CRUSHEDSTONE = "ec_fillType_CRUSHEDSTONE",
    CRUSHED_STONE = "ec_fillType_CRUSHEDSTONE",
    CRUSHEDSTONES = "ec_fillType_CRUSHEDSTONE",
    CRUSHED_STONES = "ec_fillType_CRUSHEDSTONE",
    MIXEDGRAVEL = "ec_fillType_CRUSHEDSTONE",
    MIXED_GRAVEL = "ec_fillType_CRUSHEDSTONE",
    GRAVEL_MIXED = "ec_fillType_CRUSHEDSTONE",
    STONE = "ec_fillType_STONE",
    STONES = "ec_fillType_STONE",
}

function ECConfig.getMaterialDisplayName(fillTypeName, fillType)
    local l10nKey = ECConfig.RESOURCE_DISPLAY_L10N_KEYS[fillTypeName]
    if l10nKey ~= nil and g_i18n ~= nil then
        local text = g_i18n:getText(l10nKey)
        if text ~= nil and text ~= "" and text ~= l10nKey then
            return text
        end
    end

    if fillType ~= nil and fillType.title ~= nil then
        return fillType.title
    end

    return fillTypeName or ""
end

function ECConfig.getFillTypePricePerLiter(fillTypeName, fillType)
    local pricePerLiter = 0
    if fillType ~= nil then
        pricePerLiter = fillType.pricePerLiter or 0
    end

    if pricePerLiter <= 0 then
        pricePerLiter = ECConfig.RESOURCE_PRICE_FALLBACKS[fillTypeName] or 0
    end

    return pricePerLiter
end

function ECConfig.getFillTypeForResource(resourceName)
    local names = ECConfig.RESOURCE_FILL_TYPE_ALIASES[resourceName] or { resourceName }

    for _, fillTypeName in ipairs(names) do
        local fillTypeIndex = g_fillTypeManager:getFillTypeIndexByName(fillTypeName)
        if fillTypeIndex ~= nil then
            local fillType = g_fillTypeManager:getFillTypeByIndex(fillTypeIndex)
            if fillType ~= nil then
                return fillTypeIndex, fillTypeName, fillType
            end
        end
    end

    return nil, resourceName, nil
end

ECConfig.DEFAULT_MODE = "automatic"

ECConfig.FENCE_XML = "assets/fence/ec_fence.xml"
ECConfig.FENCE_SEGMENT_ID = "panel04"
ECConfig.FENCE_INNER_SEGMENT_ID = "panel07"

ECConfig.GROUND_TYPE = "asphalt"

ECConfig.MIN_PRICE_FOR_CONSTRUCTION = 5000

ECConfig.OVERRIDE_EXISTING_CONSTRUCTIBLES = false

ECConfig.CANCELLATION_REFUND_FRACTION = 0.20
ECConfig.CANCELLATION_MATERIAL_REFUND_FRACTION = 0.35

ECConfig.FENCE_OUTER_REVERSE_WINDING = false
ECConfig.FENCE_INNER_REVERSE_WINDING = true

ECConfig.FENCE_PADDING = 2
ECConfig.FENCE_INNER_OFFSET = 2
ECConfig.FENCE_PASTURE_SEGMENT_ID = "panel12"

ECConfig.ACTIVATABLE_BUFFER = 3

ECConfig.FENCE_SIGN_I3D = "assets/sitesafety/i3ds/WarningSign1024.i3d"
ECConfig.FENCE_SIGN_HEIGHT = 1.25
ECConfig.FENCE_SIGN_PANEL_INTERVAL = 3

ECConfig.SITE_DECORATION_CELL_SIZE = 1
ECConfig.SITE_DECORATION_SIZE_BUFFER = 0.5
ECConfig.SITE_DECORATION_CLUSTER_CHANCE = 0.6
ECConfig.SITE_DECORATION_CLUSTER_RADIUS = 3
ECConfig.SITE_DECORATION_ATTEMPT_MULTIPLIER = 5
ECConfig.SITE_DECORATIONS = {
    { i3d = "data/maps/mapEU/textures/props/boots.i3d", max = 1 },
    { i3d = "data/maps/mapEU/textures/props/cementMixer01.i3d", max = 1 },
    { i3d = "data/maps/mapEU/textures/props/lockedContainer01.i3d", max = 1 },
    { i3d = "data/maps/mapEU/textures/props/sawhorse.i3d", max = 1, width = 3, depth = 2 },
    { i3d = "data/maps/mapEU/textures/props/stepStool.i3d", max = 1 },
    { i3d = "data/maps/mapEU/textures/props/wheelBarrow.i3d", max = 1 },
    { i3d = "data/maps/mapEU/textures/props/workBench01.i3d", max = 1 },
    { i3d = "data/placeables/brandless/decoration/boardStacks/boardStackSmall.i3d", max = 4, width = 5, depth = 2 },
    { i3d = "data/placeables/brandless/decoration/palletTruck/palletTruck.i3d", max = 1, width = 4, depth = 2 },
    { i3d = "data/placeables/brandless/decoration/garbageContainers/barrel01.i3d", max = 2 },
    { i3d = "data/placeables/brandless/decoration/garbageContainers/barrel02.i3d", max = 2 },
    { i3d = "data/placeables/brandless/decoration/garbageContainers/barrel03.i3d", max = 2 },
    { i3d = "data/placeables/brandless/decoration/garbageContainers/barrel04.i3d", max = 2 },
    { i3d = "data/placeables/brandless/decoration/garbageContainers/trashcan01.i3d", max = 2 },
    { i3d = "data/placeables/brandless/decoration/benches/bench02.i3d", max = 2 },
    { i3d = "data/placeables/brandless/decoration/garbageContainers/garbageContainers.i3d", max = 1 },
    { i3d = "data/placeables/mapAS/farmShacksAS/shackContainer01.i3d", max = 1, width = 9, depth = 6, priority = 1 },
    { i3d = "assets/fence/sign01.i3d", modLocal = true, max = 1 },
    { i3d = "assets/fence/sign02.i3d", modLocal = true, max = 1, width = 4, depth = 3 },
}

ECConfig.EASTER_EGG_SOUNDS = {
    "assets/sounds/easter_eggs/George1.ogg",
    "assets/sounds/easter_eggs/George2.ogg",
    "assets/sounds/easter_eggs/George3.ogg",
    "assets/sounds/easter_eggs/George4.ogg",
    "assets/sounds/easter_eggs/George5.ogg",
    "assets/sounds/easter_eggs/George6.ogg",
    "assets/sounds/easter_eggs/George7.ogg",
    "assets/sounds/easter_eggs/Ross 1.ogg",
    "assets/sounds/easter_eggs/Ross 2.ogg",
    "assets/sounds/easter_eggs/Ross3.ogg",
}
ECConfig.EASTER_EGG_CHANCE = 0.15
ECConfig.EASTER_EGG_COOLDOWN = 5000

ECConfig.SITE_SOUND_FILE = "assets/sounds/background.ogg"
ECConfig.SITE_SOUND_INNER_RADIUS_PADDING = 4
ECConfig.SITE_SOUND_OUTER_RADIUS_PADDING = 20
ECConfig.SITE_SOUND_VOLUME = 0.2

ECConfig.SITE_VEHICLES = {
    { xmlFilename = "data/vehicles/jungheinrich/efgS50S/efgS50S.xml" },
    { xmlFilename = "data/vehicles/jcb/series547/series547.xml" }
}

function ECConfig.getMonthsForPrice(price)
    for _, threshold in ipairs(ECConfig.DURATION_THRESHOLDS) do
        if price <= threshold.maxPrice then
            return threshold.months
        end
    end
    return 12
end

function ECConfig.getDepositAmount(totalPrice)
    return math.floor(totalPrice * ECConfig.DEPOSIT_FRACTION)
end

function ECConfig.getLabourCost(totalPrice)
    local labourFraction = ECSettings.getValue('labourFraction')
    return math.floor(totalPrice * labourFraction) - ECConfig.getDepositAmount(totalPrice)
end

function ECConfig.getMaterialBudget(totalPrice)
    local labourFraction = ECSettings.getValue('labourFraction')
    return totalPrice - math.floor(totalPrice * labourFraction)
end

function ECConfig.getLabourPerPhase(totalPrice, numPhases)
    return math.floor(ECConfig.getLabourCost(totalPrice) / numPhases)
end

function ECConfig.getMaterialPerPhase(totalPrice, numPhases)
    return math.floor(ECConfig.getMaterialBudget(totalPrice) / numPhases)
end

function ECConfig.generateMaterialList(materialBudget)
    local validResources = {}
    local totalWeight = 0

    local rawWeights = {}
    local allZero = true
    for _, fillTypeName in ipairs(ECConfig.RESOURCE_FILL_TYPES) do
        local w = ECSettings.getValue("resourceWeight_" .. fillTypeName) or 0
        rawWeights[fillTypeName] = w
        if w > 0 then allZero = false end
    end

    for _, resourceName in ipairs(ECConfig.RESOURCE_FILL_TYPES) do
        local fillTypeIndex, fillTypeName, fillType = ECConfig.getFillTypeForResource(resourceName)
        if fillTypeIndex ~= nil and fillType ~= nil then
            local pricePerLiter = ECConfig.getFillTypePricePerLiter(fillTypeName, fillType)
            if pricePerLiter <= 0 then
                pricePerLiter = ECConfig.RESOURCE_PRICE_FALLBACKS[resourceName] or 0
            end

            if pricePerLiter > 0 then
                local w = allZero and 1 or rawWeights[resourceName]
                if w > 0 then
                    table.insert(validResources, {
                        fillTypeIndex = fillTypeIndex,
                        fillTypeName = fillTypeName,
                        weight = w,
                        pricePerLiter = pricePerLiter,
                    })
                    totalWeight = totalWeight + w
                end
            end
        end
    end

    if totalWeight == 0 or #validResources == 0 then
        return {}
    end

    local materials = {}
    for _, res in ipairs(validResources) do
        local share = (res.weight / totalWeight) * materialBudget
        local amount = math.max(1, math.floor(share / res.pricePerLiter))
        table.insert(materials, {
            fillTypeIndex = res.fillTypeIndex,
            fillTypeName = res.fillTypeName,
            amount = amount,
            delivered = 0,
            pricePerLiter = res.pricePerLiter,
        })
    end

    local supplyBonus = ECSettings.getValue('materialSupplyBonus')
    if supplyBonus > 0 then
        local discountRemaining = materialBudget * supplyBonus

        table.sort(materials, function(a, b) return a.pricePerLiter > b.pricePerLiter end)

        for _, mat in ipairs(materials) do
            if discountRemaining <= 0 then
                break
            end
            local unitsToRemove = math.min(mat.amount - 1, math.floor(discountRemaining / mat.pricePerLiter))
            mat.amount = mat.amount - unitsToRemove
            discountRemaining = discountRemaining - (unitsToRemove * mat.pricePerLiter)
        end
    end

    for _, mat in ipairs(materials) do
        mat.pricePerLiter = nil
    end

    return materials
end

function ECConfig.shouldApplyConstruction(storeItem, placeable)
    if storeItem == nil then
        return false
    end

    local price = storeItem.price or 0
    if price <= ECConfig.MIN_PRICE_FOR_CONSTRUCTION then
        return false
    end

    if not ECConfig.OVERRIDE_EXISTING_CONSTRUCTIBLES then
        if placeable ~= nil and placeable.spec_constructible ~= nil then
            return false
        end
    end

    if placeable ~= nil and placeable.spec_fence ~= nil then
        return false
    end

    local xmlFilename = storeItem.xmlFilename
    if xmlFilename ~= nil then
        for _, exemption in ipairs(ECConfig.PLACEABLE_EXEMPTIONS) do
            local resolved
            if type(exemption) == "string" then
                resolved = exemption
            elseif exemption.resolved ~= nil then
                resolved = exemption.resolved
            else
                local mod = g_modManager:getModByName(exemption.modName)
                resolved = mod ~= nil and (mod.modDir .. exemption.path) or ""
                exemption.resolved = resolved
            end
            if xmlFilename == resolved then
                return false
            end
        end
    end

    return true
end
