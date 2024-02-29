local addon, ns = ...
local L = {}
ns.L = L

--------------------------------------------------------------------------------
-- # CORE > LOCALIZATION
--------------------------------------------------------------------------------

-- ## ENGLISH
--------------------------------------------------------------------------------

L['STATUS_AFK'] = 'AFK'
L['STATUS_DND'] = 'DND'
L['SPELL_ID'] = 'Spell ID:'
L['ITEM_ID'] = 'Item ID:'

local locale = GetLocale()
if locale == 'en_GB' or locale == 'en_US' then return end -- ENGLISH

-- ## OTHER
--------------------------------------------------------------------------------

-- if locale == 'esMX' then return end  -- SPANISH (MEXICO)
-- if locale == 'pt_BR' then return end -- PORTUGEUSE
-- if locale == 'de_DE' then return end  -- GERMAN
-- if locale == 'es_ES' then return end  -- SPANISH (SPAIN)
-- if locale == 'fr_FR' then return end  -- FRENCH
-- if locale == 'it_IT' then return end -- ITALIAN
-- if locale == 'ru_RU' then return end  -- RUSSIAN
-- if locale == 'ko_KR' then return end -- KOREAN
-- if locale == 'zh_TW' then return end  -- CHINESE (TRADITIONAL)
-- if locale == 'zh_CN' then return end  -- CHINESE (SIMPLIFIED)
