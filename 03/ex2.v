import os

fn find_common(data []string, high bool, bit_index int) int {
	data_length_float := f32(data.len)
        if data.len == 1 {
                return ('0b'+data[0]).int()
        }

        mut count := 0
        
        for item in data {
                if item[bit_index] == `1` {
                        count++
                }
        }

        mut search_param := `0`

        if high {
                if count >= data_length_float/2 {
                        search_param = `1`
                }
        } else {
                if count >= data_length_float/2 {
                        search_param = `0`
                } else {
                        search_param = `1`
                }
        }
        
        items_left := data.filter(it[bit_index] == search_param)

        return find_common(items_left, high, bit_index+1)

}

fn main() {
        data := os.read_lines('input.data')?

        oxygen := find_common(data, true, 0)

        co2 := find_common(data, false, 0)

	print("$oxygen * $co2 = ")
        println(oxygen*co2) 
}
