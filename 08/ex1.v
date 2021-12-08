import os

fn main() {
    data := os.read_lines(os.args[1])?

	mut count := 0
	for row in data {
		parts := row.split('|')
		println(parts)
		digits := parts[1].split(' ')
		for digit in digits {
			println(":$digit:")
			if digit.len == 2 {
				count++
			} else if digit.len == 3 {
				count++
			} else if digit.len == 7 {
				count++
			} else if digit.len == 4{
				count++
			}
		}
	}

	println(count)
}