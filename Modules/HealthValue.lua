local addon, ns = ...
local T = ns.T

--------------------------------------------------------------------------------
-- # MODULES > HEALTH VALUE
--------------------------------------------------------------------------------

GameTooltipStatusBar:SetScript('OnValueChanged', function(self, value)
  if not value then return end
  local min, max = self:GetMinMaxValues()
  if (value < min) or (value > max) then return end

  local _, unit = GameTooltip:GetUnit()
  if unit then
    min, max = UnitHealth(unit), UnitHealthMax(unit)
    if not self.text then
      self.text = self:CreateFontString(nil, 'OVERLAY')
      self.text:SetPoint('CENTER', GameTooltipStatusBar, 0, 1)
      self.text:SetFont(STANDARD_TEXT_FONT, 11, 'OUTLINE')
      self.text:SetShadowOffset(1,-1)
    end

    self.text:Show()

    local hp = T.ShortValue(min)..' / '..T.ShortValue(max)
    self.text:SetText(hp)
  end
end)
