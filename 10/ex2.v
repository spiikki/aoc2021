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
		`(`: 1
		`[`: 2
		`{`: 3
		`<`: 4
	}

	mut scores := []i64{}

	for row in data {
		mut chunk_trail := []byte{}
		mut fault := false

		for char in row {
			if char in openers {
				chunk_trail << char
			} else {
				if char_map[char] != chunk_trail.last() {
					println("error, skip!")
					fault = true
					break
				} else {
					chunk_trail.pop()
				}
			}
		}

		if !fault {
			if chunk_trail.len > 0 {
				println("incomplete!")
				mut total_score := i64(0)
				loop := chunk_trail.len
				for _ in 0 .. loop {
					item := chunk_trail.pop()
					total_score = total_score*5+score_map[item]
				}
				scores << total_score
			}
		}
	}

	println(scores)
	scores.sort()
	println(scores[scores.len/2])
}