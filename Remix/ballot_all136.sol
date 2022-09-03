pragma solidity ^0.4.17;
// contract Numbers {
//     int[] public numbers;

//     function Numbers() public {
//         numbers.push(20);
//         numbers.push(32);

//         // int[] storage myArray = numbers;
//         // myArray[0] = 1;
//         changeArray(numbers);
//     }

//     function changeArray(int[] storage myArray) private{
//         myArray[1] = 1;
//     }
// }



contract Campaign {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }

    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    uint public approversCount;

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    function Campaign(uint minimum) public {
        manager = msg.sender;
        minimumContribution = minimum;
    }

    function contribute() public payable {
        require(msg.value > minimumContribution);

        approvers[msg.sender] = true;
        approversCount++;
    }

    function createRequest(string description, uint value, address recipient) public restricted {
        Request memory newRequest = Request({
           description: description,
           value: value,
           recipient: recipient,
           complete: false,
           approvalCount: 0
        });

        requests.push(newRequest);
    }

    function approveRequest(uint index) public {
        Request storage request = requests[index];

        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);

        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }

    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];

        require(request.approvalCount > (approversCount / 2));
        require(!request.complete);

        request.recipient.transfer(request.value);
        request.complete = true;
    }
}


// contract Lottery {
//     address public manager;
//     address[] public players;
    
//     function Lottery() public {
//         manager = msg.sender;
//     }
    
//     function enter() public payable {
//         require(msg.value > .01 ether);
//         players.push(msg.sender);
//     }
    
//     function random() private view returns (uint) {
//         return uint(keccak256(block.difficulty, now, players));
//     }
    
//     function pickWinner() public restricted {
//         uint index = random() % players.length;
//         players[index].transfer(this.balance);
//         players = new address[](0);
//     }
    
//     modifier restricted() {
//         require(msg.sender == manager);
//         _;
//     }
    
//     function getPlayers()  public view returns (address[]) {
//         return players;
//     }
    
// }   

// contract Test {
//     string[] public myArray;

//     function Test() public {
//         myArray.push("hi");
//         // myArray.push(1);
//         // myArray.push(10);
//         // myArray.push(30);
//     }
//     function getMyArray() public  returns (string[]) {
//         return myArray;
//     }

//     // function getArrayLength() public view returns (uint) {
//     //     return myArray.length;
//     // }
//     // function getFirstElement() public view return (uint) {
//     //     return myArray[0]
//     // }
// }