package main

import "fmt"

func divide(dividend int, divisor int) int {
	pdividend := int64(dividend)
	if dividend < 0 {
		pdividend = -(int64(pdividend))
	}
	pdivisor := int64(divisor)
	if divisor < 0 {
		pdivisor = -(int64(divisor))
	}
	var res int64
	left, right := int64(1), (int64(1))<<31
	for left <= right {
		mid := (left + right) >> 1
		mul := pdivisor
		var sum int64
		for i := mid; i >= 1; i >>= 1 {
			if (i & 1) != 0 {
				sum += mul
				if sum > pdividend {
					break
				}
			}
			mul <<= 1
		}
		if sum > pdividend {
			right = mid - 1
		} else {
			left = mid + 1
			res = mid
		}
	}
	if dividend < 0 && divisor > 0 || dividend > 0 && divisor < 0 {
		res = -res
	}
	if res < -((int64(1))<<31) || res > ((int64(1))<<31)-1 {
		res = ((int64(1)) << 31) - 1
	}
	return int(res)
}

func main() {
	var dividend, divisor int
	fmt.Scanf("%d %d", &dividend, &divisor)
	res := divide(dividend, divisor)
	fmt.Println(res)
}
