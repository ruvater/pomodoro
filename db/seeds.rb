study = Category.create name: 'Study' unless Category.where(name: 'Study').count > 0
work = Category.create name: 'Work' unless Category.where(name: 'Work').count > 0
coursera = Category.create name: 'Coursera' unless Category.where(name: 'Coursera').count > 0


# Set/update available color setting
if Setting.where(key: 'colors').count > 0
  Setting.where(key: 'colors').first.update_attributes(value: Setting::COLORS.join(','))
else
  Setting.create key: 'colors', value: Setting::COLORS.join(',')
end

# Set/update cycle length in minutes setting
if Setting.where(key: 'cycle_minutes').count > 0
  Setting.where(key: 'cycle_minutes').first.update_attributes(value: Setting::CYCLE_MINUTES.to_s)
else
  Setting.create key: 'cycle_minutes', value: Setting::CYCLE_MINUTES.to_s
end

# Set/update short break length in minutes setting
if Setting.where(key: 'short_break_minutes').count > 0
  Setting.where(key: 'short_break_minutes').first.update_attributes(value: Setting::SHORT_BREAK_MINUTES.to_s)
else
  Setting.create key: 'short_break_minutes', value: Setting::SHORT_BREAK_MINUTES.to_s
end

# Set/update long break length in minutes setting
if Setting.where(key: 'long_break_minutes').count > 0
  Setting.where(key: 'long_break_minutes').first.update_attributes(value: Setting::LONG_BREAK_MINUTES.to_s)
else
  Setting.create key: 'long_break_minutes', value: Setting::LONG_BREAK_MINUTES.to_s
end

# Set/update work cycles number to take a long break setting
if Setting.where(key: 'cycles_to_long_break').count > 0
  Setting.where(key: 'cycles_to_long_break').first.update_attributes(value: Setting::CYCLES_TO_LONG_BREAK.to_s)
else
  Setting.create key: 'cycles_to_long_break', value: Setting::CYCLES_TO_LONG_BREAK.to_s
end