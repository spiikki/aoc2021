import os

fn main() {
    data := os.read_lines(os.args[1])?

	openers := [ `(`, `[`, `{`, `<` ]
	closers := [ `)`, `]`, `}`, `>` ]

	char_map := {
		`)`: `(`
		`]`: `[`
		`}`: `{`
		`>`: `<`
	}

	score_map := {
		`)`: 3
		`]`: 57
		`}`: 1197
		`>`: 25137
	}

	mut total_score := 0

	for row in data {
		mut chunk_trail := []byte{}
		for char in row {
			if char in openers {
				chunk_trail << char
			} else {
				if char_map[char] != chunk_trail.last() {
					println("error!")
					total_score += score_map[char]
					break
				} else {
					chunk_trail.pop()
				}
			}
			println(chunk_trail)
		}

	}

	println(total_score)
}