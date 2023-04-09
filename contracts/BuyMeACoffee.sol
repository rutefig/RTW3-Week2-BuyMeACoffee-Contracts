// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

// Deployed at 0xaBF6f514c0733E6606FcDBb7F51aA9ee76d80740

contract BuyMeACoffee {

    // Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struc
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // Address of contract deployer. Marked as payable so that
    // we can withdraw to this address later
    address payable owner;

    // List of all memos received from coffee purchases
    Memo[] memos;

    constructor() {
        // Store the address of the deployer as a payable address
        // When we withdray funds, we'll withdraw here
        owner = payable(msg.sender);
    }

    /**
     * @dev fetches all stored memos
     */
    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }

    /** */
    function getOwner() public view returns (address) {
        return owner;
    }

    /**
     * @dev buy a coffee for owner (sends an ETH tip and leaves a memo
     * @param _name name of the coffee purchaser
     * @param _message a nice message from the purchaser
     */
    function buyCoffee(string memory _name, string memory _message) public payable {
        // Must accept more than 0 ETH for a coffee
        require(msg.value > 0, "can't buy coffee for free!");

        // Add the memo to storage!
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a NewMemo event with details about the memo
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /**
     * @dev send the entire balance stored in this contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /**
     * @dev transfer the "ownership" of the contract wallet
     */
    function transferOwnership(address to) public {
        require(msg.sender == owner, "Only the owner can transfer ownership to someone else!");
        owner = payable(to);
    }
}
