package main

import "fmt"

func search(a []int, t int, d int) int {
	n := len(a)
	left, right := 0, n-1
	res := -1
	for left <= right {
		mid := (left + right) >> 1
		if a[mid] == t {
			res = mid
			if d == 1 {
				left = mid + 1
			} else {
				right = mid - 1
			}
		} else if a[mid] > t {
			right = mid - 1
		} else {
			left = mid + 1
		}
	}
	return res
}

func searchRange(a []int, t int) []int {
	pl := search(a, t, -1)
	pr := search(a, t, 1)
	return []int{pl, pr}
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
	res := searchRange(a, t)
	fmt.Println(res)
}
