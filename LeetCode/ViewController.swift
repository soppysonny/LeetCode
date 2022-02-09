//
//  ViewController.swift
//  LeetCode
//
//  Created by zhang ming on 2022/2/1.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let l1 = ListNode(2)
        l1.next = ListNode(3)
        l1.next?.next = ListNode(4)

        let l2 = ListNode(8)
        l2.next = ListNode(9)
        l2.next?.next = ListNode(6)


        let res = Solution().addTwoNumbers(l1, l2)
        print(res)
  
        
    }


}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Solution {
    func listNodeToNumber(_ node: ListNode?) -> Int {
        var node: ListNode? = node
        var num = 0
        var y: Int = 0
        while node != nil {
            let plus = Int(pow(10, Double(y))) * (node?.val ?? 1)
            num += Int(plus)
            node = node?.next
            y += 1
        }
        return num
    }
    
    func numberToListNode(_ num: Int) -> ListNode {
        var y: Int = 1
        var node: ListNode? = nil
        var currentNode = node
        var currentTotal = 0
        while Decimal(currentTotal) < Decimal(num) {
            let base = pow(10, Double(y))
            let lastBase = pow(10, Double(y - 1))
            let val = (num % Int(base) - currentTotal) / (lastBase < 1 ? 1 : Int(lastBase))
            if node == nil {
                node = ListNode(val)
                currentNode = node
            } else {
                currentNode?.next = ListNode(val)
                currentNode = currentNode?.next
                print(val)
            }
            currentTotal += val * Int(lastBase)
            y += 1
        }
        return node ?? ListNode()
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        var l1 = l1, l2 = l2
        var res = ListNode(0)
        var shouldPlusOne = res.val >= 10
        if shouldPlusOne {
            res.val -= 10
        }
        var res_CurrentNode: ListNode? = nil
        while l1 != nil || l2 != nil || shouldPlusOne {
            var plus = 0
            
            if res_CurrentNode != nil {
                plus = (l1?.val ?? 0) + (l2?.val ?? 0) + (shouldPlusOne ? 1 : 0)
                if shouldPlusOne {
                    shouldPlusOne = false
                }
                if plus >= 10 {
                    shouldPlusOne = true
                    plus -= 10
                }
                let nextNode = ListNode(plus)
                res_CurrentNode?.next = nextNode
                res_CurrentNode = nextNode
                
            } else {
                plus = (l1?.val ?? 0) + (l2?.val ?? 0)
                if plus >= 10 {
                    shouldPlusOne = true
                    plus -= 10
                }
                res_CurrentNode = ListNode(plus)
                res = res_CurrentNode!
            }
            l1 = l1?.next
            l2 = l2?.next
        }
        return res
        /** 数字太大时会溢出 */
//        let l1 = l1 ?? ListNode(0)
//        let l2 = l2 ?? ListNode(0)
//        let solution = Solution()
//        return solution.numberToListNode(solution.listNodeToNumber(l1) +
//                                         solution.listNodeToNumber(l2))
    }
}
