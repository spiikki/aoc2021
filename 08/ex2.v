import os

fn string_diff(input string, reference string) string{
	mut result := ''
	for digit in input {
		if digit in reference.bytes() {
			result += digit.ascii_str()
		}
	}
//	println("input: $input to $reference -> $result")
	return result
}

fn string_diff_neg(input string, reference string) string{
	mut result := ''
	for digit in input {
		if digit !in reference.bytes() {
			result += digit.ascii_str()
		}
	}
//	println("input: $input to $reference -> $result")
	return result
}

fn main() {
    data := os.read_lines(os.args[1])?

	mut sum := 0

	for row in data {
		parts := row.split('|')
		println(parts[1])
		definitions := parts[0].split(' ')
		mut known_numbers := map[int]string{}
		for def in definitions {
			if def.len == 2 {
				known_numbers[1] = def
			} else if def.len == 3 {
				known_numbers[7] = def
			} else if def.len == 7 {
				known_numbers[8] = def
			} else if def.len == 4{
				known_numbers[4] = def
			}		
		}
		println(known_numbers)
		digits := parts[1].split(' ')
		mut numbers := ''
		for digit in digits {
//			println(digit)
//			println(":$digit:")
			if digit.len == 2 {
				numbers += '1'
			} else if digit.len == 3 {
				numbers += '7'
			} else if digit.len == 7 {
				numbers += '8'
			} else if digit.len == 4{
				numbers += '4'
			} else if digit.len == 5 {
				// sort 2, 3, 5
				from_one := string_diff_neg(digit, known_numbers[4])
				if from_one.len == 3 {
					numbers += '2'
				} else {
					different := string_diff_neg(digit, known_numbers[1])
					if different.len == 4 {
						numbers += '5'
					} else {
						numbers += '3'
					}					
				}
			} else if digit.len == 6 {
				// sort 0, 6, 9
				from_one := string_diff(digit, known_numbers[4])
				if from_one.len == 4 {
					numbers += '9'
				} else {
					different := string_diff(digit, known_numbers[1])
					if different.len == 2 {
						numbers += '0'
					} else {
						numbers += '6'
					}					
				}
			}
		}
		println(numbers)
		sum += numbers.int()
	}
	println(sum)
}