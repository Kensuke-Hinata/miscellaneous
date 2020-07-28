package main

import (
	"fmt"
	"math"
	"sort"
)

func threeSumClosest(a []int, t int) int {
	sort.Ints(a)
	dist := math.MaxInt32
	opt := math.MaxInt32
	for i := 0; i < len(a); i++ {
		for j := i + 1; j < len(a); j++ {
			left, right := j+1, len(a)-1
			for left <= right {
				mid := (left + right) >> 1
				sum := a[i] + a[j] + a[mid]
				if sum == t {
					return sum
				}
				if sum > t {
					if sum-t < dist {
						dist = sum - t
						opt = sum
					}
					right = mid - 1
				} else {
					if t-sum < dist {
						dist = t - sum
						opt = sum
					}
					left = mid + 1
				}
			}
		}
	}
	return opt
}

func main() {
	var n int
	fmt.Scanf("%d", &n)
	a := make([]int, n)
	for i := 0; i < n; i++ {
		fmt.Scanf("%d", &a[i])
	}
	var t int
	fmt.Scanf("%d", &t)
	res := threeSumClosest(a, t)
	fmt.Println(res)
}
