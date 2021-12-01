import os

fn main() {
        data := os.read_lines('input.data')?
        mut previous := 0
        mut inc_count := 0
        for index, measurement in data {
                if index == 0 {
                        previous = measurement.int() 
                        continue
                }

		if measurement == '' {
		        continue
		}
		
                if measurement.int() > previous {
                        inc_count++
                }
		previous = measurement.int()
        }
        println(inc_count)
}
