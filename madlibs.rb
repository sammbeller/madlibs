def driver_loop
	puts "Please input the name of the file you would like to use."
	filename = gets
	file = File.new(filename, "rb")
	fulltext = file.read
	file.close

	if fulltext.match(/\([\w\s]+\|\|[\w\s]+\)/)
		find_next_prompt(fulltext)
	else
		puts "OK we're done, this is what we have \n#{fulltext}"
	end

	puts "Would you like to play again?"
	resp = gets
	resp.downcase
	if gets == "y" || gets == "yes"
		driver_loop
	else
		puts "That was fun, let's play again later!"
	end
end

def replace(fulltext, paired_values, new_value)
	fulltext.gsub!(paired_values, new_value)
end

def find_next_prompt(fulltext)
	paired_values = fulltext.match(/\([\w\s]+\|\|[\w\s]+\)/)
	prompt = parse_prompt(paired_values)
	puts "I need #{prompt}"
	new_value = gets
	replace(fulltext, paired_values, new_value)
end

def parse_prompt(paired_values)
	nvalue = paired_values.slice(1..(1.length - 2))
	split = nvalue.split("||")
	split[1]
end




puts "let's play a game of Mad-Libs!"
puts Dir.pwd
driver_loop




