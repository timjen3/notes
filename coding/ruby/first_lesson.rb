FILE_NAME = "romeo-juliet.txt"

=begin
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
=end

# read text
def get_words_from_file(file_name)
	begin
		# read file          #lower   #regex-replace      #string split
		File.read(file_name).downcase.gsub(/[^a-z]/, ' ').split(' ')
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

words = get_words_from_file(FILE_NAME)
puts "Length is " + words.length.to_s
puts "Distinct length is " + words.uniq.length.to_s

# some array indexing
first_word = words[0]
last_word = words[-1]
last_7_words = words[-7..-1]
last_7_words2 = words[-7..]
last_7_words_minus_1 = words[-7...]

# some demo code
word_count = {}
word_count.default = 0
words.each {|x|
	word_count[x] += 1
}
count_occurrences(word_count, 'vile', 5)
count_occurrences(word_count, 'knave', 5)
count_occurrences(word_count, 'wherefore', 5)
count_occurrences(word_count, 'be', 5)
count_occurrences2(word_count, 42)

# perfor an action 3 times
3.times {
	puts "Yay!"
}
