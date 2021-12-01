import os

fn main() {
        data := os.read_lines('input.data')?
        mut previous := 0
        mut inc_count := 0
        mut sum := 0
        for index, measurement in data {
                if index > data.len-3 {
                        break
                }

                sum = measurement.int() + data[index+1].int() + data[index+2].int()

                if index == 0 {
                        previous = sum
                        continue
                }

		if measurement == '' {
                        continue
                }

                if sum > previous {
                        inc_count++
                }

		previous = sum
        }
        println(inc_count)
}
