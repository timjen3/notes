=begin
	This is from the Ruby Fundamentals course on Pluralsight by Alex Korban
	automatic garbage collection
	multiple inheritance not allowed
	base class is "Object" class which inherits from "BasicObject"
	there are private and protected method attributes
	Exception is base error. StandardError inherits from that. RuntimeError derives from that.
=end

puts "instance variables are private and can't be accessible outside class, methods are public"
class Spaceship
	def launch(destination)
		@destination = destination
	end
	
	def destination()
		@destination
	end
end

ship1 = Spaceship.new

ship1.launch('stratosphere')
puts ship1.destination


puts "convenience feature to do getters"
class Spaceship2
	attr_accessor :destination, :name
end

ship2 = Spaceship2.new
ship2.destination = 'stratosphere'
ship2.name = 'xr11'
puts ship2.destination
puts ship2.name

# initializers
class Spaceship3
	attr_accessor :name, :destination
	
	def initialize(name, destination)
		self.name = name
		self.destination = destination
	end
end

ship3 = Spaceship3.new('xr11', 'Stratosphere')
puts ship3.name
puts ship3.destination

puts "inheritance override is automatic on name conflicts. call base methods with super keyword"

class Probe
	def deploy(deploy_time, return_time)
		puts 'deploying'
	end
end

class MineralProbe < Probe
	def deploy(deploy_time)
		puts 'preparing sample chamber'
		super(deploy_time, Time.now + 2 * 60 * 60)
	end
end

probe1 = MineralProbe.new
probe1.deploy(Time.now)

puts "class variables and class methods are shared by all classes"
puts "class variables aren't used often because all classes share variables with subclasses"

class Probe2
	@@deploy_time = Time.now
	@@return_time = Time.now + 1000000
	
	def self.update(deploy_time, return_time)
		@@deploy_time = deploy_time
		@@return_time = return_time
	end
	
	def self.deploy()
		puts "Deployed at #{@@deploy_time}, returning at #{@@return_time}"
	end
end

Probe2.deploy
probe2 = Probe2.update(Time.now + 1000000, Time.now + 2000000)
Probe2.deploy

puts "You can monkey patch classes by re-declaring the class"
puts "You can even monkey patch classes in the standard library this way!"

class MonkeyProbe
	def deploy(deploy_time)
		puts 'monkey patched!'
	end
end

probe2 = MonkeyProbe.new
probe2.deploy(Time.now)


=begin
	&& / || : no short circuiting, && has higher precedence than ||
	and / or : short circuiting, left to right precedence
=end


puts "Condition can go at end"
puts "Condition at end, always runs at least once."
begin
	high_alert ||= 0  # this is conditional initializer; set to 0 if not exists
	high_alert += 1
end until high_alert === 5
puts high_alert

# for loop
for i in (1..)
	puts i
	if i === 5 then break end
end

puts "Methods take an optional second block parameter implicitly."
puts "The yield keyword is a special keyword that executes the block parameter"

class BlockParamDemo
	def block_param_method
		return nil unless block_given?
		puts "Executing block_param_method."
		yield
	end
end

demo = BlockParamDemo.new
result = demo.block_param_method{|x| puts 'running block param...'}


puts "You can use this pattern to wrap work in transactions"
puts "Note the alternate syntax for blocks of 'do'"

class DatabaseMock
	def with_transaction
		return nil unless block_given?
		begin
			puts "start transaction"
			yield
		rescue DBError => e
			puts "rollback transaction"
			return
		end
		puts "commit transaction"
	end
end

db = DatabaseMock.new
db.with_transaction do
	puts "select * from yadda yadda"
end

puts "You can only pass one block to each method. And you can't pass the same block from method to method unless you use the Proc class."
puts "You can create closures as well, referred to as a 'Proc'."

z = 0
proc = Proc.new {|x| 
	puts "#{x} #{z}!"
	z += 1
}
proc.call(42)
proc.call(36)

class ProcDemo
	def takes_proc(&block)
		puts "I can read argument count for blocks like this: #{block.arity}"
		block.call(42)
	end
end

p = ProcDemo.new
p.takes_proc do |x|  # unused argument to demonstrate
	proc.call()
end


puts "Procs implement === so they can be used for boolean checks"
weekend = proc {|time| time.saturday? || time.sunday?}
weekday = proc {|time| time.wday < 6}
case Time.now
	when weekend then puts "Wake up at 8:00"
	when weekday then puts "Wake up at 7:00"
end

puts "Shorthand for basic map method. These are equivalent."
WORDS = ["test", "aFtEr", "simple"]
puts WORDS.map {|x| x.upcase}
puts WORDS.map(&:upcase)

puts "This is similar, but returns an enumerator instead of an array."
puts WORDS.map do |x|
	x.upcase
end

puts "Arrays are mutable unless you freeze them."
ARRAY = []
ARRAY << 'v1'
puts ARRAY
ARRAY.freeze
begin
	ARRAY << 'v2'
rescue FrozenError => e
	puts "Array is frozen? #{ARRAY.frozen?}"
	puts e
end


puts "Modules create namespaces."
module SpaceStuff
	def self.do_stuff
		puts "Done."
	end
end
SpaceStuff.do_stuff

puts "They can be nested but require special syntax (scope resolution operator ::)."
module OuterModule
	module InnerModule
		def self.do_stuff
			puts "It is done."
		end
	end
end

OuterModule::InnerModule.do_stuff


puts "You can also use them for mixins."
puts "Mixins add functionality to classes."

module DoStuffMixin
	def do_stuff
		puts "It is done - mixin style!"
	end
end

class OverridenModule
	include DoStuffMixin
end

im = OverridenModule.new
im.do_stuff


=begin
	RVM is a ruby version manager that allows you to install multiple versions of ruby on one machine.

	In a larger project you need to import other ruby files.
	You do that by adding a 'require' statement.
	You can use a `require_relative' to import files relative to current project.

	Ruby on Rails is a popular web framework for ruby.

	
	ruby-gems is the framework for pulling libraries into a project. Libraries are called 'gems'.
	You can search the available packages, and install them with 'gem install log4r' or whatever you want to install.
	Dependencies are installed automatically.

	Bundler is a package management gem. To use it you add a gemfile to your project and use bundler to install/update gems after cloning a repo.
	Before you can use it, install it with `gem install bunder`
=end

=begin
	debugging
	you can debug via ide (such as ruby mine)
	
	you can run a script manually via `ruby -r debug runner.rb`
	when debugging manually you advanced the script with `next n` where instead of "n" you enter the number of lines to advance.
	After advancing lines you can execute ruby commands interactively to inspect variables.
=end


=begin
	Packaging applications
	
	create a .gemspec file to declare various project attributes and describe the package
	
	you can build the project with `gem build GEMFILE`
=end

