local addon, ns = ...
local L = ns.L

--------------------------------------------------------------------------------
-- # MODULES > SPELLID
--------------------------------------------------------------------------------

local function AddIDLine(self, id, isItem)
  for i = 1, self:NumLines() do
    local line = _G[self:GetName()..'TextLeft'..i]
    if not line then break end
    local text = line:GetText()
    if text and strfind(text, id) then return end
  end
  if isItem then
    self:AddLine('|cff1994ff'..L.ITEM_ID..' |cnWHITE_FONT_COLOR:'..id..'|r')
  else
    self:AddLine('|cff1994ff'..L.SPELL_ID..' |cnWHITE_FONT_COLOR:'..id..'|r')
  end
  self:Show()
end

local function OnTooltipSetSpell(self)
  local _, id = self:GetSpell()
  if id then AddIDLine(self, id) end
end

hooksecurefunc(GameTooltip, 'SetUnitAura', function(self, ...)
  local id = select(10, UnitAura(...))
  if id then AddIDLine(self, id) end
  if debuginfo == true and id and IsModifierKeyDown() then print(UnitAura(...)..': '..id) end
end)

local function attachByAuraInstanceID(self, ...)
  local aura = C_UnitAuras.GetAuraDataByAuraInstanceID(...)
  local id = aura and aura.spellId
  if id then AddIDLine(self, id) end
  if debuginfo == true and id and IsModifierKeyDown() then print(UnitAura(...)..': '..id) end
end

hooksecurefunc(GameTooltip, 'SetUnitBuffByAuraInstanceID', attachByAuraInstanceID)
hooksecurefunc(GameTooltip, 'SetUnitDebuffByAuraInstanceID', attachByAuraInstanceID)

hooksecurefunc('SetItemRef', function(link)
  local id = tonumber(link:match('spell:(%d+)'))
  if id then AddIDLine(ItemRefTooltip, id) end
end)

local function attachItemTooltip(self)
  local _, link = TooltipUtil.GetDisplayedItem(self)
  if not link then return end
  local id = link:match('item:(%d+):')
  if id then AddIDLine(self, id, true) end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, OnTooltipSetSpell)
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, attachItemTooltip)
