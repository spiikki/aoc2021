import os

fn main() {
        data := os.read_lines('example.data')?
        mut count_high := []int{len:data[0].len, init:0}

        for index, log in data {

		if log == '' {
                        continue
                }

                for vindex, value in log {
                        if value == `1` {
                                count_high[vindex]++
                        }
                }
        }
        println("$count_high")
        mut result := '0b'
        mut inverse_result := '0b'
        for byte in count_high {
                if byte > data.len/2 {
                        result+='1'
                        inverse_result+='0'
                } else {
                        result+="0"
                        inverse_result+='1'
                }
        }
        println(result.int() * inverse_result.int())
}
