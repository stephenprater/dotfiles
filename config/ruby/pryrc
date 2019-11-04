["~/.irbrc", "~/.pryrc.local"].each do |file|
  path = File.expand_path file
  load path if File.exists?(path)
end

$: << "/Users/stephenprater/.gem/ruby/2.3.4/gems/awesome_print-1.7.0/lib/"
$: << "/Users/stephenprater/.gem/ruby/2.3.4/gems/gist-4.6.1/lib/gist.rb"

require 'awesome_print'
AwesomePrint.pry!

# Pry.run_command "enable-bond!"

#PryByebug.binding_behavior = :byebug

def pbcopy(str)
  `echo '#{str.ai(plain: true, index: false)}' | socat - tcp:localhost:2224`
  STDOUT.puts "-- Copied to Clipboard --"
end

Pry.config.commands.command "hiscopy", "History copy to clipboard" do |n|
  pbcopy _pry_.input_array[n ? n.to_i : -1]
end

Pry.config.commands.command "copy", "Copy to clipboard" do |str|
  if str.blank?
    str = "#{_pry_.input_array[-1]} #=> #{_pry_.last_result.ai(plain: true)}\n"
  elsif str == "_"
    str = _pry_.last_result
  end
  pbcopy str
end

Pry.config.commands.command "lastcopy", "Last result copy to clipboard" do
  pbcopy _pry_.last_result.chomp
end
