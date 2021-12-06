"""
a flag handler for ruby
a translated version can be found in pylibs
"""

# flag object
class Flag
  # getters
  attr_reader :name
  attr_reader :operation

  # operation = executable code
  def initialize(name, operation=nil)
    @name = name
    @operation = operation
  end

  # checks if flag has operation
  def operation?
    if @operation
      return true
    else
      return false
    end
  end

  # turns Flag object into list
  def to_normal
    temp = [@name, @operation]
    return temp
  end
end

# for management and registration of flags
# meant for user use, unlike...
# the classes above
module FlagHandler
  class Flagger
    # getters & setters
    attr_reader :flags
    attr_accessor :act
    attr_accessor :forward_method

    def initialize(act: false, forward_method: 'puts')
      # registered flags
      @flags = []
      # boolean; determines if operation of flag is to be executed or not
      @act = act
      # preferred output method
      # if int, assume is channel ID and send to channel
      # else, print it to console
      @forward_method = forward_method
    end

    # preferred output method
    def output(msg)
      if @forward_method.is_a? integer
        $bot.channel(@forward_method).send(msg.to_s)
      else
        puts msg
      end
    end
    private :output
  
    # returns flag list with only flag names
    def names()
      temp = []
      @flags.each { |flag| temp.append(flag.name) }
      return temp
    end
    private :names
  
    # registers a flag
    def add_flag(flag_name, flag_operation=nil)
      temp = Flag.new(flag_name, flag_operation)
      @flags.append(temp)
      return true
    end
  
    # removes a flag
    def remove_flag(flag_name)
      if names().include? flag_name
        @flags.delete_at(names().find_index(flag_name))
        return true
      else
        return "Flag not found"
      end
    end
  
    # checks if flag exists
    def flag?(flag_name)
      if names().include? flag_name
        return true
      else
        return false
      end
    end
  
    # returns list of flags in string
    def process(arg)
      temp = []
      arg = arg.split()
      arg.each do |item|
        if names().include? item
          temp.append(item)
        end
      end
      # if act configuration is enabled, does the operation
      if @act
        temp.each do |flag|
          flag.operation.call if flag.operation?
          output "Called #{flag.name}"
        end
      end
      return temp
    end
  
  end
end

