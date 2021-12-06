import os

fn process_days(mut fishes []i64, days int) i64{
	new_fishes := fishes[0]
	for index in 1 .. 9 {
		fishes[index-1] = fishes[index]
	}
	fishes[6] += new_fishes
	fishes[8] = new_fishes

	print("days left $days:")
	println(fishes)

	if days == 1 {
		mut sum := i64(0)
		for item in fishes {
			sum += item
		}
		return sum
	}

	return process_days(mut fishes, days-1)
}

fn main() {
    data := os.read_lines(os.args[1])?
	mut fishes := []i64{len: 9}

	for item in data[0].split(',') {
		fishes[item.int()] += 1
	}

	println("initial: $fishes")

	println(process_days(mut fishes, 256))
}