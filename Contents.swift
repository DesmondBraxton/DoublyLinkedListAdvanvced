import UIKit

struct DoublyLinkedList<DataItem> {

    fileprivate var head : Node<DataItem>?
    fileprivate var tail : Node<DataItem>?
    var isEmpty : Bool {
        return head == nil
    }

    //to add at the beginning
    mutating func InsertAtBeginning(_ dataItem : DataItem) {
        let node = Node(dataItem: dataItem, nextNode: head, previousNode: nil)
        head?.previousNode = node
        head = node
        if tail == nil {
            tail = head
        }
    }

    //to add at the end
    mutating func insertAtEnd(_ dataItem : DataItem) {
        guard !isEmpty else {
            InsertAtBeginning(dataItem)
            return
        }

        let newNode = Node(dataItem: dataItem, nextNode: nil, previousNode: tail)
        tail?.nextNode = newNode
        //newNode.previousNode = tail
        tail = newNode

    }

    //to insert at particular node
    func insertParticularly(_ dataItem : DataItem , afterNode : Node<DataItem>) {
        let node = Node(dataItem: dataItem)
        afterNode.nextNode?.previousNode = node
        node.nextNode = afterNode.nextNode
        afterNode.nextNode = node
        node.previousNode = afterNode
    }

    //to find a node at particular index
    func findNode(at index : Int) -> Node<DataItem>? {
        var currentIndex = 0
        var currentNode =  head
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.nextNode
            currentIndex += 1
        }
        return currentNode
    }

    //MARK:- remove functionality

    //remove the first element
    mutating func removeFirst() -> DataItem? {

        defer {
            head = head?.nextNode
            if isEmpty {
                head = nil
            }
        }

        return head?.dataItem
    }

    // remove the last element
    mutating func removeLast() -> DataItem? {


        guard let headValue = head else {
            return nil
        }

        guard headValue.nextNode != nil else {
            return removeFirst()
        }

        var previous = headValue
        var current = headValue

        while let next = current.nextNode {
            previous = current
            current = next
        }

        previous.nextNode = nil
        tail = previous
        return current.dataItem

    }

    // remove from a specific location
    mutating func removeAt(at node : Node<DataItem>?) -> DataItem? {
        defer {
            if node === tail {
                removeLast()
            }
            node?.previousNode?.nextNode = node?.nextNode
            node?.nextNode?.previousNode = node?.previousNode
        }
        return node?.nextNode?.dataItem
    }

}

extension DoublyLinkedList : CustomStringConvertible {

    var description : String {
        guard let doublyLinkedListHead = head else { return "UnderFlow"}
        //return String(describing: doublyLinkedListHead)
        return doublyLinkedListHead.linkedDescription
    }

}

class Node<DataItem> {
    var dataItem : DataItem
    var nextNode : Node?
    var previousNode : Node?



    init(dataItem : DataItem , nextNode : Node? = nil , previousNode : Node? = nil) {
        self.dataItem = dataItem
        self.nextNode = nextNode
        self.previousNode = previousNode
    }
}

extension Node : CustomStringConvertible {

    var description: String {
        return ((previousNode == nil) ? "nil" : "\(previousNode!.dataItem)") +
                " <-> \(dataItem) <-> " +
            ((nextNode == nil) ? "nil" : "\(nextNode!.dataItem)")
    }
        var linkedDescription: String {
            return "\(dataItem)" + ((nextNode == nil) ? "" : " <-> \(nextNode!.linkedDescription)")

        }

}

var list = DoublyLinkedList<Int>()
list.InsertAtBeginning(4)
list.insertAtEnd(5)
list.insertAtEnd(4)
list.insertAtEnd(7)
list.insertAtEnd(2)
list.insertAtEnd(0)

list.description
let node1 = list.findNode(at: 3)
node1?.previousNode
list.head
