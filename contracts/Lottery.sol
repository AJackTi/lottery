pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address public manager;
    address[] public players;

    constructor() public {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .01 ether);

        players.push(msg.sender);
    }

    function random() private restricted view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    function pickWinner() public restricted {
        uint index = random() % players.length;
        payable(players[index]).transfer(address(this).balance);
        players = new address[](0); // length = 0
    }

    function getPlayers() public view returns(address[] memory) {
        return players;
    }

    function getBalanceThisContract() public restricted view returns(uint) {
        return address(this).balance;
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
}