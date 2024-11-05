// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Charity {

    // Owner (the charity organizer)
    address public owner;

    // Total donations received
    uint public totalDonations;

    // Donor structure to track donations from each donor
    struct Donor {
        address donorAddress;
        uint amount;
    }

    // Array to store donor details
    Donor[] public donors;

    // Mapping to check if an address has donated
    mapping(address => uint) public donations;

    // Event triggered whenever a donation is made
    event DonationReceived(address indexed donor, uint amount);

    // Event triggered whenever funds are withdrawn
    event FundsWithdrawn(address indexed owner, uint amount);

    // Modifier to restrict certain functions to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Constructor to initialize contract with the owner
    constructor() {
        owner = msg.sender;
        totalDonations = 0;
    }

    // Function to make a donation
    function donate() public payable {
        require(msg.value > 0, "Donation must be greater than zero");

        // Update total donations
        totalDonations += msg.value;

        // Check if the donor has already donated, update their donation amount
        if (donations[msg.sender] == 0) {
            donors.push(Donor(msg.sender, msg.value));
        } else {
            for (uint i = 0; i < donors.length; i++) {
                if (donors[i].donorAddress == msg.sender) {
                    donors[i].amount += msg.value;
                    break;
                }
            }
        }

        // Update the donations mapping
        donations[msg.sender] += msg.value;

        // Emit event for the donation
        emit DonationReceived(msg.sender, msg.value);
    }

    // Function to withdraw all donations (only accessible by the owner)
    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        // Transfer the contract balance to the owner
        payable(owner).transfer(balance);

        // Emit event for the withdrawal
        emit FundsWithdrawn(owner, balance);
    }

    // Function to get the number of donors
    function getDonorCount() public view returns (uint) {
        return donors.length;
    }

    // Function to get the total balance in the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Function to get donor details by index
    function getDonorDetails(uint _index) public view returns (address, uint) {
        require(_index < donors.length, "Invalid donor index");
        Donor memory donor = donors[_index];
        return (donor.donorAddress, donor.amount);
    }
}
