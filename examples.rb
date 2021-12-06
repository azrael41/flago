"""
Getting started
"""

flago = FlagHandler::Flagger.new
# get all flags
flago.flags

# add flag with operation
temp = Proc.new { |info| puts info }
flago.add_flag('-i', temp)

# add flag without operation
flago.add_flag('-h')

# remove flag
flago.remove_flag('-h')

# check if flag exists
flago.flag? '-i' 
# >> true

# get all flags in string
temp = "-h hello!"
flago.process(temp)
# >> ['-h']
