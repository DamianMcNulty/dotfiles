if ENV['RAILS_ENV']
  load File.join(File.dirname(__FILE__), '.railsrc')
end

%w{irb/completion irb/ext/save-history}.each do |lib|
  begin
    require lib
  rescue LoadError => err
    $stderr.puts "Couldn't load #{lib}: #{err}"
  end
end

ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

# Some default enhancements/settings for IRB, based on
# http://wiki.rubygarden.org/Ruby/page/show/Irb/TipsAndTricks

# Setup permanent history.
IRB.conf[:SAVE_HISTORY] = 50000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
HISTFILE = IRB.conf[:HISTORY_FILE]
MAXHISTSIZE = IRB.conf[:SAVE_HISTORY]
begin
  histfile = File::expand_path(HISTFILE)
  if File::exists?(histfile)
    lines = IO::readlines(histfile).collect { |line| line.chomp }
    puts "Read #{lines.nitems} saved history commands from '#{histfile}'." if $VERBOSE
    Readline::HISTORY.push(*lines)
  else
    puts "History file '#{histfile}' was empty or non-existant." if $VERBOSE
  end
  Kernel::at_exit do
    lines = Readline::HISTORY.to_a.reverse.uniq.reverse
    lines = lines[-MAXHISTSIZE, MAXHISTSIZE] if lines.nitems > MAXHISTSIZE
    puts "Saving #{lines.length} history lines to '#{histfile}'." if $VERBOSE
    File::open(histfile, File::WRONLY|File::CREAT|File::TRUNC) { |io| io.puts lines.join("\n") }
  end
rescue => e
  puts "Error when configuring permanent history: #{e}" if $VERBOSE
end

def history; puts Readline::HISTORY.entries.last(50).join("\n"); end

class Object
  # From http://stackoverflow.com/users/6349/webmat
  # Return only the methods not present on basic objects
  def interesting_methods
    (self.methods - Object.new.methods).sort
  end
end

# From http://eigenclass.org/hiki.rb?cmd=view&p=irb+ri+completion&key=ruby%2Bdocumentation%2Birb
require 'irb/completion'

# module Kernel
#   def r(arg)
#     puts `qri "#{arg}"`
#   end
#   private :r
# end

# class Object
#   def puts_ri_documentation_for(obj, meth)
#     case self
#     when Module
#       candidates = ancestors.map{|klass| "#{klass}::#{meth}"}
#       candidates.concat(class << self; ancestors end.map{|k| "#{k}##{meth}"})
#     else
#       candidates = self.class.ancestors.map{|klass|  "#{klass}##{meth}"}
#     end
#     candidates.each do |candidate|
#       #puts "TRYING #{candidate}"
#       desc = `qri '#{candidate}'`
#       unless desc.chomp == "nil"
#       # uncomment to use ri (and some patience)
#       #desc = `ri -T '#{candidate}' 2>/dev/null`
#       #unless desc.empty?
#         puts desc
#         return true
#       end
#     end
#     false
#   end
#   private :puts_ri_documentation_for
# 
#   def method_missing(meth, *args, &block)
#     if md = /ri_(.*)/.match(meth.to_s)
#       unless puts_ri_documentation_for(self,md[1])
#         "Ri doesn't know about ##{meth}"
#       end
#     else
#       super
#     end
#   end
# 
#   def ri_(meth)
#     unless puts_ri_documentation_for(self,meth.to_s)
#       "Ri doesn't know about ##{meth}"
#     end
#   end
# end
# 
# RICompletionProc = proc{|input|
#   bind = IRB.conf[:MAIN_CONTEXT].workspace.binding
#   case input
#   when /(\s*(.*)\.ri_)(.*)/
#     pre = $1
#     receiver = $2
#     meth = $3 ? /\A#{Regexp.quote($3)}/ : /./ #}
#     begin
#       candidates = eval("#{receiver}.methods", bind).map do |m|
#         case m
#         when /[A-Za-z_]/; m
#         else # needs escaping
#           %{"#{m}"}
#         end
#       end
#       candidates = candidates.grep(meth)
#       candidates.map{|s| pre + s }
#     rescue Exception
#       candidates = []
#     end
#   when /([A-Z]\w+)#(\w*)/ #}
#     klass = $1
#     meth = $2 ? /\A#{Regexp.quote($2)}/ : /./
#     candidates = eval("#{klass}.instance_methods(false)", bind)
#     candidates = candidates.grep(meth)
#     candidates.map{|s| "'" + klass + '#' + s + "'"}
#   else
#     IRB::InputCompletor::CompletionProc.call(input)
#   end
# }
# #Readline.basic_word_break_characters= " \t\n\"\\'`><=;|&{("
# Readline.basic_word_break_characters= " \t\n\\><=;|&"
# Readline.completion_proc = RICompletionProc

