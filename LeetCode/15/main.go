package main

import (
	"fmt"
	"sort"
)

func threeSum(a []int) [][]int {
	sort.Ints(a)
	m := make(map[int]int)
	for i := len(a) - 1; i >= 0 && a[i] >= 0; i-- {
		if _, ok := m[a[i]]; !ok {
			m[a[i]] = 1
		} else {
			m[a[i]]++
		}
	}
	res := make([][]int, 0)
	for i := 0; i < len(a); i++ {
		if i > 0 && a[i] == a[i-1] {
			continue
		}
		for j := i + 1; j < len(a); j++ {
			if j > i+1 && a[j] == a[j-1] {
				continue
			}
			s := a[i] + a[j]
			if -s < a[j] {
				break
			}
			if cnt, ok := m[-s]; ok {
				if -s == a[j] {
					if a[i] == a[j] && cnt < 3 {
						continue
					}
					if a[i] < a[j] && cnt < 2 {
						continue
					}
				}
				t := make([]int, 3)
				t[0], t[1], t[2] = a[i], a[j], -s
				res = append(res, t)
			}
		}
	}
	return res
}

func main() {
	var n int
	fmt.Scanf("%d", &n)
	a := make([]int, n)
	for i := 0; i < n; i++ {
		fmt.Scanf("%d", &a[i])
	}
	res := threeSum(a)
	for i := 0; i < len(res); i++ {
		fmt.Println(res[i])
	}
}
