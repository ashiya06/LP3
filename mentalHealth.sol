// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MentalHealthRecords {

    // Define the owner of the contract (could be a clinic or mental health service provider)
    address public owner;

    // Constructor to set the owner at deployment
    constructor() {
        owner = msg.sender;
    }

    // Structure to store mental health session details
    struct MentalHealthSession {
        string patientName;
        string patientID;
        uint sessionDate;
        string sessionNotes;
        string diagnosis;
        string treatmentPlan;
        string therapist;
    }

    // Mapping of patient IDs to their mental health sessions
    mapping(string => MentalHealthSession[]) private sessions;

    // Event emitted when a new session is added
    event MentalHealthSessionAdded(string patientID, string therapist, uint sessionDate);

    // Modifier to restrict access to the owner (mental health service provider)
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Function to add a new mental health session (only owner/authorized)
    function addMentalHealthSession(
        string memory _patientName,
        string memory _patientID,
        uint _sessionDate,
        string memory _sessionNotes,
        string memory _diagnosis,
        string memory _treatmentPlan,
        string memory _therapist
    ) public onlyOwner {

        MentalHealthSession memory newSession = MentalHealthSession({
            patientName: _patientName,
            patientID: _patientID,
            sessionDate: _sessionDate,
            sessionNotes: _sessionNotes,
            diagnosis: _diagnosis,
            treatmentPlan: _treatmentPlan,
            therapist: _therapist
        });

        sessions[_patientID].push(newSession);

        emit MentalHealthSessionAdded(_patientID, _therapist, _sessionDate);
    }

    // Function to get mental health sessions of a patient by their ID
    function getMentalHealthSessions(string memory _patientID) public view returns (MentalHealthSession[] memory) {
        return sessions[_patientID];
    }

    // Function to check if a patient has any mental health sessions
    function hasMentalHealthSessions(string memory _patientID) public view returns (bool) {
        return sessions[_patientID].length > 0;
    }

    // Function to transfer ownership of the contract (only owner can do this)
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner must be a valid address");
        owner = newOwner;
    }
}
