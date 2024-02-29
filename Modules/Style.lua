local addon, ns = ...
local L = ns.L

--------------------------------------------------------------------------------
-- # MODULES > STYLE
--------------------------------------------------------------------------------

-- hide
ITEM_CREATED_BY = ''

-- unit colours
local function GetColor(unit)
  if not unit then return end
  local r, g, b

  if UnitIsPlayer(unit) then
    local _, class = UnitClass(unit)
    local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
    if color then
      r, g, b = color.r, color.g, color.b
    else
      r, g, b = 1, 1, 1
    end
  elseif UnitIsTapDenied(unit) or UnitIsDead(unit) then
    r, g, b = 0.6, 0.6, 0.6
  else
    local reaction = UnitReaction(unit, 'player')
    if reaction then
      r, g, b = FACTION_BAR_COLORS[reaction].r, FACTION_BAR_COLORS[reaction].g, FACTION_BAR_COLORS[reaction].b
    else
      r, g, b = 1, 1, 1
    end
  end

  return r, g, b
end

-- style
local function UpdateTooltip(self)
  if self ~= GameTooltip or self:IsForbidden() then return end
  local lines = self:NumLines()
  local unit = (select(2, self:GetUnit())) or (GetMouseFocus() and GetMouseFocus().GetAttribute and GetMouseFocus():GetAttribute("unit")) or (UnitExists("mouseover") and "mouseover") or nil

  if not unit then return end

  local r, g, b = GetColor(unit)
  GameTooltipTextLeft1:SetTextColor(r, g, b)

  -- status indicator
  if UnitIsAFK(unit) then
    self:AppendText((' %s'):format('|cffe7e716'..L.STATUS_AFK..'|r'))
  elseif UnitIsDND(unit) then
    self:AppendText((' %s'):format('|cffdd0000'..L.STATUS_DND..'|r'))
  end

  -- guild name
  if GetGuildInfo(unit) then
    local guildName, guildRankName, _, _ = GetGuildInfo(unit)
    GameTooltipTextLeft2:SetFormattedText('|cff3Ce13f%s|r |cff1994ff[%s]|r', guildName, guildRankName)
  end

  -- target
  if UnitExists(unit..'target') then

    local rTarget, gTarget, bTarget
    if UnitIsPlayer(unit..'target') then
      local _, englishClass = UnitClass(unit..'target')
      rTarget, gTarget, bTarget = GetClassColor(englishClass)
    else
      local reaction = UnitReaction(unit, 'player')
      if reaction then
        rTarget, gTarget, bTarget= FACTION_BAR_COLORS[reaction].r, FACTION_BAR_COLORS[reaction].g, FACTION_BAR_COLORS[reaction].b
      end
    end

    local text = ''

    if UnitName(unit..'target') == UnitName('player') then
      text = '|cffee7d01'..TARGET..':|r '..'|cffff0000> '..UNIT_YOU..' <|r'
    else
      text = '|cffee7d01'..TARGET..':|r '..UnitName(unit..'target')
    end

    self:AddLine(text, rTarget, gTarget, bTarget)
  end

  -- statusbar
  GameTooltip:AddLine(' ') -- add empty line to make room for status bar
  GameTooltipStatusBar:ClearAllPoints()
  GameTooltipStatusBar:SetPoint('LEFT', 8, 0)
  GameTooltipStatusBar:SetPoint('RIGHT', -8, 0)
  GameTooltipStatusBar:SetPoint('BOTTOM', 0, 10)
  GameTooltipStatusBar:SetHeight(8)
  GameTooltipStatusBar:SetStatusBarTexture('Interface\\ChatFrame\\ChatFrameBackground')
  GameTooltipStatusBarTexture:SetVertexColor(r, g, b)

  self:Show()
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, UpdateTooltip)
