package main

import "fmt"

func search(a []int, t int) int {
	n := len(a)
	left, right := 0, n-1
	for left <= right {
		mid := (left + right) >> 1
		if a[mid] == t {
			return mid
		} else if a[mid] > t {
			if a[left] <= a[right] {
				right = mid - 1
			} else {
				if a[mid] >= a[left] && t < a[left] {
					left = mid + 1
				} else {
					right = mid - 1
				}
			}
		} else {
			if a[left] <= a[right] {
				left = mid + 1
			} else {
				if a[mid] <= a[right] && t > a[right] {
					right = mid - 1
				} else {
					left = mid + 1
				}
			}
		}
	}
	return -1
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
	res := search(a, t)
	fmt.Println(res)
}
