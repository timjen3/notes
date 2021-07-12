require 'set'

FILE_NAME = "romeo-juliet.txt"
IGNORED_WORDS = ['and', 'the', 'to', 'of', 'that', 'but', 'it', 'what', 'this', 'for', 'as', 'so', 'then', 'an'].to_set

=begin
	These notes follow along with the Tutorial by Paolo Perrotta called Ruby: Getting Started on Pluralsight.
	You can get romeo and juliet here: https://shakespeare.folger.edu/download/
	add this "run" function to notepad++ to run the current script with ruby:
		cmd /k C:\Ruby27-x64\bin\ruby.exe "$(FULL_CURRENT_PATH)"
	this begin/end area is a multi-line comment
	constants begin with a capital letter, but all letters should be capital
	$a : global variable
	function names ending with ? typically returns a bool
	function names ending with ! typically have side effects
	return is implicit in a function and can be left out
	symbols
		symbols are like strings, but are immutable names
		for example, :hello
		this is an intermediate feature of the language
	"blocks"
		anonymous lambda functions
			do |arguments|
				# do something
			end
		or
			{ |arguments|
				# do something
			}
	only false and nil will evaluate as false in a conditional
	ruby is very forgiving, so there are a number of ways to do the same thing (ie: aliases)
	regex cheat sheet: https://medium.com/@kristenfletcherwilde/cheat-sheet-for-regex-in-ruby-6f6360035545
=end

# read text
def get_words_from_file(file_name)
	begin
		# read file          #lower   #regex-replace      #string split
		File.read(file_name).downcase.gsub(/[^a-z]/, ' ').split(' ').reject{|word| word.length === 1 or IGNORED_WORDS === word }
	rescue Errno::ENOENT => e
		puts "Could not find the specified file: " + file_name
		exit
	rescue Exception => e
		puts "Error loading file: " + file_name
		raise e
	end
end

# some counting
def count_occurrences(word_counts, word, threshold)
	puts "The word '" + word + "' appeared " + word_counts[word].to_s + " times."
	if word_counts[word] > threshold
		puts "- I like what I'm seeing!"
	elsif word_counts[word] === threshold
		puts "- Not bad. Not bad."
	else
		puts "- Keep writing..."
	end
end

def count_occurrences2(word_counts, find_count)
=begin
	case statements evaluate with a "case equals" check ie ===
	different types evaluate differently with a case statement
	for instance, an array with === evaluates as contains
	in this example we're just doing a basic case statement though
=end
	word_counts.each {|word,count|
		case count
		when find_count
			puts "The word '" + word + "' appeared " + count.to_s + " times."
		end
	}
end

def top_x(word_counts, x)
	word_counts.sort_by {|word,count| count}.reverse.to_a[..x]
end

words = get_words_from_file(FILE_NAME)
puts "Length is " + words.length.to_s
puts "Distinct length is " + words.uniq.length.to_s

# some array indexing
first_word = words[0]  # first
last_word = words[-1]  # last
last_7_words = words[-7..-2]  # from last 7 to last-minus-one
last_7_words2 = words[-7..]  # from last 7 to end
last_7_words_minus_1 = words[-7...]  # from last 7 to last-minus-one

# some demo code
word_count = {}
word_count.default = 0
words.each {|x|
	word_count[x] += 1
}
count_occurrences(word_count, 'vile', 5)
count_occurrences(word_count, 'knave', 5)
count_occurrences(word_count, 'wherefore', 5)
count_occurrences(word_count, 'love', 100)
count_occurrences2(word_count, 42)
top_x(word_count, 40).each{|word,count| puts "(#{count}) #{word}"}

# perfor an action 3 times
#3.times {
#	puts "Yay!"
#}

