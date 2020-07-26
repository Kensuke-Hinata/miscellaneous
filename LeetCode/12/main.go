package main

import "fmt"

func intToRoman(num int) string {
	symbol := []string{"M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"}
	val := []int{1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1}
	res := ""
	for i := 0; num > 0 && i < len(val); i++ {
		for j := 0; j < num/val[i]; j++ {
			res += symbol[i]
		}
		num %= val[i]
	}
	return res
}

func main() {
	var num int
	fmt.Scanf("%d", &num)
	fmt.Println(intToRoman(num))
}
