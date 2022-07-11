=begin
  Everything in Ruby is an object.
  
  print -> write to console, no line breaks
  puts -> write to console, line breaks
  p -> shorthand for puts
=end

=begin
  Interactive Ruby
  run 'irb' from command line
  you can also find the ruby installation folder and execute irb there.
=end

=begin
  Parallel variable assignment.
  a,b,c = 10,20,30  # a = 10 & b = 20 & c = 30
  a,b = 10  # a = 10 & b = nil
  a = b = 10  # a = 10 & b = 10
=end

=begin
  every line of code has an implicit return
  the value returned will always be the last operation to be performed
  for example:
    puts 1 + 2  # writes "3" to console, but returns nil because puts doesn't return anything
=end

=begin
  String interpolation
  puts "1 + 1 = #{1 + 1}"  # outputs to console: "1 + 1 = 2"
=end

00
