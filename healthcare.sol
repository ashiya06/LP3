// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalRecords {

    // Define the owner of the contract (usually a healthcare organization or authority)
    address public owner;

    // Constructor to set the owner at deployment
    constructor() {
        owner = msg.sender;
    }

    // Structure to represent medical record details
    struct MedicalRecord {
        string patientName;
        string patientID;
        uint dateOfRecord;
        string diagnosis;
        string treatment;
        string doctor;
    }

    // Mapping of patient IDs to their medical records
    mapping(string => MedicalRecord[]) private medicalRecords;

    // Event for when a medical record is added
    event MedicalRecordAdded(string patientID, string patientName, uint dateOfRecord);

    // Modifier to restrict certain functions to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Function to add a new medical record (only accessible by owner)
    function addMedicalRecord(
        string memory _patientName, 
        string memory _patientID, 
        uint _dateOfRecord, 
        string memory _diagnosis, 
        string memory _treatment, 
        string memory _doctor
    ) public onlyOwner {

        MedicalRecord memory newRecord = MedicalRecord({
            patientName: _patientName,
            patientID: _patientID,
            dateOfRecord: _dateOfRecord,
            diagnosis: _diagnosis,
            treatment: _treatment,
            doctor: _doctor
        });

        medicalRecords[_patientID].push(newRecord);

        emit MedicalRecordAdded(_patientID, _patientName, _dateOfRecord);
    }

    // Function to get medical records of a patient by their patient ID
    function getMedicalRecords(string memory _patientID) public view returns (MedicalRecord[] memory) {
        return medicalRecords[_patientID];
    }

    // Function to check if a patient has records
    function hasMedicalRecords(string memory _patientID) public view returns (bool) {
        return medicalRecords[_patientID].length > 0;
    }

    // Function to transfer ownership of the contract (onlyOwner)
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner must be a valid address");
        owner = newOwner;
    }
}
