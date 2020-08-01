package main

import "fmt"

func recur(n int, c [][]string) []string {
	if n <= 0 {
		return []string{""}
	}
	if len(c[n]) > 0 {
		return c[n]
	}
	for i := 2; i <= n; i += 2 {
		ret0 := recur(i-2, c)
		ret1 := recur(n-i, c)
		for j := 0; j < len(ret0); j++ {
			for k := 0; k < len(ret1); k++ {
				s := "(" + ret0[j] + ")" + ret1[k]
				c[n] = append(c[n], s)
			}
		}
	}
	return c[n]
}

func generateParenthesis(n int) []string {
	c := make([][]string, (n<<1)+1)
	return recur(n<<1, c)
}

func main() {
	var n int
	fmt.Scanf("%d", &n)
	res := generateParenthesis(n)
	fmt.Println(len(res))
}
