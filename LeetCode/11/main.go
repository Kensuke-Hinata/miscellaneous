package main

import "fmt"

func maxArea(height []int) int {
	n := len(height)
	if n == 0 {
		return 0
	}
	lmax := make([]int, n)
	lmax[0] = height[0]
	for i := 1; i < n; i++ {
		lmax[i] = lmax[i-1]
		if height[i] > lmax[i] {
			lmax[i] = height[i]
		}
	}
	rmax := make([]int, n)
	rmax[n-1] = height[n-1]
	for i := n - 2; i >= 0; i-- {
		rmax[i] = rmax[i+1]
		if height[i] > rmax[i] {
			rmax[i] = height[i]
		}
	}
	ans := 0
	for i := 0; i < n; i++ {
		pos := -1
		left, right := 0, i-1
		for left <= right {
			mid := (left + right) >> 1
			if lmax[mid] < height[i] {
				left = mid + 1
			} else {
				right = mid - 1
				pos = mid
			}
		}
		if pos != -1 && height[i]*(i-pos) > ans {
			ans = height[i] * (i - pos)
		}
		pos = -1
		left, right = i+1, n-1
		for left <= right {
			mid := (left + right) >> 1
			if rmax[mid] < height[i] {
				right = mid - 1
			} else {
				left = mid + 1
				pos = mid
			}
		}
		if pos != -1 && height[i]*(pos-i) > ans {
			ans = height[i] * (pos - i)
		}
	}
	return ans
}

func main() {
	var n int
	fmt.Scanf("%d", &n)
	height := make([]int, 0)
	for i := 0; i < n; i++ {
		var h int
		fmt.Scanf("%d", &h)
		height = append(height, h)
	}
	fmt.Println(maxArea(height))
}
