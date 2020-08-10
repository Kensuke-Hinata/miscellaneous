package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func multiply(num1 string, num2 string) string {
	n1, n2 := len(num1), len(num2)
	b := make([]int, n1+n2+2)
	for i := 0; i < n1; i++ {
		for j := 0; j < n2; j++ {
			val := int(num1[n1-1-i]-'0') * int(num2[n2-1-j]-'0')
			high, low := val/10, val%10
			b[i+j] += low
			if b[i+j] >= 10 {
				high++
				b[i+j] -= 10
			}
			for c, idx := high, i+j+1; c > 0; idx++ {
				b[idx] += c
				c = 0
				if b[idx] >= 10 {
					c = 1
					b[idx] -= 10
				}
			}
		}
	}
	res := ""
	for i := n1 + n2 + 1; i >= 0; i-- {
		res += string('0' + b[i])
	}
	for i := 0; i < n1+n2+2; i++ {
		if res[i] != '0' {
			return res[i:]
		}
	}
	return "0"
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		s := scanner.Text()
		nums := strings.Split(s, " ")
		res := multiply(strings.Trim(nums[0], " "), strings.Trim(nums[1], " "))
		fmt.Println(res)
	}
}
