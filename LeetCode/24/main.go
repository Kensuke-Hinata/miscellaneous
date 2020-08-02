package main

import "fmt"

type ListNode struct {
	Val  int
	Next *ListNode
}

func swapPairs(head *ListNode) *ListNode {
	if head == nil {
		return nil
	}
	if head.Next == nil {
		return head
	}
	ret := swapPairs(head.Next.Next)
	head.Next.Next = head
	res := head.Next
	head.Next = ret
	return res
}

func input() *ListNode {
	var L int
	fmt.Scanf("%d", &L)
	var head *ListNode
	var prev *ListNode
	for i := 0; i < L; i++ {
		var val int
		fmt.Scanf("%d", &val)
		node := new(ListNode)
		node.Val = val
		node.Next = nil
		if head == nil {
			head = node
		} else {
			prev.Next = node
		}
		prev = node
	}
	return head
}

func output(list *ListNode) {
	for list != nil {
		fmt.Print(list.Val, " ")
		list = list.Next
	}
}

func main() {
	L := input()
	ret := swapPairs(L)
	output(ret)
}
