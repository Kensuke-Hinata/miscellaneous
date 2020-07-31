package main

import "fmt"

type ListNode struct {
	Val  int
	Next *ListNode
}

func removeNthFromEnd(head *ListNode, n int) *ListNode {
	if head == nil {
		return nil
	}
	cnt := 0
	p := head
	for p != nil {
		cnt++
		p = p.Next
	}
	if n == cnt {
		return head.Next
	}
	p = head
	idx := 0
	for p.Next != nil {
		idx++
		if idx+n == cnt {
			p.Next = p.Next.Next
			break
		}
		p = p.Next
	}
	return head
}

func input() *ListNode {
	var n int
	fmt.Scanf("%d", &n)
	var head *ListNode
	var prev *ListNode
	for i := 0; i < n; i++ {
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
	var n int
	fmt.Scanf("%d", &n)
	ret := removeNthFromEnd(L, n)
	output(ret)
}
